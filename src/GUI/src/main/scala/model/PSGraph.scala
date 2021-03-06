package tinkerGUI.model

import tinkerGUI.controllers.QuantoLibAPI
import tinkerGUI.model.exceptions._
import quanto.util.json._

/** Model of a proof-strategy graph.
	*
	*/
class PSGraph(name:String) extends ATManager with GTManager {

	/** Main graph tactic.*/
	var mainTactic = new GraphTactic(name, "OR")

	/** Currently viewed graph tactic, if not the main one. */
	var currentTactic: GraphTactic = mainTactic

	/** Current parent list.*/
	var currentParents:Array[String] = Array()

	/** Currently viewed graph index, always 0 for the main one. */
	var currentIndex = 0

	/** Goal types string of the psgraph. */
	var goalTypes = ""

	/** Json representation of the psgraph. */
	var jsonPSGraph: JsonObject = JsonObject()

	def changeMainName(name: String) = {
		val old = mainTactic.name
		mainTactic.name = name
		if(currentParents.nonEmpty) currentParents(0) = name
		gtCollection.foreach(p => p._2.changeOccurrences(old,name))
		atCollection.foreach(p => p._2.changeOccurrences(old,name))
	}

	// ---------- Atomic tactics functions ----------

	/** Method to force the update of an atomic tactic.
		*
		* @param name Name of the atomic tactic.
		* @param newName New name of the atomic tactic.
		* @param newValue New value of the atomic tactic.
		* @return List of the node ids to update on the current graph.
		* @throws AtomicTacticNotFoundException If the atomic tactic was not found.
		* @throws JsonAccessException If updating the values in the json graphs fails.
		*/
	def updateForceAT(name: String, newName:String, newValue: String):Set[String] = {
		try{
			val nodeIds = updateForceAT(name,newName,newValue,currentTactic.name,currentIndex)
			if(name != newName) {
				updateValueInJsonGraphs(name, newName)
			}
			nodeIds
		} catch {
			case e:AtomicTacticNotFoundException => throw e
			case e:JsonAccessException => throw e
		}
	}

	/** Method to force the update of an atomic tactic.
		*
		* @param name Name of the atomic tactic.
		* @param newName New name of the atomic tactic.
		* @return List of the node ids to update on the current graph.
		* @throws AtomicTacticNotFoundException If the atomic tactic was not found.
		* @throws JsonAccessException If updating the values in the json graphs fails.
		*/
	def updateForceAT(name: String, newName:String):Set[String] = {
		try{
			val nodeIds = updateForceAT(name,newName,currentTactic.name,currentIndex)
			if(name != newName) {
				updateValueInJsonGraphs(name, newName)
			}
			nodeIds
		} catch {
			case e:AtomicTacticNotFoundException => throw e
			case e:JsonAccessException => throw e
		}
	}

	/** Method to add an occurrence in an atomic tactic.
		*
		* @param name Name of the atomic tactic.
		* @param node Node id of the occurrence.
		* @throws AtomicTacticNotFoundException If the atomic tactic was not found.
		*/
	def addATOccurrence(name:String,node:String) {
		try {
			addATOccurrence(name, currentTactic.name, currentIndex, node)
		} catch {
			case e:AtomicTacticNotFoundException => throw e
		}
	}

	/** Method to remove an occurrence from an atomic tactic.
		*
		* Deletes the tactic's data from the model if it is the last occurrence.
		* @param name Name of the atomic tactic.
		* @param node Node id of the occurrence to remove.
		* @return Boolean notifying if it was the last occurrence of the atomic tactic.
		* @throws AtomicTacticNotFoundException If the atomic tactic was not found.
		*/
	def removeATOccurrence(name:String,node:String):Boolean = {
		try{
			if(removeATOccurrence(name,currentTactic.name,currentIndex, node)){
				deleteAT(name)
				true
			} else {
				false
			}
		} catch {
			case e:AtomicTacticNotFoundException => throw e
		}
	}

	/** Method to remove an occurrence from an atomic tactic.
		*
		* Does not delete the tactic's data from the model if it is the last occurrence.
		* @param name Name of the atomic tactic.
		* @param node Node id of the occurrence to remove.
		* @throws AtomicTacticNotFoundException If the atomic tactic was not found.
		*/
	def removeATOccurrenceNoDelete(name:String,node:String) {
		try{
			removeATOccurrence(name,currentTactic.name,currentIndex, node)
		} catch {
			case e:AtomicTacticNotFoundException => throw e
		}
	}

