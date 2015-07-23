package tinkerGUI.controllers

import tinkerGUI.controllers.events.{CurrentGraphChangedEvent, GraphTacticListEvent}
import tinkerGUI.model.PSGraph
import tinkerGUI.model.exceptions.{PSGraphModelException, SubgraphNotFoundException, GraphTacticNotFoundException, AtomicTacticNotFoundException}
import tinkerGUI.utils._
import tinkerGUI.views.ContextMenu

import scala.swing.event.Key.Modifiers
import scala.swing.{Component, Publisher, Action, Dialog}


/** Controller managing the edition of psgraph.
	*
	* @param model Psgraph model.
	*/
class EditController(model:PSGraph) extends Publisher {

	/** Mouse state variable.
		*
		* Keeps track of what is the current edition mode.
		*/
	private var mouseState: MouseState = SelectTool()

	/** Method to update the mouse state.
		*
		* @param state State id.
		*/
	def changeMouseState(state: String) {
		state match {
			case "select" => mouseState = SelectTool()
			case "addIDVertex" => mouseState = AddVertexTool("T_Identity")
			case "addATMVertex" => mouseState = AddVertexTool("T_Atomic")
			case "addNSTVertex" => mouseState = AddVertexTool("T_Graph")
			case "addEdge" => mouseState = AddEdgeTool()
		}
	}

	/** Method to update the mouse state.
		*
		* @param state State id.
		* @param param Potential parameter (e.g. vertex id, coordinates ...).
		*/
	def changeMouseState(state: String, param: Any) {
		param match {
			case s:String =>
				state match {
					case "dragEdge" => mouseState = DragEdge(s)
				}
			case pt:java.awt.Point =>
				state match {
					case "dragVertex" => mouseState = DragVertex(pt, pt)
					case "selectionBox" =>
						val box = SelectionBox(pt, pt)
						mouseState = box
						QuantoLibAPI.viewSelectBox(box)
				}
		}
	}

	/** Method handling a left click on the graph.
		*
		* @param point Coordinates of the click.
		* @param modifiers Potential modifiers of the click.
		* @param clicks Number of clicks.
		*/
	def leftMousePressed(point: java.awt.Point, modifiers: Modifiers, clicks: Int) {
		mouseState match {
			case SelectTool() =>
				if(clicks == 2) {
					QuantoLibAPI.editGraphElement(point)
				}
				else QuantoLibAPI.selectElement(point,modifiers,changeMouseState)
			case AddEdgeTool() => QuantoLibAPI.startAddEdge(point,changeMouseState)
			case _ => //do nothing
		}
	}

	/** Method handling a right click on the graph.
		*
		* @param point Coordinates of the click.
		* @param modifiers Potential modifiers of the click.
		* @param clicks Number of clicks.
		* @param source Source of the click.
		*/
	def rightMousePressed(point: java.awt.Point, modifiers: Modifiers, clicks: Int, source: Component): Unit = {
		def emptyFunc(s:String, a:Any) { }
		QuantoLibAPI.selectElement(point, modifiers, emptyFunc)
		ContextMenu.show(source, point.getX.toInt, point.getY.toInt)
	}

	/** Method handling a mouse drag on the graph.
		*
		* @param point Coordinates of the origin of the drag.
		*/
	def mouseDragged(point: java.awt.Point): Unit = {
		mouseState match {
			case DragVertex(start, prev) =>
				QuantoLibAPI.dragVertex(point, prev)
				mouseState = DragVertex(start,point)
			case SelectionBox(start, _) =>
				val box = SelectionBox(start,point)
				mouseState = box
				QuantoLibAPI.viewSelectBox(box)
			case DragEdge(startV)	=> QuantoLibAPI.dragEdge(startV,point)
			case _ => // do nothing
		}
	}

	/** Method handling a mouse release on the graph.
		*
		* @param point Coordinates of the release.
		* @param modifiers Potential modifiers of the release.
		*/
	def mouseReleased(point: java.awt.Point, modifiers:Modifiers): Unit = {
		mouseState match {
			case DragVertex(start, end) =>
				if(start.getX != end.getX || start.getY != end.getY) {
					//QuantoLibAPI.moveVertex(start, end)
				}
				mouseState = SelectTool()
			case SelectionBox(start, _) =>
				val selectionUpdated = !(point.getX == start.getX && point.getY == start.getY)
				val rect = mouseState.asInstanceOf[SelectionBox].rect
				QuantoLibAPI.viewSelectBoxFinal(selectionUpdated, point, rect)
				mouseState = SelectTool()
				QuantoLibAPI.viewSelectBox()
			case DragEdge(startV) =>
				Service.documentCtrl.registerChanges()
				QuantoLibAPI.endAddEdge(startV, point, changeMouseState)
			case AddVertexTool(typ) =>
				//Service.documentCtrl.registerChanges()
				createNode(typ,point)
				//QuantoLibAPI.userAddVertex(point, typ)
			case _ => // do nothing
		}
	}

