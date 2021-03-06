package tinkerGUI.views


import tinkerGUI.model.exceptions.{AtomicTacticNotFoundException, GraphTacticNotFoundException}
import tinkerGUI.controllers._
import tinkerGUI.controllers.events._
import tinkerGUI.utils.{UnicodeParser}

import scala.swing._
import javax.swing.ImageIcon
import java.awt.{Cursor, Font}

class VertexEditContent(nam: String, typ: String, label: String, value:String) extends BoxPanel(Orientation.Vertical) {
	val titleFont = new Font("Dialog",Font.BOLD,14)
	contents += new FlowPanel(FlowPanel.Alignment.Center)(new Label("Node Information"){font = titleFont})
	
	val delButton = new Button(
		new Action(""){
			def apply(){
				Service.editCtrl.deleteNode(typ,nam,value)
			}
		}){
		icon = if(typ=="T_Atomic") {
			new ImageIcon(MainGUI.getClass.getResource("delete-atomic.png"), "Edit")
		} else if (typ=="T_Graph") {
			new ImageIcon(MainGUI.getClass.getResource("delete-nested.png"), "Edit")
		} else {
			new ImageIcon(MainGUI.getClass.getResource("delete-identity.png"), "Edit")
		}
		tooltip = "Delete node"
		borderPainted = false
		margin = new Insets(0,0,0,0)
		contentAreaFilled = false
		opaque = false
		cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
	}
	val editButton = new Button(
		new Action(""){
			def apply(){
				//Service.documentCtrl.registerChanges()
				Service.editCtrl.updateTactic(nam,label,value,typ=="T_Atomic")
			}
		}){
		icon = new ImageIcon(MainGUI.getClass.getResource("edit-pen.png"), "Edit")
		tooltip = "Edit tactic"
		borderPainted = false
		margin = new Insets(0,0,0,0)
		contentAreaFilled = false
		opaque = false
		cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
	}

	contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Node : " + nam))
	contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label(typ match{
		case "T_Identity" => "Type : Identity tactic"
		case "T_Atomic" => "Type : Atomic tactic"
		case "T_Graph" => "Type : Graph tactic"
		case "G_Break" => "Type : Breakpoint"
		case "G" => "Type : Goal"
	}))
	typ match {
		case "T_Identity" =>
			contents += new FlowPanel(FlowPanel.Alignment.Left)(delButton)
		case "T_Atomic" =>
			val tacticCoreId = try {
				Service.getATCoreId(value)
			} catch {
				case e:AtomicTacticNotFoundException => "Error : could not find tactic"
			}
			contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Name : "+label))
			contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Value : "+tacticCoreId))
			contents += new FlowPanel(FlowPanel.Alignment.Left)() {
				contents += editButton
				contents += delButton
			}
		case "T_Graph" =>
			//val name = ArgumentParser.separateNameArgs(label)._1
			val branchType = try {
				Service.getBranchTypeGT(value)
			} catch {
				case e:GraphTacticNotFoundException => "Error : could not find tactic"
			}
			val addSubButton = new Button(
				new Action(""){
					def apply(){
						//Service.documentCtrl.registerChanges()
						Service.editCtrl.addSubgraph(value)
					}
				}){
				icon = new ImageIcon(MainGUI.getClass.getResource("add.png"), "Add subgraph")
				tooltip = "Add subgraph"
				borderPainted = false
				margin = new Insets(0,0,0,0)
				contentAreaFilled = false
				opaque = false
				cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
			}
			val inspectButton = new Button(
				new Action(""){
					def apply(){
						Service.inspectorCtrl.inspect(value)
					}
				}){
				icon = new ImageIcon(MainGUI.getClass.getResource("inspect.png"), "Inspect tactic")
				tooltip = "Inspect tactic"
				borderPainted = false
				margin = new Insets(0,0,0,0)
				contentAreaFilled = false
				opaque = false
				cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
			}
			contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Name : "+label))
			contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Branch type : "+branchType))
			contents += new FlowPanel(FlowPanel.Alignment.Left)(){
				contents += addSubButton
				contents += editButton
				contents += inspectButton
				contents += delButton
			}
		case "G_Break" =>
			val removeBreak = new Button(
				new Action("") {
					def apply() {
						Service.editCtrl.deleteNode(typ,nam,value)
					}
				}){
				icon = new ImageIcon(MainGUI.getClass.getResource("remove-break.png"), "Remove breakpoint")
				tooltip = "Remove breakpoint"
				borderPainted = false
				margin = new Insets(0,0,0,0)
				contentAreaFilled = false
				opaque = false
				cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
			}
			contents += new FlowPanel(FlowPanel.Alignment.Left)(removeBreak)
		case "G" =>
			contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Name : "+label))
			contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Goal : "+UnicodeParser.stringToUnicode(value)))
	}

}