	// ---------- End Atomic tactics functions ----------

	// ---------- Graph tactics functions ----------

	/** Method creating an graph tactic if the id is available.
		*
		* Overrides [[GTManager.createGT]] to prevent the creation of a graph tactic having the same name as the main one.
		*
		* @param name Name of the graph tactic.
		* @param branchType Branch type of the graph tactic.
		* @return Boolean notifying of successful creation or not (should be used to handle duplication).
		* @throws ReservedNameException If name is the main tactic name.
		*/
	override def createGT(name:String,branchType:String): Boolean = {
		if(name == mainTactic.name) throw new ReservedNameException(name)
		else {
			super.createGT(name,branchType)
		}
	}

	/** Method to update a graph tactic.
		*
		* Overrides [[GTManager.updateGT]] to change the occurrences of all other tactics if necessary,
		* and prevent the use of the main graph tactic's name.
		*
		* @param name Name of the graph tactic.
		* @param newName New name of the graph tactic.
		* @param newBranchType New branch type value.
		* @return Boolean notifying of successful change or not (should be used to handle duplication).
		* @throws GraphTacticNotFoundException If the graph tactic was not in the collection.
		* @throws ReservedNameException If newName is the main tactic name.
		*/
	override def updateGT(name:String, newName:String, newBranchType:String):Boolean = {
		if(newName == mainTactic.name) throw new ReservedNameException(newName)
		try{
			if(super.updateGT(name, newName, newBranchType)){
				if(name != newName){
					for((k,v)<-gtCollection) v.changeOccurrences(name, newName)
					for((k,v)<-atCollection) v.changeOccurrences(name, newName)
				}
				true
			} else {
				false
			}
		} catch {
			case e:GraphTacticNotFoundException => throw e
		}
	}

	/** Method to force the update of a graph tactic.
		*
		* @param name Name of the graph tactic.
		* @param newName New name of the graph tactic.
		* @param newBranchType New branch type of the graph tactic.
		* @return List of the node ids to update on the current graph.
		* @throws GraphTacticNotFoundException If the graph tactic was not found.
		* @throws ReservedNameException If newName is the main tactic name.
		* @throws JsonAccessException If updating the values in the json graphs fails.
		*/
	def updateForceGT(name: String, newName:String, newBranchType: String):Set[String] = {
		if(newName == mainTactic.name) throw new ReservedNameException(newName)
		try {
			val nodeIds = updateForceGT(name,newName,newBranchType,currentTactic.name,currentIndex)
			if(name != newName) {
				for((k,v)<-gtCollection) v.changeOccurrences(name, newName)
				for((k,v)<-atCollection) v.changeOccurrences(name, newName)
			}
			if(name != newName){
				updateValueInJsonGraphs(name, newName)
			}
			nodeIds
		} catch {
			case e:GraphTacticNotFoundException => throw e
			case e:JsonAccessException => throw e
		}
	}

	/** Method to add an occurrence in a graph tactic.
		*
		* Also registers the graph as a child of the current graph tactic.
		* @param name Name of the graph tactic.
		* @param node Node id of the occurrence.
		* @throws GraphTacticNotFoundException If the graph tactic was not found.
		*/
	def addGTOccurrence(name:String,node:String){
		try {
			super.addGTOccurrence(name,currentTactic.name,currentIndex,node)
			gtCollection get name match{
				case Some(t:GraphTactic) =>
					currentTactic.addChild(t)
				case None =>
					throw new GraphTacticNotFoundException(name)
			}
		} catch {
			case e:GraphTacticNotFoundException => throw e
		}
	}

	/** Method to add an occurrence in a graph tactic.
		*
		* Overrides [[GTManager.addGTOccurrence]] to register the graph as a child of the specified graph tactic.
		* @param name Nameof the graph tactic.
		* @param graph Graph id in which the occurrence is.
		* @param index Graph index in which the occurrence is.
		* @param node Node id of the occurrence.
		* @throws GraphTacticNotFoundException If the graph tactic was not found.
		*/
	override def addGTOccurrence(name:String, graph:String, index:Int, node:String) {
		try {
			super.addGTOccurrence(name,graph,index,node)
			gtCollection get name match{
				case Some(t:GraphTactic) =>
					if(graph==mainTactic.name) mainTactic.addChild(t)
					else gtCollection get graph match{
						case Some(p:GraphTactic) =>
							p.addChild(t)
						case None =>
							throw new GraphTacticNotFoundException(graph)
					}
				case None =>
					throw new GraphTacticNotFoundException(name)
			}
		} catch {
			case e:GraphTacticNotFoundException => throw e
		}
	}