	/** Method creating a node and if necessary a tactic.
		*
		* @param typ Type of node, should be "T_Identity", "T_Atomic" or "T_Graph", the latter two will create a tactic in the model.
		* @param pt Coordinates of the node.
		*/
	def createNode(typ:String,pt:java.awt.Point) {
		try{
			Service.documentCtrl.registerChanges()
			typ match {
				case "T_Identity" =>
					QuantoLibAPI.userAddVertex(pt,typ,"")
				case "T_Atomic" =>
					def successCallback(values:Map[String,String]) {
						val name = ArgumentParser.separateNameArgs(values("Name"))._1
						val args = ArgumentParser.separateNameArgs(values("Name"))._2
						val tactic = values("Tactic")
						if(name.isEmpty || tactic.isEmpty){
							TinkerDialog.openEditDialog("Create atomic tactic",values,successCallback,()=>Unit)
						} else {
							if(model.createAT(name,tactic,args)){
								model.addATOccurrence(name,QuantoLibAPI.userAddVertex(pt,typ,model.getATFullName(name)))
							} else {
								var confirmDialog = new Dialog()
								val newAction = new Action("Create new"){
									def apply() = {
										confirmDialog.close()
										TinkerDialog.openEditDialog("Create atomic tactic",values,successCallback,()=>Unit)
									}
								}
								val duplicateAction = new Action("Duplicate tactic"){
									def apply() = {
										confirmDialog.close()
										model.addATOccurrence(name,QuantoLibAPI.userAddVertex(pt,typ,model.getATFullName(name)))
									}
								}
								confirmDialog = TinkerDialog.openConfirmationDialog("The atomic tactic name "+name+" is already taken.",Array(newAction,duplicateAction))
							}
						}
					}
					TinkerDialog.openEditDialog("Create atomic tactic", Map("Name"->"","Tactic"->""),successCallback,()=>Unit)
				case "T_Graph" =>
					def successCallback(values:Map[String,String]) {
						val name = ArgumentParser.separateNameArgs(values("Name"))._1
						val args = ArgumentParser.separateNameArgs(values("Name"))._2
						val branchType = values("Branch type")
						if(name.isEmpty){
							TinkerDialog.openEditDialog("Create graph tactic",values,successCallback,()=>Unit)
						} else {
							if(model.createGT(name,branchType,args)){
								model.addGTOccurrence(name,QuantoLibAPI.userAddVertex(pt,typ,model.getGTFullName(name)))
								publish(GraphTacticListEvent())
							} else {
								var confirmDialog = new Dialog()
								val newAction = new Action("Create new"){
									def apply() = {
										confirmDialog.close()
										TinkerDialog.openEditDialog("Create graph tactic",values,successCallback,()=>Unit)
									}
								}
								val duplicateAction = new Action("Duplicate tactic"){
									def apply() = {
										confirmDialog.close()
										model.addGTOccurrence(name,QuantoLibAPI.userAddVertex(pt,typ,model.getGTFullName(name)))
										publish(GraphTacticListEvent())
									}
								}
								confirmDialog = TinkerDialog.openConfirmationDialog("The graph tactic name "+name+" is already taken.",Array(newAction,duplicateAction))
							}
						}
					}
					TinkerDialog.openEditDialog("Create graph tactic", Map("Name"->"","Branch type"->"OR"),successCallback,()=>Unit)
			}
		} catch {
			case e:PSGraphModelException => TinkerDialog.openErrorDialog(e.msg)
		}
	}

	/** Method deleting a node and removing its occurrence in the model if necessary.
		*
		* @param typ Type of node, should be "T_Identity", "T_Atomic" or "T_Graph", the latter two will remove the occurrence in the model.
		* @param nodeId Id tof the node to delete.
		* @param nodeValue Value associated with the node, i.e. the tactic name if any.
		*/
	def deleteNode(typ:String,nodeId:String,nodeValue:String): Unit ={
		try{
			Service.documentCtrl.registerChanges()
			typ match {
				case "G_Break" => QuantoLibAPI.removeBreakpoint(nodeId)
				case "T_Identity" => QuantoLibAPI.userDeleteElement(nodeId)
				case "T_Atomic" =>
					model.removeATOccurrence(nodeValue,nodeId)
					QuantoLibAPI.userDeleteElement(nodeId)
				case "T_Graph" =>
					if(!(Service.evalCtrl.inEval
						&& Service.evalCtrl.evalPath.contains(model.getCurrentGTName)
						&& Service.evalCtrl.evalPath.contains(nodeValue))){
						model.removeGTOccurrence(nodeValue,nodeId)
						QuantoLibAPI.userDeleteElement(nodeId)
						publish(GraphTacticListEvent())
					}
			}
		} catch {
			case e:PSGraphModelException => TinkerDialog.openErrorDialog(e.msg)
		}
	}

