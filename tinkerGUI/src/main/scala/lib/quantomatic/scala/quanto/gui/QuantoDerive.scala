package quanto.gui


import scala.swing._
import scala.swing.event.{SelectionChanged, Key}
import javax.swing.{UIManager, KeyStroke}
import java.awt.event.KeyEvent
import quanto.util.json.{JsonString, Json}
import quanto.data._
import java.io.{FilenameFilter, IOException, File}
import java.nio.file.{Files, Paths}
import javax.swing.plaf.metal.MetalLookAndFeel
import java.util.prefs.Preferences
import quanto.gui.histview.HistView
import akka.actor.{Props, ActorSystem}
import quanto.core._
import akka.pattern.ask
import akka.util.Timeout
import scala.concurrent.duration._
import scala.concurrent.ExecutionContext
import ExecutionContext.Implicits.global
import java.awt.Color


object QuantoDerive extends SimpleSwingApplication {
  val CommandMask = java.awt.Toolkit.getDefaultToolkit.getMenuShortcutKeyMask
  val actorSystem = ActorSystem("QuantoDerive")
  val core = actorSystem.actorOf(Props { new Core }, "core")
  implicit val timeout = Timeout(1.day)

  println(new File(".").getAbsolutePath)

  def error(msg: String) = Dialog.showMessage(
    title = "Error", message = msg, messageType = Dialog.Message.Error)

  try {
    UIManager.setLookAndFeel(new MetalLookAndFeel) // tabs in OSX PLAF look bad
  } catch {
    case e: Exception => e.printStackTrace()
  }

  val prefs = Preferences.userRoot().node(this.getClass.getName)

  var CurrentProject : Option[Project] = prefs.get("lastProjectFolder", null) match {
    case path : String =>
      try {
        val folder = Paths.get(path)
        val projectFile = new File(folder.resolve("main.qproject").toString)
        if (projectFile.exists) Some(Project.fromJson(Json.parse(projectFile), folder.toString))
        else None
      } catch {
        case e: Exception =>
          e.printStackTrace()
          None
      }
    case _ => None
  }

  val ProjectFileTree = new FileTree
  ProjectFileTree.preferredSize = new Dimension(250,360)
  ProjectFileTree.filenameFilter = Some(new FilenameFilter {
    val extns = Set("qgraph", "qrule", "qderive", "ML")
    def accept(parent: File, name: String) = {
      val extn = name.lastIndexOf('.') match {
        case i if i > 0 => name.substring(i+1) ; case _ => ""}
      if (extns.contains(extn)) true
      else new File(parent, name).isDirectory
    }
  })

  ProjectFileTree.root = CurrentProject.map { _.rootFolder }

  val MainTabbedPane = new ClosableTabbedPane

  def currentDocument: Option[HasDocument] =
    MainTabbedPane.currentContent match {
      case Some(doc: HasDocument) => Some(doc)
      case _ => None
    }

  object HistViewSlot extends BorderPanel {
    def setHistView(hv: HistView[DeriveState]) {
      add(new ScrollPane(hv), BorderPanel.Position.Center)
      revalidate()
      repaint()
    }

    def clearHistView() {
      add(new BorderPanel(), BorderPanel.Position.Center)
      revalidate()
      repaint()
    }
  }

  private var _histView: Option[HistView[DeriveState]] = None
  def histView_=(hvOpt: Option[HistView[DeriveState]]) {
    _histView = hvOpt
    hvOpt match {
      case Some(hv) => HistViewSlot.setHistView(hv)
      case None => HistViewSlot.clearHistView()
    }
  }

  def histView = _histView

  object LeftSplit extends SplitPane {
    orientation = Orientation.Horizontal
    contents_=(ProjectFileTree, HistViewSlot)
  }

  object Split extends SplitPane {
    orientation = Orientation.Vertical
    contents_=(LeftSplit, MainTabbedPane)
  }