	/** Method to remove an occurrence of a graph tactic.
		*
		* Also removes the graph from the children list of the current graph tactic.
		* And deletes the tactic's data from the model if it is the last occurrence.
		* @param name Name of the graph tactic.
		* @param node Node id of the occurrence to remove.
		* @return Boolean notifying if it was the last occurrence of the graph tactic.
		* @throws GraphTacticNotFoundException If the graph tactic was not found.
		*/
	def removeGTOccurrence(name:String,node:String):Boolean = {
		try {
			val res = removeGTOccurrence(name,currentTactic.name,currentIndex,node)
			gtCollection get name match{
				case Some(t:GraphTactic) =>
					currentTactic.removeChild(t)
				case None =>
					throw new GraphTacticNotFoundException(name)
			}
			if(res){
				deleteGT(name)
				true
			} else {
				false
			}
		} catch {
			case e:GraphTacticNotFoundException => throw e
		}
	}

	/** Method to remove an occurrence of a graph tactic.
		*
		* Also removes the graph from the children list of the current graph tactic.
		* And does not delete the tactic's data from the model if it is the last occurrence.
		* @param name Name of the graph tactic.
		* @param node Node id of the occurrence to remove.
		* @throws GraphTacticNotFoundException If the graph tactic was not found.
		*/
	def removeGTOccurrenceNoDelete(name:String,node:String) {
		try {
			removeGTOccurrence(name,currentTactic.name,currentIndex,node)
			gtCollection get name match{
				case Some(t:GraphTactic) =>
					currentTactic.removeChild(t)
				case None =>
					throw new GraphTacticNotFoundException(name)
			}
		} catch {
			case e:GraphTacticNotFoundException => throw e
		}
	}

	/** Method to delete a graph tactic from the tactic collection.
		*
		* Overrides [[tinkerGUI.model.GTManager.deleteGT]] to remove all occurrences
		* (in the atomic and graph tactic collections) which refer to this graph tactic id.
		* @param name Name of the graph tactic to delete.
		*/
	override def deleteGT(name:String) {
		super.deleteGT(name)
		for((k,v) <- gtCollection) {
			v.removeOccurrence(name)
			if(v.occurrences.isEmpty) deleteGT(k)
		}
		for((k,v) <- atCollection) {
			v.removeOccurrence(name)
			if(v.occurrences.isEmpty) deleteAT(k)
		}
	}

	// ---------- End graph tactics functions ----------

	/** Method to get the current tactic name.
		*
		* @return Tactic name/id.
		*/
	def getCurrentGTName: String = {
		currentTactic.name
	}

	/** Boolean to know if the currently viewed is the main one. */
	def isMain = currentTactic == mainTactic

	/** Method to update the Json representation of the psgraph.
		*
		*/
	def updateJsonPSGraph():JsonObject = {
		val current = JsonArray((currentParents :+ getCurrentGTName).reverse)
		jsonPSGraph = JsonObject(
			"main" -> mainTactic.name,
			"current" -> current,
			"current_index" -> currentIndex,
			"graphs" -> toJsonGT.:+(mainTactic.toJson),
			"atomic_tactics" -> toJsonAT,
			"goal_types" -> goalTypes,
			"occurrences" -> JsonObject("atomic_tactics" -> toJsonATOccurrences, "graph_tactics" -> toJsonGTOccurrences))
		//print(jsonPSGraph)
		jsonPSGraph
	}

	/** Method resetting the model.
		*
		* @param name New graph name, i.e. the main graph tactic name.
		*/
	def reset(name:String) {
		currentIndex = 0
		goalTypes = ""
		mainTactic = new GraphTactic(name, "OR")
		mainTactic.addSubgraph(new JsonObject(), 0)
		currentTactic = mainTactic
		currentParents = Array()
		jsonPSGraph = JsonObject()
		gtCollection = Map()
		atCollection = Map()
	}

	/** Method removing all goals node from the graphs.
		* Needs to access [[tinkerGUI.controllers.QuantoLibAPI]] to safely do so.
		*/
	def removeGoals() {
		try{
			mainTactic.addSubgraph(QuantoLibAPI.graphWithNoGoals(mainTactic.getSubgraph(0)).asObject,0)
			gtCollection.foreach{ case (name,gt) =>
				gt.graphs.zipWithIndex.foreach { case (gr,i) =>
					gt.addSubgraph(QuantoLibAPI.graphWithNoGoals(gr).asObject,i)
				}
			}
		} catch {
			case e:SubgraphNotFoundException =>
		}
	}

