package tinkerGUI

/** ==TinkerGUI model package==
	* Provides classes dealing with the psgraph model used to run Tinker's interface.
  *
	* ==Overview==
	* The main class to use is [[tinkerGUI.model.PSGraph]] :
	* {{{
	*   import tinkerGUI.model.PSGraph
	*   ...
	*   val myPSGraphModel = new PSGraph()
	* }}}
	*
	* Using this variable allows to read and write the model, the purpose being to generate a Json object of this psgraph model that can be used by provers :
	* {{{
	*   myPSGraphModel.updateJsonPSGraph()
	*   val json = myPSGraphModel.jsonPSGraph
	* }}}
	*
	* Manipulating the model may raise exceptions, see [[tinkerGUI.model.exceptions]], although Json exceptions are handled in the [[quanto.util.json]] package.
	*
	* A psgraph model in a Json format should contain the following fields :
	*  - '''main''' : a string pointing to the root graph tactic of the proof ;
	*  - '''current''' : a stack showing which tactic in the hierarchy is currently used, the stack contains strings pointing to the said tactic and its parents in the hierarchy ;
	*  - '''current_index''' : an integer indicating which subgraph in the current tactic is used ;
	*  - '''goal_types''' : a string defining goal types for the prover ;
	*  - '''occurrences''' : a set of occurrences per tactic, referring to their uses in the model, an occurrence is a triple with a graph tactic name, a subgraph index, and a node id, occurrences are subdivided into atomic tactics occurrences and graph tactics occurrences ;
	*  - '''atomic_tactics''' : a set of all the atomic tactics used in this psgraph, each of them contain the following fields :
	*   - '''name''' : a string identifying the tactic ;
	*   - '''tactic''' : a string defining the tactic for the prover, if this string is empty, it is assumed that the prover has a definition for it ;
	*  - '''graphs''' : a set of all the graph tactics used by this psgraph (including the root one), each of them containing the following fields :
	*   - '''name''' : a string identifying the tactic ;
	*   - '''branch type''' : a string identifying the type of branching this tactic uses, typically ''OR'' or ''ORELSE'' ;
	*   - '''graphs''' : a set of subgraphs this tactic contains, their format is as follow :
	*    - a set of '''edges''', each of them having :
	*     - an id, a string, typically ''e0'', ''e1'', ... ;
	*     - a goal type, a string holding a predicate a goal has to fulfill to pass on this edge ;
	*     - a source and a target, strings referring to a node id ;
	*    - a set of '''boundary nodes''', each of them having :
	*     - an id, a string, typically ''b0'', ''b1'', ... ;
	*     - coordinates, a pair of double ;
	*    - a set of '''nodes''', each of them having :
	*     - an id, a string, typically ''v0'', ''v1'', ... ;
	*     - a type, a string referring to the type of node, typically ''T_Identity'', ''T_Atomic'', ''T_Graph'', ''G_Break'', or ''G'' ;
	*     - coordinates, a pair of double ;
	*     - Atomic and Graph nodes have a field referring to a tactic in the model, a field for its arguments (a list of list of string) and a field for their label ;
	*     - Goal nodes have a field for their label and a field for their value.
  */
package object model {

}