	/** Method to create a tactic with given name and parameters.
		*
		* Does not implement any user interaction.
		* @param nodeId Node id on the graph.
		* @param name Tactic id.
		* @param args Tactic arguments.
		* @param param Tactic parameter (core id for atomic, branchtype for graph).
		* @param isAtomic Whether it is an atomic tactic or not to be created.
		*/
	def createTactic(nodeId:String, name:String, args:String, param:String, isAtomic:Boolean) {
		try{
			if(isAtomic){
				model.createAT(name,param,args)
				model.addATOccurrence(name,nodeId)
			} else {
				model.createGT(name,param,args)
				model.addGTOccurrence(name,nodeId)
			}
		} catch {
			case e:PSGraphModelException => TinkerDialog.openErrorDialog(e.msg)
		}
	}


	/** Method to force the creation of a new default tactic, i.e. does not allow duplication.
		*
		* The user should be asked to update the tactic information after the use of this method.
		*
		* @param nodeId Id of the node the user is creating.
		* @param name Default name given to the tactic (reused for atomic tactic core id).
		* @param isAtomicTactic Boolean stating the nature of the node, atomic of nested.
		*/
	def createNewTactic(nodeId:String, name:String, isAtomicTactic:Boolean):String = {
		var n = if(!isAtomicTactic && name==model.mainTactic.name) "nested" else name // this should prevent a reserved name exception
		var checkedByModel:Boolean =
			if(isAtomicTactic) model.createAT(n, n, "")
			else model.createGT(n,"OR","")
		var i = 0
		while(!checkedByModel){
			i+=1
			n = name+"-"+i
			checkedByModel =
				if(isAtomicTactic) model.createAT(n, n, "")
				else model.createGT(n,"OR","")
		}
		try{
			if(isAtomicTactic) model.addATOccurrence(n,nodeId) else {model.addGTOccurrence(n,nodeId); publish(GraphTacticListEvent())}
		} catch {
			case e:PSGraphModelException => TinkerDialog.openErrorDialog(e.msg)
		}
		n
	}

