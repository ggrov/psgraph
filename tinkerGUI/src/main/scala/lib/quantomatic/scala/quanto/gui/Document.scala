package quanto.gui

import scala.swing.{Component, FileChooser, Dialog, Publisher}
import java.io.{FileNotFoundException, IOException, File}
import scala.swing.event.Event
import quanto.data._
import quanto.util.json.JsonParseException
import javax.swing.filechooser.FileNameExtensionFilter
import java.util.prefs.Preferences

abstract class DocumentEvent extends Event
case class DocumentChanged(sender: Document) extends DocumentEvent
case class DocumentSaved(sender: Document) extends DocumentEvent
case class DocumentReplaced(sender: Document) extends DocumentEvent

/**
 * For an object connected to a single file. Provides an undo stack, tracks changes, and gives
 * convenience functions for loading, saving, etc.
 */

abstract class Document extends Publisher {
  var file: Option[File] = None
  private val _undoStack = new UndoStack
  def undoStack = _undoStack
  def unsavedChanges : Boolean
  def description: String
  def fileExtension: String

  protected def clearDocument()
  protected def saveDocument(f: File)
  protected def loadDocument(f: File)
  protected def parent : Component

  protected def resetDocumentInfo() {
    undoStack.clear()
    file = None
    publish(DocumentChanged(this))
  }

  def clear() {
    clearDocument()
    resetDocumentInfo()
  }

  def save(fopt: Option[File] = None) {
    fopt.orElse(file).map { f =>
      try {
        saveDocument(f)
        file = Some(f)
        publish(DocumentSaved(this))
      } catch {
        case _: IOException => errorDialog("save", "file unwriteable")
        case e: Exception =>
          errorDialog("save", "unexpected error")
          e.printStackTrace()
      }
    }
  }

  def load(f : File) = {
    var success = false
    try {
      file = Some(f)
      loadDocument(f)
      publish(DocumentReplaced(this))
      publish(DocumentChanged(this))
      success = true
    } catch {
      case e: JsonParseException => errorDialog("load", "mal-formed JSON: " + e.getMessage)
      case e: GraphLoadException => errorDialog("load", "invalid graph: " + e.getMessage)
      case e: RuleLoadException => errorDialog("load", "invalid rule: " + e.getMessage)
      case e: DerivationLoadException => errorDialog("load", "invalid derivation: " + e.getMessage)
      case e: FileNotFoundException => errorDialog("load", "file not found")
      case e: IOException => errorDialog("load", "file unreadable")
      case e: Exception =>
        errorDialog("load", "unexpected error")
        e.printStackTrace()
    }

    success
  }

  def titleDescription =
    file.map(f => f.getName).getOrElse("untitled") + (if (unsavedChanges) "*" else "")

  def promptUnsaved() = {
    if (unsavedChanges) {
      Dialog.showConfirmation(
        title = "Unsaved changes",
        message = "There are unsaved changes, do you wish to continue?") == Dialog.Result.Yes
    } else true
  }

  def promptExists(f: File) = {
    if (f.exists()) {
      Dialog.showConfirmation(
        title = "File exists",
        message = "File exists, do you wish to overwrite?") == Dialog.Result.Yes
    } else true
  }

  def errorDialog(action: String, reason: String) {
    Dialog.showMessage(
      title = "Error",
      message = "Cannot " + action + " file (" + reason + ")",
      messageType = Dialog.Message.Error)
  }

  def previousDir_=(f: File) {
    val dir = if (f.isDirectory) f.getPath
              else f.getParent
    if (dir != null) {
//      println("Setting previous dir to: " + dir)
      val prefs = Preferences.userRoot().node(this.getClass.getName)
      prefs.put("previousDir", dir)
    }
  }

  def previousDir: File = {
    val prefs = Preferences.userRoot().node(this.getClass.getName)
    new File(prefs.get("previousDir", System.getProperty("user.home")))
  }

  def showSaveAsDialog(rootDir: Option[String] = None) {
    val chooser = new FileChooser()
    chooser.peer.setCurrentDirectory(rootDir match {
      case Some(d) => new File(d)
      case None => previousDir
    })
    chooser.fileFilter = new FileNameExtensionFilter("Quantomatic " + description + " File (*." + fileExtension + ")", fileExtension)
    chooser.showSaveDialog(parent) match {
      case FileChooser.Result.Approve =>
        if (promptExists(chooser.selectedFile)) save(Some(chooser.selectedFile))
      case _ =>
    }
  }

  def showOpenDialog(rootDir: Option[String] = None) {
    if (promptUnsaved()) {
      val chooser = new FileChooser()
      chooser.peer.setCurrentDirectory(rootDir match {
        case Some(d) => new File(d)
        case None => previousDir
      })
      chooser.fileFilter = new FileNameExtensionFilter("Quantomatic " + description + " File (*." + fileExtension + ")", fileExtension)
      chooser.showOpenDialog(parent) match {
        case FileChooser.Result.Approve =>
          previousDir = chooser.selectedFile
          load(chooser.selectedFile)
        case _ =>
      }
    }
  }

  // any time the graph state changes in a meaningful way, an undo is registered
  listenTo(_undoStack)
  reactions += {
    case UndoRegistered(_) =>
      publish(DocumentChanged(this))
  }
}

trait HasDocument {
  def document: Document
}