  val FileMenu = new Menu("File") { menu =>
    mnemonic = Key.F

    val NewGraphAction = new Action("New Graph...") {
      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_N, CommandMask))
      menu.contents += new MenuItem(this) { mnemonic = Key.G }
      def apply() {
        CurrentProject.map{ project =>
          val page = new GraphDocumentPage(project.theory)
          MainTabbedPane += page
          MainTabbedPane.selection.index = page.index
        }
      }
    }

    val NewAxiomAction = new Action("New Axiom...") {
      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_N, CommandMask | Key.Modifier.Shift))
      menu.contents += new MenuItem(this) { mnemonic = Key.X }
      def apply() {
        CurrentProject.map{ project =>
          val page = new RuleDocumentPage(project.theory)
          MainTabbedPane += page
          MainTabbedPane.selection.index = page.index
        }
      }
    }

    val SaveAction = new Action("Save") {
      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_S, CommandMask))
      enabled = false
      menu.contents += new MenuItem(this) { mnemonic = Key.S }
      def apply() {
        MainTabbedPane.currentContent match {
          case Some(doc: HasDocument) =>
            doc.document.file match {
              case Some(_) => doc.document.save()
              case None    => doc.document.showSaveAsDialog(CurrentProject.map(_.rootFolder))
            }
          case _ =>
        }
      }
    }

    val SaveAsAction = new Action("Save As...") {
      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_S, CommandMask | Key.Modifier.Shift))
      enabled = false
      menu.contents += new MenuItem(this) { mnemonic = Key.A }
      def apply() {
        MainTabbedPane.currentContent match {
          case Some(doc: HasDocument) =>
            doc.document.showSaveAsDialog(CurrentProject.map(_.rootFolder))
          case _ =>
        }
      }
    }

    menu.contents += new Separator()

    val NewProjectAction = new Action("New Project...") {
      menu.contents += new MenuItem(this) { mnemonic = Key.N }

      def apply() {
        val d = new NewProjectDialog()
        d.centerOnScreen()
        d.open()
        d.result.map {
          case (thy,name,path) =>
            println("got: " + (thy, name, path))
            val folder = Paths.get(path, name)
            if (new File(folder.toString).exists()) {
              Dialog.showMessage(
                title = "Error",
                message = "A file or folder already exists with that name.",
                messageType = Dialog.Message.Error)
            } else {
              Files.createDirectories(folder)
              Files.createDirectory(folder.resolve("graphs"))
              Files.createDirectory(folder.resolve("axioms"))
              Files.createDirectory(folder.resolve("theorems"))
              Files.createDirectory(folder.resolve("derivations"))
              Files.createDirectory(folder.resolve("code"))
              val proj = Project(theoryFile = thy, rootFolder = folder.toString)
              Project.toJson(proj).writeTo(new File(folder.resolve("main.qproject").toString))
              CurrentProject = Some(proj)
              ProjectFileTree.root = Some(folder.toString)
              prefs.put("lastProjectFolder", folder.toString)
            }
        }
      }
    }

    val OpenProjectAction = new Action("Open Project...") {
      menu.contents += new MenuItem(this) { mnemonic = Key.O }
      def apply() {
        val chooser = new FileChooser()
        chooser.fileSelectionMode = FileChooser.SelectionMode.DirectoriesOnly
        chooser.showOpenDialog(Split) match {
          case FileChooser.Result.Approve =>
            val folder = chooser.selectedFile.toString
            val projectFile = new File(folder + "/main.qproject")
            if (projectFile.exists) {
              try {
                val proj = Project.fromJson(Json.parse(projectFile), folder)
                CurrentProject = Some(proj)
                ProjectFileTree.root = Some(folder)
                prefs.put("lastProjectFolder", folder.toString)
              } catch {
                case _: ProjectLoadException =>
                  error("Error loading project file")
                case e : Exception =>
                  error("Unexpected error when opening project")
                  e.printStackTrace()
              }
            } else {
              error("Folder does not contain a QuantoDerive project")
            }
          case _ =>
        }
      }
    }

    menu.contents += new Separator()

    val QuitAction = new Action("Quit") {
      menu.contents += new MenuItem(this) { mnemonic = Key.Q }
      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_Q, CommandMask))
      def apply() {
        //if (ruleDocument.promptUnsaved())
        core ! StopCore
        scala.sys.exit(0)
      }
    }
  }

  val EditMenu = new Menu("Edit") { menu =>
    mnemonic = Key.E

    val UndoAction = new Action("Undo") with Reactor {
      menu.contents += new MenuItem(this) { mnemonic = Key.U }

      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_Z, CommandMask))
      enabled = false
      def apply() = currentDocument.map { doc =>
        doc.document.undoStack.undo()
      }

      def updateUndoCommand() =
        currentDocument match {
          case Some(doc) =>
            enabled = doc.document.undoStack.canUndo
            title = "Undo " + doc.document.undoStack.undoActionName.getOrElse("")
          case None =>
            enabled = false
            title = "Undo"
        }

      listenTo(MainTabbedPane.selection)

      reactions += {
        case DocumentChanged(_) => updateUndoCommand()
        case SelectionChanged(_) =>
          currentDocument.map { doc => listenTo(doc.document) }
          updateUndoCommand()
      }
    }

    val RedoAction = new Action("Redo") with Reactor {
      menu.contents += new MenuItem(this) { mnemonic = Key.R }

      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_Z, CommandMask | Key.Modifier.Shift))
      enabled = false

      def apply() = currentDocument.map { doc =>
        doc.document.undoStack.redo()
      }

      def updateRedoCommand() =
        currentDocument match {
          case Some(doc) =>
            enabled = doc.document.undoStack.canRedo
            title = "Redo " + doc.document.undoStack.redoActionName.getOrElse("")
          case None =>
            enabled = false
            title = "Redo"
        }

      listenTo(MainTabbedPane.selection)

      reactions += {
        case DocumentChanged(_) => updateRedoCommand()
        case SelectionChanged(_) =>
          currentDocument.map { doc => listenTo(doc.document) }
          updateRedoCommand()
      }
    }

