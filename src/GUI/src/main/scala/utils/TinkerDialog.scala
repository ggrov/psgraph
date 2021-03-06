package tinkerGUI.utils

import scala.swing._
import scala.swing.event.{Key, KeyPressed, KeyReleased}

/** Object implementing generic dialogs for tinker.
	*
	* Enable to display four types of dialogs :
	* - one asking for confirmation of action ;
	* - one reporting errors ;
	* - one simply displaying messages ;
	* - one enabling field completion.
	*/
object TinkerDialog {

	/** Maximum dimensions of the dialog window.*/
	var max = new Dimension(400, 300)

	/** Minimum dimensions of the dialog window.*/
	var min = new Dimension(250, 100)

	/** Method opening a confirmation dialog.
		*
		* @param message Custom message do display, e.g. "You are about to do something dangerous. Do you wish to continue ?".
		* @param actions List of possible actions, e.g. "Yes" and "No".
		* @return Dialog instance. Must be closed by the actions.
		*/
	def openConfirmationDialog(message: String,
														 actions: Array[Action{def apply():Unit}],
														 cancelAction:Action{def apply():Unit}):Dialog = {
		val confirmationDialog: Dialog = new Dialog()
		confirmationDialog.resizable = false
		confirmationDialog.maximumSize = max
		confirmationDialog.minimumSize = min
		confirmationDialog.title = "Tinker - Confirmation"
		confirmationDialog.contents = new GridPanel(2,1){
			contents += new Label(message)
			contents += new FlowPanel(){
				actions.foreach{ action =>
					contents += new Button(action)
				}
			}
			listenTo(keys)
			reactions += {
				case KeyPressed(source, Key.Escape, _, _) =>
					if(source == this) {
						cancelAction()
					}
			}
		}
		confirmationDialog.open()
		confirmationDialog.centerOnScreen()
		confirmationDialog
	}

	/** Method opening an error dialog.
		*
		* @param message Custom message, e.g. "Something went wrong there.".
		* @return Dialog instance.
		*/
	def openErrorDialog(message: String):Dialog = {
		val errorDialog:Dialog = new Dialog()
		errorDialog.resizable = false
		errorDialog.maximumSize = max
		errorDialog.minimumSize = min
		errorDialog.title = "Tinker - Error"
		errorDialog.contents = new GridPanel(2,1){
			contents += new FlowPanel(){
				contents += new Label("<html><body style='width:400px'>"+message+"</body></html>"){
					maximumSize = new Dimension(max)
					icon = new javax.swing.ImageIcon(tinkerGUI.views.MainGUI.getClass.getResource("error.png"), "Error")
				}
			}
			val closeAction = new Action("OK"){def apply(){errorDialog.close()}}
			contents += new FlowPanel(){
				contents += new Button(closeAction)
			}
			listenTo(keys)
			reactions += {
				case KeyPressed(source, Key.Escape, _, _) =>
					if(source == this) {
						closeAction()
					}
			}
		}
		errorDialog.open()
		errorDialog.centerOnScreen()
		errorDialog
	}

	/** Method opening a dialog displaying a message.
		*
		* @param message Custom message, e.g. "Something happened.".
		* @return Dialog instance.
		*/
	def openInformationDialog(message: String):Dialog = {
		val infoDialog:Dialog = new Dialog()
		infoDialog.resizable = false
		infoDialog.maximumSize = max
		infoDialog.minimumSize = min
		infoDialog.title = "Tinker - Message"
		infoDialog.contents = new GridPanel(3,1){
			contents += new FlowPanel(){
				contents += new Label("<html><body style='width:400px'>"+message+"</body></html>")
			}
			val closeAction = new Action("OK"){def apply(){infoDialog.close()}}
			contents += new FlowPanel(){
				contents += new Button(closeAction)
			}
			listenTo(keys)
			reactions += {
				case KeyPressed(source, Key.Escape, _, _) =>
					if(source == this) {
						closeAction()
					}
			}
		}
		infoDialog.open()
		infoDialog.centerOnScreen()
		infoDialog
	}

