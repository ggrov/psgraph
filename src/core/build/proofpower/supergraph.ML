  val root_path = OS.FileSys.getDir();
  val build_path = root_path ^ "/psgraph/src/core/provers/proofpower/build";
  val supergraph_path = root_path ^ "/experiment/supertac_c/supergraph/";
  OS.FileSys.chDir build_path;

  open_theory "CLTSpec_Common";

  use "load_psgraph";
  use "build_clause_GT.ML"; 
  
  use_file "../pp_utils.ML"

  (*use "build_simple_GT.ML";*) 

  use_file (supergraph_path ^ "open_struct/open_struct.ML");
  use_file (supergraph_path ^ "open_struct/open_end_proof.ML");
  use_file (supergraph_path ^ "supergraph.ML"); 
  (*use_file (supergraph_path ^ "simpleGT_supergraph.ML");*) 

  OS.FileSys.chDir root_path;

(* enable the subgoal package printing 
  set_flags [
  ("subgoal_package_quiet", false), (* enable xpp output *)
  ("output_in_utf8", false), 
  ("input_in_utf8", false)];(* disable uftp-8 encoding for GUI *)
*)
  new_theory "supergraph";