	/** Method to update a tactic's details.
		*
		* Launched after the user selected the edit option.
		* Launches dialogs to interact with user to get more information on tactic.
		*/
	def updateTactic(nodeId:String, nodeLabel:String, tacticValue:String, isAtomicTactic:Boolean){
		try{
			Service.documentCtrl.registerChanges()
			if(isAtomicTactic){
				def successCallback(values:Map[String,String]) {
					val name = ArgumentParser.separateNameArgs(values("Name"))._1
					val args = ArgumentParser.separateNameArgs(values("Name"))._2
					val tactic = values("Tactic")
					if(name.isEmpty || tactic.isEmpty){
						TinkerDialog.openEditDialog("Edit atomic tactic",values,successCallback,()=>Unit)
					} else {
						if(model.atCollection.contains(name) && name != tacticValue){
							var confirmDialog = new Dialog()
							val duplicateAction = new Action("Link node to "+name){
								def apply() = {
									confirmDialog.close()
									if(model.removeATOccurrence(tacticValue,nodeId)) model.deleteAT(tacticValue)
									model.addATOccurrence(name,nodeId)
									QuantoLibAPI.setVertexValue(nodeId,model.getATFullName(name))
								}
							}
							val redoAction = new Action("Choose another name"){
								def apply() = {
									confirmDialog.close()
									TinkerDialog.openEditDialog("Edit atomic tactic",values,successCallback,()=>Unit)
								}
							}
							val cancelAction = new Action("Cancel"){def apply() = { confirmDialog.close() }}
							confirmDialog = TinkerDialog.openConfirmationDialog("The atomic tactic name "+name+" is already taken.",Array(duplicateAction,redoAction,cancelAction))
						} else {
							if(model.updateAT(tacticValue,name,tactic,args)){
								QuantoLibAPI.setVertexValue(nodeId,values("Name"))
							} else {
								var confirmDialog = new Dialog()
								val createAction = new Action("Create new"){
									def apply() = {
										confirmDialog.close()
										model.removeATOccurrence(tacticValue,nodeId)
										model.createAT(name,tactic,args)
										model.addATOccurrence(name,nodeId)
										QuantoLibAPI.setVertexValue(nodeId,model.getATFullName(name))
									}
								}
								val updateAction = new Action("Update all"){
									def apply() = {
										confirmDialog.close()
										model.updateForceAT(tacticValue,name,tactic,args).foreach(QuantoLibAPI.setVertexValue(_,model.getATFullName(name)))
									}
								}
								val cancelAction = new Action("Cancel"){def apply() = { confirmDialog.close() }}
								confirmDialog = TinkerDialog.openConfirmationDialog("The atomic tactic "+name+" has many occurrences.",Array(createAction,updateAction,cancelAction))
							}
						}
					}
				}
				TinkerDialog.openEditDialog("Edit atomic tactic",Map("Name"->nodeLabel,"Tactic"->model.getATCoreId(tacticValue)),successCallback,()=>Unit)
			} else {
				def successCallback(values:Map[String,String]) {
					val name = ArgumentParser.separateNameArgs(values("Name"))._1
					val args = ArgumentParser.separateNameArgs(values("Name"))._2
					val branchType = values("Branch type")
					if(name.isEmpty){
						TinkerDialog.openEditDialog("Edit graph tactic",values,successCallback,()=>Unit)
					} else {
						if(model.gtCollection.contains(name) && name != tacticValue){
							var confirmDialog = new Dialog()
							val duplicateAction = new Action("Link node to "+name){
								def apply() = {
									confirmDialog.close()
									if(model.removeGTOccurrence(tacticValue,nodeId)) model.deleteGT(tacticValue)
									model.addGTOccurrence(name,nodeId)
									QuantoLibAPI.setVertexValue(nodeId,model.getGTFullName(name))
									publish(GraphTacticListEvent())
								}
							}
							val redoAction = new Action("Choose another name"){
								def apply() = {
									confirmDialog.close()
									TinkerDialog.openEditDialog("Edit graph tactic",values,successCallback,()=>Unit)
								}
							}
							val cancelAction = new Action("Cancel"){def apply() = { confirmDialog.close() }}
							// the following will not give the option to link a nested node to another graph tactic
							// if the user is evaluating and the is editing the evaluation path
							val actionArray:Array[Action] =
								if(Service.evalCtrl.inEval
									&& Service.evalCtrl.evalPath.contains(model.getCurrentGTName)
									&& Service.evalCtrl.evalPath.contains(tacticValue)){
									Array(redoAction,cancelAction)
								} else {
									Array(duplicateAction,redoAction,cancelAction)
								}
							confirmDialog = TinkerDialog.openConfirmationDialog("The graph tactic name "+name+" is already taken.",actionArray)
						} else {
							if(model.updateGT(tacticValue,name,branchType,args)){
								QuantoLibAPI.setVertexValue(nodeId,values("Name"))
								publish(GraphTacticListEvent())
							} else {
								var confirmDialog = new Dialog()
								val createAction = new Action("Create new"){
									def apply() = {
										confirmDialog.close()
										model.removeGTOccurrence(tacticValue,nodeId)
										model.createGT(name,branchType,args)
										model.addATOccurrence(name,nodeId)
										QuantoLibAPI.setVertexValue(nodeId,model.getGTFullName(name))
										publish(GraphTacticListEvent())
									}
								}
								val updateAction = new Action("Update all"){
									def apply() = {
										confirmDialog.close()
										model.updateForceGT(tacticValue,name,branchType,args).foreach(QuantoLibAPI.setVertexValue(_,model.getGTFullName(name)))
										publish(GraphTacticListEvent())
									}
								}
								val cancelAction = new Action("Cancel"){def apply() = { confirmDialog.close() }}
								// the following will not give the option to create a new graph tactic
								// if the user is evaluating and the is editing the evaluation path
								val actionArray:Array[Action] =
									if(Service.evalCtrl.inEval
										&& Service.evalCtrl.evalPath.contains(model.getCurrentGTName)
										&& Service.evalCtrl.evalPath.contains(tacticValue)){
										Array(updateAction,cancelAction)
									} else {
										Array(createAction,updateAction,cancelAction)
									}
								confirmDialog = TinkerDialog.openConfirmationDialog("The graph tactic "+name+" has many occurrences.",actionArray)
							}
						}
					}
				}
				TinkerDialog.openEditDialog("Edit graph tactic",Map("Name"->nodeLabel,"Branch type"->model.getGTBranchType(tacticValue)),successCallback,()=>Unit)
			}
		} catch {
			case e:PSGraphModelException => TinkerDialog.openErrorDialog(e.msg)
		}
	}

