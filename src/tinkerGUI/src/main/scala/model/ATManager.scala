package tinkerGUI.model

import quanto.util.json.{Json, JsonObject, JsonArray}
import tinkerGUI.model.exceptions.{BadJsonInputException, AtomicTacticNotFoundException}

/** A manager for the atomic tactics of a psgraph.
	*
	* Will register the atomic tactics in a map and manage their creation and update.
	* Also provides accessors for the atomic tactics values.
	*/
trait ATManager {

	/** The collection of atomic tactics.*/
	var atCollection:Map[String,AtomicTactic] = Map()
	
	/** Method creating an atomic tactic if the id is available.
	 *
	 * @param id Gui id/name of the atomic tactic.
	 * @param tactic Core id of the atomic tactic.
	 * @return Boolean notifying of successful creation or not (should be used to handle duplication).
	 */
	def createAT(id:String,tactic:String): Boolean = {
		if(atCollection contains id){
			false
		} else {
			atCollection += id -> AtomicTactic(id, tactic)
			true
		}
	}

	/** Method to update an atomic tactic, only if it has less than two occurrences.
	 *
	 * @param id Gui id before change.
	 * @param newId New gui id value.
	 * @param newTactic New core id value.
	 * @return Boolean notifying of successful change or not (should be used to handle duplication).
	 * @throws AtomicTacticNotFoundException If the atomic tactic is not in the collection.
	 */
	def updateAT(id:String, newId:String, newTactic:String):Boolean = {
		atCollection get id match {
			case Some(t:AtomicTactic) =>
				if(t.occurrences.size < 2){
					t.name = newId
					t.tactic = newTactic
					if(id != newId){
						atCollection += (newId -> t)
						atCollection -= id
					}
					true
				} else {
					false
				}
			case _ =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method to update an atomic tactic, only if it has less than two occurrences.
		*
		* @param id Gui id before change.
		* @param newId New gui id value.
		* @return Boolean notifying of successful change or not (should be used to handle duplication).
		* @throws AtomicTacticNotFoundException If the atomic tactic is not in the collection.
		*/
	def updateAT(id:String, newId:String):Boolean = {
		atCollection get id match {
			case Some(t:AtomicTactic) =>
				if(t.occurrences.size < 2){
					t.name = newId
					if(id != newId){
						atCollection += (newId -> t)
						atCollection -= id
					}
					true
				} else {
					false
				}
			case _ =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method to force the update of an atomic tactic, i.e. update no matter what is the number of occurrences.
	 *
	 * @param id Gui id before change.
	 * @param newId New gui id value.
	 * @param newTactic New core id value.
	 * @param graph Current graph id.
	 * @param index Current graph index.
	 * @return List of node id linked with this atomic tactic in the current graph (should be used to update the graph view).
	 * @throws AtomicTacticNotFoundException If the atomic tactic is not in the collection.
	 */
	def updateForceAT(id:String, newId:String, newTactic:String, graph:String, index:Int):Array[String] = {
		atCollection get id match {
			case Some(t:AtomicTactic) =>
				t.name = newId
				t.tactic = newTactic
				if (id != newId) {
					atCollection += (newId -> t)
					atCollection -= id
				}
				t.getOccurrencesInGraph(graph, index)
			case _ =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method to force the update of an atomic tactic, i.e. update no matter what is the number of occurrences.
		*
		* @param id Gui id before change.
		* @param newId New gui id value.
		* @param graph Current graph id.
		* @param index Current graph index.
		* @return List of node id linked with this atomic tactic in the current graph (should be used to update the graph view).
		* @throws AtomicTacticNotFoundException If the atomic tactic is not in the collection.
		*/
	def updateForceAT(id:String, newId:String, graph:String, index:Int):Array[String] = {
		atCollection get id match {
			case Some(t:AtomicTactic) =>
				t.name = newId
				if (id != newId) {
					atCollection += (newId -> t)
					atCollection -= id
				}
				t.getOccurrencesInGraph(graph, index)
			case _ =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method deleting an atomic tactic from the tactic collection.
		*
		* @param id Gui id of the atomic tactic to remove.
		*/
	def deleteAT(id:String) {
		atCollection -= id
	}

	/** Method to get the tactic value of an atomic tactic.
	 *
	 * @param id Gui id of the atomic tactic.
	 * @return Tactic value.
	 * @throws AtomicTacticNotFoundException If the atomic tactic is not in the collection.
	 */
	def getTacticValue(id:String):String = {
		atCollection get id match {
			case Some(t:AtomicTactic) =>
				t.tactic
			case _ =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method to set the tactic value of an atomic tactic.
		*
		* @param id Gui id of the atomic tactic.
		* @throws AtomicTacticNotFoundException If the atomic tactic is not in the collection.
		*/
	def setTacticValue(id:String,tactic:String) {
		atCollection get id match {
			case Some(t:AtomicTactic) =>
				t.tactic = tactic
			case _ =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method to generate a Json array of the atomic tactic collection
		*
		* @return Json array of the collection of atomic tactics.
		*/
	def toJsonAT:JsonArray = {
		var arr:Array[JsonObject] = Array()
		atCollection.foreach{ case(k,v) =>
			arr = arr :+ v.toJson
		}
		JsonArray(arr)
	}

	/** Method to generate a Json object of the graph tactics' occurrences.
		*
		* @return Json object of the graph tactics occurrences.
		*/
	def toJsonATOccurrences:JsonObject = {
		JsonObject(atCollection map {case(k,v) => k -> v.occurrencesToJson() })
	}

	/** Method to add an occurrence in an atomic tactic.
		*
		* @param id Gui id of the atomic tactic.
		* @param graph Graph id in which the occurrence is.
		* @param index Graph index in which the occurrence is.
		* @param node Node id of the occurrence.
		* @throws AtomicTacticNotFoundException If the atomic tactic is not in the collection.
		*/
	def addATOccurrence(id:String, graph:String, index:Int, node:String) {
		atCollection get id match {
			case Some(t:AtomicTactic) =>
				t.addOccurrence(Tuple3(graph,index,node))
			case None =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method to remove an occurrence from an atomic tactic.
		*
		* @param id Gui id of the atomic tactic.
		* @param graph Graph id in which the occurrence was.
		* @param index Graph index in which the occurrence was.
		* @param node Node id of the occurrence to remove.
		* @return Boolean notifying if it was the last occurrence of the atomic tactic.
		* @throws AtomicTacticNotFoundException If the atomic tactic is not in the collection.
		*/
	def removeATOccurrence(id:String, graph:String, index:Int, node:String):Boolean = {
		atCollection get id match {
			case Some(t:AtomicTactic) =>
				t.removeOccurrence(Tuple3(graph,index,node))
				t.occurrences.isEmpty
			case None =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method to get the number of occurrences of a atomic tactic.
		*
		* @param id Gui id of the atomic tactic.
		* @throws AtomicTacticNotFoundException If the atomic tactic was not found.
		* @return Number of occurrences of the atomic tactic.
		*/
	def getATNumberOfOccurrences(id:String):Int = {
		atCollection get id match {
			case Some(t: AtomicTactic) =>
				t.occurrences.size
			case None =>
				throw new AtomicTacticNotFoundException(id)
		}
	}

	/** Method loading a collection of atomic tactics from a json.
		*
		* Note that loading an existing atomic tactic (with the same name) will override its value and occurrences.
		*
		* @param j Json input.
		* @throws BadJsonInputException If input's structure is not correct.
		*/
	def loadATFromJson(j: JsonArray) {
		try {
			j.foreach {
				case o:JsonObject =>
					val at = AtomicTactic(o)
					atCollection += at.name -> at
				case o:Json => throw new BadJsonInputException("New atomic tactic : expected json object, got "+o.getClass)
			}
		} catch {
			case e:BadJsonInputException => throw e
		}
	}
}