	/** Method opening and edit dialog.
		*
		* @param message Custom message, e.g. "You are editing this.".
		* @param fields Map of the fields, e.g. "Name" -> value. Value can be empty.
		* @param success Success callback, i.e. what to do with the new values when the user clicks "Done".
		* @param failure Failure callback, i.e. what to do when the user clicks "Cancel".
		* @return Dialog instance.
		*/
	def openEditDialog(message: String, fields: Map[String,String], success:(Map[String,String])=>Unit, failure:()=>Unit):Dialog = {

		val editDialog:Dialog = new Dialog()
		editDialog.resizable = true
		//editDialog.maximumSize = max
		editDialog.minimumSize = min
		editDialog.title = "Tinker - Edition"
		var newValMap = Map[String, String]()
		var textfieldMap = Map[String, TextComponent]()
		var radios:List[RadioButton] = List()
		var checks:Map[String,CheckBox] = Map()

		editDialog.contents = new GridPanel(fields.size+2, 1){
			contents += new FlowPanel() {
				contents += new Label(message)
			}
			fields.foreach{ case (k,v)=>
				contents += new FlowPanel() {
					k match {
						case "Branch type" => // radio buttons
							val orRadio = new RadioButton("OR"){selected = v=="OR"}
							val orelseRadio = new RadioButton("ORELSE"){selected = v=="ORELSE"}
							new ButtonGroup(orRadio, orelseRadio)
							radios = List(orRadio, orelseRadio)
							contents += new Label(k+" : ")
							contents ++= radios
							textfieldMap += (k -> new TextField())
//						case "Creat html app" => //checkbox
//							val check = new CheckBox(k)
//							check.selected = v=="true"
//							checks = checks + (k->check)
//							textfieldMap += (k -> new TextField())
//							contents += check
						case "From" | "To" => // small text fields
							val t = new TextField(v, 5)
							contents += new Label(k+" : ")
							contents += t
							textfieldMap += (k -> t)
						case "Proof name" | "Goal" | "Title (*)" | "Author" | "Date" => // large text fields
							val t = new UnicodeTextField(v, 20)
							contents += new Label(k+" : ")
							contents += t
							textfieldMap += (k -> t)
						case _ => // large text area : "Name"
							val t = new UnicodeTextArea(v, 5, 25)
							contents += new Label(k+" : ")
							contents += new ScrollPane(t)
							textfieldMap += (k -> t)
					}
				}
			}

			val doneAction = new Action("Done"){
				def apply() {
					textfieldMap.foreach { case (k, v) =>
						if (k == "Branch type") {
							var text = ""
							radios.foreach { case r => if (r.selected) text = r.text }
							newValMap += (k -> text)
							// for checkboxes
							//								} else if(k == "Create html app"){
							//									val text = if(checks(k).selected) "true" else "false"
							//									newValMap += (k -> text)
						} else {
							newValMap += (k -> v.text)
						}
					}
					editDialog.close()
					success(newValMap)
				}
			}
			val cancelAction = new Action("Cancel"){
				def apply(){
					editDialog.close()
					failure()
				}
			}


			contents += new FlowPanel(){
				contents += new Button(doneAction)
				contents += new Button(cancelAction)
			}

			listenTo(keys)
			textfieldMap.values.foreach(t => listenTo(t.keys))
			reactions += {
				case KeyPressed(source, Key.Escape, _, _) =>
					if(source == this || textfieldMap.values.toSet.contains(source)) {
						cancelAction()
					}
				case KeyPressed(source, Key.Enter, Key.Modifier.Control, _) =>
					if(source == this || textfieldMap.values.toSet.contains(source)) {
						doneAction()
					}
			}
		}
		editDialog.open()
		editDialog.centerOnScreen()


		editDialog
	}
}