//    val LayoutAction = new Action("Layout Graph") with Reactor {
//      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_L, CommandMask))
//      def apply() {
//        ruleEditPanel.lhsController.layoutGraph()
//        ruleEditPanel.rhsController.layoutGraph()
//      }
//    }



//    contents += new MenuItem(LayoutAction) { mnemonic = Key.L }
  }

  val DeriveMenu = new Menu("Derive") { menu =>
    val StartDerivation = new Action("Start derivation") {
      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_D, CommandMask))
      enabled = false
      menu.contents += new MenuItem(this) { mnemonic = Key.D }
      def apply() = (CurrentProject, MainTabbedPane.currentContent) match {
          case (Some(project), Some(doc: HasDocument)) =>
            doc.document match {
              case (graphDoc: GraphDocument) =>
                val page = new DerivationDocumentPage(project.theory)
                page.document.asInstanceOf[DerivationDocument].root = graphDoc.graph
                MainTabbedPane += page
                MainTabbedPane.selection.index = page.index
              case _ =>
                System.err.println("WARNING: Start derivation called with no graph active")
            }
          case _ => // no project and/or document open, do nothing
      }
    }

    val LayoutDerivation = new Action("Layout derivation") {
//      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_L, CommandMask))
      enabled = false
      menu.contents += new MenuItem(this) { mnemonic = Key.L }
      def apply() = (CurrentProject, MainTabbedPane.currentContent) match {
        case (Some(project), Some(derivePanel: DerivationPanel)) =>
          derivePanel.controller.layoutDerivation()
        case _ => // no project and/or derivation open, do nothing
      }
    }
  }

  val WindowMenu = new Menu("Window") { menu =>
    val CloseAction = new Action("Close tab") {
      accelerator = Some(KeyStroke.getKeyStroke(KeyEvent.VK_W, CommandMask))
      enabled = false
      menu.contents += new MenuItem(this) { mnemonic = Key.C }
      def apply() {
        MainTabbedPane.currentContent match {
          case Some(doc: HasDocument) =>
            if (doc.document.promptUnsaved()) MainTabbedPane.pages.remove(MainTabbedPane.selection.index)
          case _ =>
        }
      }
    }
  }

  val CoreStatus = new Label("???")
  CoreStatus.foreground = Color.BLUE
  val ConsoleProgress = new ProgressBar

  val StatusBar = new GridPanel(1,2) {
    contents += new FlowPanel(FlowPanel.Alignment.Left) ( new Label("Core status:"), CoreStatus )
    contents += new FlowPanel(FlowPanel.Alignment.Right) ( ConsoleProgress )
  }

  val Main = new BorderPanel {
    add(Split, BorderPanel.Position.Center)
    add(StatusBar, BorderPanel.Position.South)
  }

  listenTo(ProjectFileTree, MainTabbedPane.selection)

  reactions += {
    case FileOpened(file) =>
      CurrentProject match {
        case Some(project) =>
          val existingPage = MainTabbedPane.pages.find { p =>
            p.content match {
              case doc : HasDocument => doc.document.file.exists(_.getPath == file.getPath)
              case _ => false
            }
          }

          existingPage match {
            case Some(p) =>
              MainTabbedPane.selection.index = p.index
            case None =>
              val extn = file.getName.lastIndexOf('.') match {
                case i if i > 0 => file.getName.substring(i+1) ; case _ => ""}

              val pageOpt = extn match {
                case "qgraph"  => Some(new GraphDocumentPage(project.theory))
                case "qrule"   => Some(new RuleDocumentPage(project.theory))
                case "qderive" => Some(new DerivationDocumentPage(project.theory))
                case "ML"      => Some(new MLDocumentPage)
                case _         => None
              }

              pageOpt.map{ page =>
                MainTabbedPane += page
                MainTabbedPane.selection.index = page.index

                if (!page.document.load(file)) {
                  // TODO: clear up, because file load failed
                }
              }
          }
        case None => error("No project open.")
      }

    case SelectionChanged(_) =>
      // set GUI for general document-based panels
      MainTabbedPane.currentContent match {
        case Some(doc: HasDocument) =>
          WindowMenu.CloseAction.enabled = true
          FileMenu.SaveAction.enabled = true
          FileMenu.SaveAction.title = "Save " + doc.document.description
          FileMenu.SaveAsAction.enabled = true
          FileMenu.SaveAsAction.title = "Save " + doc.document.description + " As..."

        case _ =>
          DeriveMenu.StartDerivation.enabled = false
          WindowMenu.CloseAction.enabled = false
          FileMenu.SaveAction.enabled = false
          FileMenu.SaveAction.title = "Save"
          FileMenu.SaveAsAction.enabled = false
          FileMenu.SaveAsAction.title = "Save As..."

      }

      // document-specific settings
      MainTabbedPane.currentContent match {
        case Some(panel: GraphEditPanel) =>
          DeriveMenu.StartDerivation.enabled = true
          DeriveMenu.LayoutDerivation.enabled = false
          histView = None
        case Some(panel: DerivationPanel) =>
          DeriveMenu.StartDerivation.enabled = false
          DeriveMenu.LayoutDerivation.enabled = true
          histView = Some(panel.histView)
        case _ =>
          DeriveMenu.StartDerivation.enabled = false
          DeriveMenu.LayoutDerivation.enabled = false
          histView = None
      }
  }

  val versionResp = core ? Call("!!", "system", "version")
  versionResp.onSuccess { case Success(JsonString(version)) =>
    Swing.onEDT { CoreStatus.text = "OK"; CoreStatus.foreground = new Color(0,150,0) }
  }

  def top = new MainFrame {
    title = "QuantoDerive"
    contents = Main

    size = new Dimension(1280,720)

    menuBar = new MenuBar {
      contents += (FileMenu, EditMenu, DeriveMenu, WindowMenu)
    }
  }
}
