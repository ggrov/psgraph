package tinkerGUI.controllers

import scala.swing._
import tinkerGUI.model.PSGraph

object Service extends Publisher {
	val mainCtrl = new MainGUIController()
	val graphEditCtrl = new GraphEditController()
	val eltEditCtrl = new ElementEditController()
	val menuCtrl = new MenuController()
	val editControlsCtrl = new EditControlsController()
	val graphBreadcrumsCtrl = new GraphBreadcrumsController()
	val model = new PSGraph()

	def changeGraphEditMouseState(state: String){
		graphEditCtrl.changeMouseState(state)
	}

	def addSubgraph(eltName: String){
		model.newSubGraph(eltName)
		QuantoLibAPI.newGraph()
		graphBreadcrumsCtrl.addCrum(eltName)
		publish(NothingSelectedEvent())
	}

	def changeViewedGraph(gr: String){
		model.changeCurrent(gr)
		// println(model.getCurrentJson)
		// QuantoLibAPI.
		publish(NothingSelectedEvent())
	}

	listenTo(QuantoLibAPI)
	reactions += {
		case GraphEventAPI(graph) =>
			model.saveSomeGraph(graph)
	}
}