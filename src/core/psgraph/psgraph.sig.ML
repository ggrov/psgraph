signature PS_GRAPH_SHARING = 
sig
  type T
  type subgraph
  type atomic_tacs
  type occurences
  structure Theory: PS_THEORY_SHARING
end

(* contains the data structure for a proof strategy graph *)
signature PS_GRAPH =
sig
  structure Theory : PS_THEORY 

  type T
  type subgraph
  type atomic_tacs  
  type occurences

  exception tactic_exp of string


  val empty : T
  val of_graph : Theory.Graph.T -> T

  (* get methods *)
  val get_top_graph : T -> Theory.Graph.T
  val get_graph_tactics : T -> subgraph StrName.NTab.T
  val get_atomic_tactics : T -> atomic_tacs StrName.NTab.T
  (* val get_tactics : T -> Theory.Data.GoalTyp.Prover.tactic StrName.NTab.T *)
  val get_goaltype_data : T -> Theory.Data.GoalTyp.data
  val get_graph : T -> StrName.NTab.name -> int -> Theory.Graph.T
  val get_graphs : T -> StrName.NTab.name -> Theory.Graph.T list
  val get_atomic_tac_code_and_args : T 
    -> StrName.NTab.name (* atomic tactic node name *)
    -> Theory.GoalTyp.Prover.pnode
    -> (string * Theory.GoalTyp.Prover.arg_data list list) (* return the actual ml code to be evaluated *)
  val get_hgraph_args :  T 
    -> StrName.NTab.name
    -> Theory.Data.arg_typ
  val get_occurs : T -> occurences
  
 (* set methods *)
  val set_top_graph : Theory.Graph.T -> T -> T
  val set_graph_tactics : subgraph StrName.NTab.T -> T -> T
  val set_atomic_tactics : atomic_tacs StrName.NTab.T  -> T -> T  
 (* val set_tactics : Theory.Data.GoalTyp.Prover.tactic StrName.NTab.T -> T -> T *)
  val set_goaltype_data :  Theory.Data.GoalTyp.data -> T -> T
  val set_graph :  StrName.NTab.name -> int -> Theory.Graph.T -> T -> T
  val set_occurs : occurences -> T -> T
 
  (* update methods *)
  val update_top_graph : (Theory.Graph.T -> Theory.Graph.T) -> T -> T
  val update_graph_tactics : (subgraph StrName.NTab.T 
                                  -> subgraph StrName.NTab.T) 
                              -> T -> T
  val update_atomic_tactics : (atomic_tacs StrName.NTab.T 
                                  -> atomic_tacs StrName.NTab.T) 
                              -> T -> T
(*  val update_tactics : (Theory.Data.GoalTyp.Prover.tactic StrName.NTab.T 
                                -> Theory.Data.GoalTyp.Prover.tactic StrName.NTab.T) 
                              -> T -> T *)
  val update_goaltype_data :  (Theory.Data.GoalTyp.data -> Theory.Data.GoalTyp.data)
                              -> T -> T
  val update_occurs : (occurences -> occurences) -> T -> T
  (* fresh name generation *)
  val fresh_name : T -> StrName.name ->  StrName.NSet.name
  
  (* merger two psgraph by add merging all the subfields, exception would be raised when duplicated nodes are found*)
  val merge_disjoint : T -> T -> T

  (* load a list of atomics 
  val load_atomics : (StrName.NTab.name * Theory.Data.GoalTyp.Prover.tactic) list -> T -> T
  *)
  (* json i/o *)
  val output_json : T -> Json.json
  val output_json_as_eval_field : StrName.NTab.name list -> int -> T -> Json.json
  val input_json : Json.json -> T
  val write_json_file : string -> T -> unit
  val read_json_file: string -> T

  val validate_psgraph : T -> bool (* type checking, see issue #44 in the repo *)

  structure Sharing: PS_GRAPH_SHARING
    sharing type Sharing.T = T
    sharing type Sharing.subgraph = subgraph
    sharing type Sharing.atomic_tacs = atomic_tacs
    sharing type Sharing.occurences = occurences
    sharing Sharing.Theory = Theory.Sharing
end