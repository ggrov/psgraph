/* The following is inspired by the Document class in Quantomatic.
   It as been change to support the new json format of psgraphs. */

package tinkerGUI.controllers

import scala.swing._
import java.io.{FileNotFoundException, IOException, File}
import quanto.util.json._
import java.util.prefs.Preferences
import javax.swing.filechooser.FileNameExtensionFilter

object DocumentService extends Publisher {
	var file : Option[File] = None
	var unsavedChanges: Boolean = false
	
	def setUnsavedChanges(b: Boolean) {
		unsavedChanges = b
		publish(DocumentChanged())
	}

	def title = file.map(f => f.getName).getOrElse("untitled") + (if (unsavedChanges) "*" else "")

	def previousDir: File = {
		val prefs = Preferences.userRoot().node(this.getClass.getName)
		new File(prefs.get("previousDir", System.getProperty("user.home")))
	}

	def save(fopt: Option[File] = None, json: Json){
		fopt.orElse(file).map { f =>
			try {
				json.writeTo(f)
				file = Some(f)
				unsavedChanges = false
				publish(DocumentSaved())
			} catch {
				case _: IOException => TinkerDialog.openErrorDialog("Error while saving : file unwriteable.")
				case e: Exception =>
				TinkerDialog.openErrorDialog("Error while saving : unexpected error.")
				e.printStackTrace()
			}
		}
	}

	def saveAs(rootDir: Option[String] = None, json: Json) {
		val chooser = new FileChooser()
		chooser.peer.setCurrentDirectory(rootDir match {
			case Some(d) => new File(d)
			case None => previousDir
		})
		chooser.fileFilter = new FileNameExtensionFilter("Tinker Proof Strategy Graph File (*.psgraph)", "psgraph")
		chooser.showSaveDialog(Service.getMainFrame) match {
			case FileChooser.Result.Approve =>
				val p = chooser.selectedFile.getAbsolutePath
				val file = new File(if (p.endsWith("." + "psgraph")) p else p + "." + "psgraph")
				if (promptExists(file)) save(Some(file), json)
			case _ =>
		}
	}

	def promptExists(f: File) = {
		if (f.exists()) {
			Dialog.showConfirmation(
				title = "File exists",
				message = "File exists, do you wish to overwrite?") == Dialog.Result.Yes
		}
		else true
	}

	def promptUnsaved(json: Json) = {
		if (unsavedChanges) {
			val choice = Dialog.showOptions(
				title = "Unsaved changes",
				message = "Do you want to save your changes or discard them?",
				entries = "Save" :: "Discard" :: "Cancel" :: Nil,
				initial = 0
			)
			// scala swing dialogs implementation is dumb, here's what I found :
			// Result(0) = Save, Result(1) = Discard, Result(2) = Cancel
			if (choice == Dialog.Result(0)) {
				file match {
					case Some(_) => DocumentService.save(None, json)
					case None => DocumentService.saveAs(None, json)
				}
				true
			}
			else choice == Dialog.Result(1)
		} else true
	}
}