class VerticesEditContent(names: Set[String]) extends BoxPanel(Orientation.Vertical) {
	var dialog = new Dialog()
	val mergeAction = new Action("Yes"){
		def apply() = {
			dialog.close()
			Service.editCtrl.mergeSelectedNodes()
		}
	}
	val deleteAction = new Action("Yes"){
		def apply() = {
			dialog.close()
			Service.editCtrl.deleteNodes(names)
		}
	}
	val cancelAction = new Action("Cancel"){
		def apply() = {
			dialog.close()
		}
	}
	val mergeButton = new Button(
		new Action("Merge nodes"){
			def apply() = {
				//dialog = TinkerDialog.openConfirmationDialog("<html>You are about to merge these nodes.</br>Do you wish to continue ?</html>", Array(mergeAction, cancelAction))
				Service.editCtrl.mergeSelectedNodes()
			}
		}
	)
	val deleteButton = new Button(
		new Action("Delete nodes"){
			def apply() = {
				//dialog = TinkerDialog.openConfirmationDialog("<html>You are about to delete these nodes.</br>Do you wish to continue ?</html>", Array(deleteAction, cancelAction))
				Service.editCtrl.deleteNodes(names)
			}
		}
	)
	contents += new FlowPanel(FlowPanel.Alignment.Left)(){
		def prettyString(s: Set[String]) : String = {
			var res = s.head
			s.tail.foreach{ e =>
				res += ", " + e
			}
			res
		}
		contents += new Label("Nodes : " + prettyString(names))
	}
	contents += new FlowPanel(FlowPanel.Alignment.Left)(){
		contents += mergeButton
		contents += deleteButton
	}
}

class EdgeEditContent(nam: String, value: String, src: String, tgt: String) extends BoxPanel(Orientation.Vertical) {
	val titleFont = new Font("Dialog",Font.BOLD,14)
	contents += new FlowPanel(FlowPanel.Alignment.Center)(new Label("Edge Information"){font = titleFont})
	val editButton = new Button(
		new Action("") {
			def apply() = {
				Service.editCtrl.editEdge(nam,src,tgt,value)
			}
		}
	){
		icon = new ImageIcon(MainGUI.getClass.getResource("edit-pen.png"), "Edit")
		tooltip = "Edit edge"
		borderPainted = false
		margin = new Insets(0,0,0,0)
		contentAreaFilled = false
		opaque = false
		cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
	}
	val breakpointButton =
		if(QuantoLibAPI.hasBreak(nam)){
			new Button(
				new Action("") {
				def apply() = {
					Service.editCtrl.removeBreakFromEdge(nam)
				}
			}){
				icon = new ImageIcon(MainGUI.getClass.getResource("remove-break.png"), "Remove breakpoint")
				tooltip = "Remove breakpoint"
				borderPainted = false
				margin = new Insets(0,0,0,0)
				contentAreaFilled = false
				opaque = false
				cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
			}
		}
		else {
			new Button(
				new Action("") {
					def apply() = {
						Service.editCtrl.addBreakOnEdge(nam)
					}
				}){
				icon = new ImageIcon(MainGUI.getClass.getResource("add-break.png"), "Add breakpoint")
				tooltip = "Add breakpoint"
				borderPainted = false
				margin = new Insets(0,0,0,0)
				contentAreaFilled = false
				opaque = false
				cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
			}
		}
	val delButton = new Button(
		new Action(""){
			def apply() = {
				Service.editCtrl.deleteEdge(nam)
			}
		}){
		icon = new ImageIcon(MainGUI.getClass.getResource("delete-edge.png"), "Delete")
		tooltip = "Delete edge"
		borderPainted = false
		margin = new Insets(0,0,0,0)
		contentAreaFilled = false
		opaque = false
		cursor = new Cursor(java.awt.Cursor.HAND_CURSOR)
	}
	contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Edge : " + nam))
	contents += new FlowPanel(FlowPanel.Alignment.Left)(new Label("Goal types : "+value))
	contents += new FlowPanel(FlowPanel.Alignment.Left)(){
		contents += new Label("From : "+src)
		contents += new Label("To : "+tgt)
	}
	contents += new FlowPanel(FlowPanel.Alignment.Left)(){
		contents += editButton
		contents += breakpointButton
		contents += delButton
	}
}

class ElementInfoPanel() extends BoxPanel(Orientation.Vertical) {
	minimumSize = new Dimension(200, 200)
	//preferredSize = new Dimension(250, 250)


	listenTo(QuantoLibAPI)
	reactions += {
		case OneVertexSelectedEvent(nam, typ, label, value) =>
			contents.clear()
			contents += new VertexEditContent(nam, typ, label, value)
			revalidate()
		case ManyVerticesSelectedEvent(names) =>
			contents.clear()
			contents += new VerticesEditContent(names)
			revalidate()
		case OneEdgeSelectedEvent(nam, value, src, tgt) =>
			contents.clear()
			contents += new EdgeEditContent(nam, value, src, tgt)
			revalidate()
		case NothingSelectedEvent() =>
			contents.clear()
			repaint()
	}
}