	/** Method renaming the model, i.e. renames the main tactic.
		*
		* @param name New name.
		*/
	def rename(name:String) {
		mainTactic.name = name
	}

	/** Method to register a new subgraph and set it as current.
		*
		* @param tactic Gui id of the graph tactic from which to add the new subgraph.
		* @param parents Optional list of parents to update the current parents list.
		* @throws GraphTacticNotFoundException If the graph tactic was not found.
		*/
	def newSubgraph(tactic: String, parents:Option[Array[String]] = None){
		if(tactic == currentTactic.name){
			currentIndex = currentTactic.getSize
		}
		else{
			gtCollection get tactic match {
				case Some(t:GraphTactic) =>
					parents match {
						case Some(p:Array[String]) =>
							currentParents = p
						case None => currentParents = currentParents :+ getCurrentGTName
					}
					currentTactic = t
					currentIndex = t.getSize
				case None =>
					throw new GraphTacticNotFoundException(tactic)
			}
		}
	}

	/** Method to switch the currently viewed graph.
		*
		* @param tactic New current graph tactic.
		* @param index New current index.
		* @param parents Potential list of parents, default is None.
		* @throws GraphTacticNotFoundException If the graph tactic was not found.
		*/
	def changeCurrent(tactic: String, index: Int, parents:Option[Array[String]] = None) {
		if(tactic == mainTactic.name){
			currentIndex = 0
			currentParents = Array()
			currentTactic = mainTactic
		}
		else {
			if(tactic == currentTactic.name){
				currentIndex = index
				parents match {
					case Some(p: Array[String]) =>
						currentParents = p
					case None =>
				}
			}
			else {
				gtCollection get tactic match {
					case Some(t: GraphTactic) =>
						parents match {
							case Some(p:Array[String]) =>
								currentParents = p
							case None =>
								currentParents = currentParents :+ getCurrentGTName
						}
						currentTactic = t
						currentIndex = index
					case None => throw new GraphTacticNotFoundException(tactic)
				}
			}
		}
	}

	/** Method to save the current graph Json representation.
		*
		* @param graph Json representation of the graph.
		* @throws quanto.util.json.JsonAccessException If the graph is not a Json object.
		*/
	def saveGraph(graph: Json) {
		graph match {
			case g: JsonObject =>
				currentTactic.addSubgraph(g, currentIndex)
			case _ => throw new JsonAccessException("Expected: JsonObject, got: "+graph.getClass, graph)
		}
		updateJsonPSGraph()
	}

	/** Method to save the Json representation of a specific graph.
		*
		* @param tactic Graph tactic of the graph.
		* @param graph Json representation of the graph.
		* @param index Index of the graph in the graph tactic.
		* @throws quanto.util.json.JsonAccessException If the graph is not a Json object.
		* @throws GraphTacticNotFoundException If the graph tactic was not found.
		*/
	def saveGraph(tactic: String, graph: Json, index:Int){
		graph match {
			case g: JsonObject =>
				if(tactic == mainTactic.name) mainTactic.addSubgraph(g, 0)
				else try{
					addSubgraphGT(tactic, g, index)
				} catch {
					case e:GraphTacticNotFoundException => throw e
				}
			case _ => throw new JsonAccessException("Expected: JsonObject, got: "+graph.getClass, graph)
		}
		updateJsonPSGraph()
	}

	/** Method to get the current graph Json object.
		*
		* @throws SubgraphNotFoundException If the graph was not found.
		* @return Json object of the graph.
		*/
	def getCurrentJson: JsonObject = {
		try {
			currentTactic.getSubgraph(currentIndex)
		} catch {
			case e:SubgraphNotFoundException => throw e
		}
	}

