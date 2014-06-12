package quanto.gui

import _root_.scala.Boolean
import _root_.scala.Predef._
import _root_.scala.swing.Button
import _root_.scala.swing.Dialog
import graphview.GraphView
import quanto.data._
import swing._
import swing.event._
import javax.swing.ImageIcon
import quanto.util.swing.ToolBar
import quanto.util.{SockJson,SockJsonError,SockJsonErrorType}

case class MouseStateChanged(m : MouseState) extends Event

class GraphEditControls(theory: Theory) extends Publisher {

  val VertexTypeLabel  = new Label("Vertex Type:  ") { xAlignment = Alignment.Right; enabled = false }
  val VertexTypeSelect = new ComboBox(theory.vertexTypes.keys.toSeq :+ "<wire>") { enabled = false }
  val EdgeTypeLabel    = new Label("Edge Type:  ") { xAlignment = Alignment.Right; enabled = false }
  val EdgeTypeSelect   = new ComboBox(theory.edgeTypes.keys.toSeq) { enabled = false }
  val EdgeDirected     = new CheckBox("directed") { selected = true; enabled = false }

  // Bottom panel
  object BottomPanel extends GridPanel(1,5) {
    contents += (VertexTypeLabel, VertexTypeSelect)
    contents += (EdgeTypeLabel, EdgeTypeSelect, EdgeDirected)
  }

  trait ToolButton { var tool: MouseState = SelectTool() }
  def setMouseState(m : MouseState) { publish(MouseStateChanged(m)) }

  val ge = GraphEditor.getClass

//  val icon = new ImageIcon(GraphEditor.getClass.getResource("select-rectangular.png"), "Select")

  val SelectButton = new ToggleButton() with ToolButton {
    icon = new ImageIcon(GraphEditor.getClass.getResource("select-rectangular.png"), "Select")
    tool = SelectTool()
    selected = true
  }

  val AddVertexButton = new ToggleButton() with ToolButton {
    icon = new ImageIcon(GraphEditor.getClass.getResource("draw-ellipse.png"), "Add Vertex")
    tool = AddVertexTool()
  }

  val AddBoundaryButton = new ToggleButton() with ToolButton {
    icon = new ImageIcon(GraphEditor.getClass.getResource("draw-ellipse-b.png"), "Add Boundary")
    tool = AddBoundaryTool()
  }

  val AddEdgeButton = new ToggleButton() with ToolButton {
    icon = new ImageIcon(GraphEditor.getClass.getResource("draw-path.png"), "Add Edge")
    tool = AddEdgeTool()
  }

  val AddBangBoxButton = new ToggleButton() with ToolButton {
    icon = new ImageIcon(GraphEditor.getClass.getResource("draw-bbox.png"), "Add Bang Box")
    tool = AddBangBoxTool()
  }

  val GraphToolGroup = new ButtonGroup(SelectButton,
                                       AddVertexButton,
                                       AddBoundaryButton,
                                       AddEdgeButton,
                                       AddBangBoxButton
                                      )

  val MainToolBar = new ToolBar {
    contents += (SelectButton, AddVertexButton, AddBoundaryButton, AddEdgeButton, AddBangBoxButton)
  }

  GraphToolGroup.buttons.foreach(listenTo(_))
  reactions += {
    case ButtonClicked(t: ToolButton) =>
      setMouseState(t.tool)
      t.tool match {
        case SelectTool() =>
          VertexTypeLabel.enabled = false
          VertexTypeSelect.enabled = false
          EdgeTypeLabel.enabled = false
          EdgeTypeSelect.enabled = false
          EdgeDirected.enabled = false
        case AddVertexTool() =>
          VertexTypeLabel.enabled = true
          VertexTypeSelect.enabled = true
          EdgeTypeLabel.enabled = false
          EdgeTypeSelect.enabled = false
          EdgeDirected.enabled = false
        case AddEdgeTool() =>
          VertexTypeLabel.enabled = false
          VertexTypeSelect.enabled = false
          EdgeTypeLabel.enabled = true
          EdgeTypeSelect.enabled = true
          EdgeDirected.enabled = true
        case AddBangBoxTool() =>
          VertexTypeLabel.enabled = false
          VertexTypeSelect.enabled = false
          EdgeTypeLabel.enabled = false
          EdgeTypeSelect.enabled = false
          EdgeDirected.enabled = false
        case _ =>
      }
   // case ButtonClicked (ReLayoutButton) =>
     // graphDocument.reLayout();     ???

  }
}

class EvalControls (theory: Theory, document: GraphDocument) extends Publisher {
  /*
*  a set of tools for evaluation, the event handlers are defined in reactions in the Eval Controllor
* */
  val ConnectButton = new Button("Connect")
  val BacktrackButton = new Button("Backtrack")
  val PrevButton = new Button("Prev")
  val NextButton = new Button("Next")
  val DisconnectButton = new Button("Finish")

  def errorDlg (msg : String) = {
    Dialog.showMessage(title = "Info", message = msg)
  };

  val evalController = new EvalController (
    ConnectButton, DisconnectButton,
    BacktrackButton, NextButton, PrevButton,
    errorDlg, document
  );

  val EvalToolBar = new ToolBar {
    contents += (ConnectButton, DisconnectButton, BacktrackButton, PrevButton, NextButton)
  }
}


class GraphEditPanel(val theory: Theory, val readOnly: Boolean = false)
  extends BorderPanel
  with HasDocument
{

  val document = new GraphDocument(this, theory)
  //  def graph = document.graph
  //  def graph_=(g: Graph) { document.graph = g }

  // GUI components
  val graphView = new GraphView(theory, document) {
    drawGrid = true
    focusable = true
  }

  val controls = new GraphEditControls(theory)
  val eval_ctrl = new EvalControls (theory, document)

  // alias for graph_=, used in java code
  //  def setGraph(g: Graph) { graph_=(g) }

  val graphEditController = new GraphEditController(graphView, readOnly) {
    undoStack            = document.undoStack
    vertexTypeSelect     = controls.VertexTypeSelect
    edgeTypeSelect       = controls.EdgeTypeSelect
    edgeDirectedCheckBox = controls.EdgeDirected
  }

  val GraphViewScrollPane = new ScrollPane(graphView)

  if (!readOnly) {
    add(new FlowPanel{contents += controls.MainToolBar; contents += eval_ctrl.EvalToolBar},
          BorderPanel.Position.North)
    add(controls.BottomPanel, BorderPanel.Position.South)
  }

  add(GraphViewScrollPane, BorderPanel.Position.Center)


  listenTo(GraphViewScrollPane, controls, document)

  reactions += {
    case UIElementResized(GraphViewScrollPane) =>
      graphView.resizeViewToFit()
      graphView.repaint()
    case MouseStateChanged(m) =>
      graphEditController.mouseState = m
  }
}