	/** Method changing a tactic occurrence in the model.
		*
		* Mainly used when nodes are merged into a subgraph.
		*
		* @param nodeId Id of the node.
		* @param name Id of the tactic.
		* @param newParent New parent of the tactic.
		* @param newIndex New index of the tactic.
		* @param isAtomicTactic Boolean stating the nature of the node (atomic or nested).
		*/
	def changeTacticOccurrence(nodeId:String, name:String, newParent:String, newIndex:Int, isAtomicTactic:Boolean) {
		try{
			if(isAtomicTactic){
				model.removeATOccurrenceNoDelete(name, nodeId)
				model.addATOccurrence(name, newParent, newIndex, nodeId)
			} else {
				model.removeGTOccurrenceNoDelete(name, nodeId)
				model.addGTOccurrence(name, newParent, newIndex, nodeId)
			}
		} catch {
			case e:PSGraphModelException => TinkerDialog.openErrorDialog(e.msg)
		}
	}

	/** Method opening a dialog to edit an edge.
		*
		* @param edge Id of the edge to edit.
		* @param src Source of the edge.
		* @param tgt Target of the edge.
		* @param gt Goaltype of the edge.
		*/
	def editEdge(edge:String, src:String, tgt:String, gt:String) {
		var source = src
		var target = tgt
		var goalTypes = gt
		def failureCallback() {
			// do nothing
		}
		def successCallback(values:Map[String,String]) {
			values.foreach{
				case ("Goal types",v) =>
					goalTypes = v
				case ("From",v) =>
					source = v
				case ("To",v) =>
					target = v
			}
			if(goalTypes=="" || source=="" || target=="") {
				TinkerDialog.openEditDialog("Edit edge " + edge,
						Map("Goal types" -> goalTypes, "From" -> source, "To" -> target),
						successCallback,
						failureCallback
				)
			} else {
				QuantoLibAPI.setEdgeValue(edge,goalTypes)
				QuantoLibAPI.userUpdateEdge(edge, source, target)
			}
		}
		TinkerDialog.openEditDialog("Edit edge "+edge,
			Map("Goal types"->goalTypes, "From"->source, "To"->target),
			successCallback,
			failureCallback
		)
	}

	/** Method switching the currently edited subgraph.
		*
		* @param tactic Id of the tactic in which the subgraph is.
		* @param index Index of the subgraph to edit.
		* @param parents Optional parent list of the tactic, used to remake the breadcrumbs, default value is None.
		*/
	def editSubgraph(tactic:String, index:Int, parents:Option[Array[String]] = None) {
		try {
			Service.documentCtrl.registerChanges()
			model.changeCurrent(tactic, index, parents)
			Service.graphNavCtrl.viewedGraphChanged(model.isMain,false)
			QuantoLibAPI.loadFromJson(model.getCurrentJson)
			publish(CurrentGraphChangedEvent(tactic,parents))
		} catch {
			case e:GraphTacticNotFoundException => TinkerDialog.openErrorDialog(e.msg)
			case e:SubgraphNotFoundException =>
				addSubgraph(tactic,parents)
		}
	}

	/** Method adding a subgraph to a tactic and using it as current.
		*
		* @param tactic Id of the tactic in which to add the subgraph.
		* @param parents Optional parent list of the tactic, used to remake the breadcrumbs, default value is None.
		*/
	def addSubgraph(tactic:String, parents:Option[Array[String]] = None) {
		try{
			Service.documentCtrl.registerChanges()
			model.newSubgraph(tactic, parents)
			QuantoLibAPI.newGraph()
			Service.graphNavCtrl.viewedGraphChanged(model.isMain,true)
			publish(CurrentGraphChangedEvent(tactic,parents))
		} catch {
			case e:GraphTacticNotFoundException => TinkerDialog.openErrorDialog(e.msg)
		}
	}

	/** Method deleting a subgraph in the model.
		*
		* @param tactic Id of the tactic in which the subgraph is.
		* @param index Index of the subgraph in the tactic.
		*/
	def deleteSubgraph(tactic:String,index:Int) {
		if(!(Service.evalCtrl.inEval && Service.evalCtrl.evalPath.contains(tactic))){
			Service.documentCtrl.registerChanges()
			model.delSubgraphGT(tactic,index)
		}
	}
}