	/** Method switching a string with another inside all graphs' json except the current one.
		*
		* Needs to access [[tinkerGUI.controllers.QuantoLibAPI]] to safely do that.
		*
		* @param oldVal String to replace.
		* @param newVal String to insert.
		* @throws JsonAccessException If the resulting graph is not a Json object.
		*/
	def updateValueInJsonGraphs(oldVal: String, newVal: String) {
		if(isMain){
			gtCollection.foreach { case (k,v) =>
					v.graphs.zipWithIndex.foreach { case (g,i) =>
						QuantoLibAPI.updateValuesInGraph(g,Array((oldVal,newVal))) match {
							case j : JsonObject => v.graphs(i) = j
							case j:Json => throw new JsonAccessException("Expected: JsonObject, got: "+j.getClass, j)
						}
					}
			}
		} else {
			QuantoLibAPI.updateValuesInGraph(mainTactic.getSubgraph(0),Array((oldVal,newVal))) match {
				case j : JsonObject => mainTactic.graphs(0) = j
				case j:Json => throw new JsonAccessException("Expected: JsonObject, got: "+j.getClass, j)
			}
			gtCollection.foreach { case(k,v) =>
				v.graphs.zipWithIndex.foreach { case (g,i)=>
					if(k != currentTactic.name && i != currentIndex) {
						QuantoLibAPI.updateValuesInGraph(g,Array((oldVal,newVal))) match {
							case j : JsonObject => v.graphs(i) = j
							case j:Json => throw new JsonAccessException("Expected: JsonObject, got: "+j.getClass, j)
						}
					}
				}
			}
		}
		updateJsonPSGraph()
	}

	/** Method to load a new model from a Json object.
		*
		* This method overwrites the all model, hence it should be saved before calling it.
		* @param j Json input.
		* @throws GraphTacticNotFoundException If a graph tactic is not found after importing the data.
		* @throws AtomicTacticNotFoundException If a atomic tactic is not found after importing the data.
		* @throws BadJsonInputException If a set of tactic is not correctly structured.
		* @throws JsonAccessException If the json structure was not correct.
		*/
	def loadJsonGraph(j: JsonObject) {
		atCollection = Map()
		gtCollection = Map()
		val current = (j / "current").asArray.head.stringValue
		val main = (j / "main").stringValue
		currentParents = (j / "current").asArray.tail.foldRight(Array[String]()){ case (p,a) => a :+ p.stringValue}
		currentIndex  = (j / "current_index").intValue
		goalTypes = (j / "goal_types").stringValue
		try{
			loadATFromJson((j/"atomic_tactics").asArray)
			mainTactic = loadGTFromJson((j/"graphs").asArray,main)
			(j / "occurrences").asObject match { case occ:JsonObject =>
				(occ / "atomic_tactics").asObject.foreach { case(k,v) =>
					v.asArray.foreach { occ =>
						val o = occ.asArray
						super.addATOccurrence(k,o.get(0).stringValue,o.get(1).intValue,o.get(2).stringValue)
					}
				}
				(occ / "graph_tactics").asObject.foreach { case(k,v) =>
					v.asArray.foreach { occ =>
						val o = occ.asArray
						super.addGTOccurrence(k,o.get(0).stringValue,o.get(1).intValue,o.get(2).stringValue)
					}
				}
			}
			rebuildHierarchy()
		} catch {
			case e:PSGraphModelException => throw e
			case e:JsonAccessException => throw e
		}
		if(current == main){
			currentTactic = mainTactic
		}
		else {
			gtCollection get current match {
				case Some(t: GraphTactic) => currentTactic = t
				case None => throw new GraphTacticNotFoundException(current)
			}
		}
		mainTactic.graphs = mainTactic.graphs.map(QuantoLibAPI.graphWithCompleteLabels).map(QuantoLibAPI.tinkerLayout)
		gtCollection.foreach{ case (k,v) =>
			v.graphs = v.graphs.map(QuantoLibAPI.graphWithCompleteLabels).map(QuantoLibAPI.tinkerLayout)
		}
	}

	/** Method to find the children of every graph tactic, including the main graph.
		*
		*/
	def rebuildHierarchy(){
		mainTactic.children.clear()
		gtCollection.foreach{ case(k,v) =>
			v.occurrences.foreach{ o => if(o._1 == mainTactic.name) mainTactic.addChild(v)}
		}
		mainTactic.children.foreach{ c => buildPartialHierarchy(c)}
	}

	/** Method to find the children of a graph tactic, and their children as well.
		*
		* @param parent Name of the graph tactic.
		*/
	def buildPartialHierarchy(parent:GraphTactic) {
		if(parent.children.isEmpty){
			gtCollection.foreach{ case(k,v) =>
				v.occurrences.foreach{ o => if(o._1 == parent.name) parent.children = parent.children :+ v}
			}
			parent.children.foreach{ c => buildPartialHierarchy(c)}
		}
	}
}