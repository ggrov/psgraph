(* simple test of proof representation *)
theory BIsaMeth                                              
imports       
  BIsaP                                                                             
begin
  
(* socket *)
ML_file "../../../interface/text_socket.ML"
ML_file "../../../interface/ui_socket.ML"

(* json protocol, they are alreay in Quantolib *)
ML_file "../../../interface/json_protocol/controller_util.ML"
ML_file "../../../interface/json_protocol/controller_module.ML"
ML_file "../../../interface/json_protocol/modules/psgraph.ML"
ML_file "../../../interface/json_protocol/controller_registry.ML"
ML_file "../../../interface/json_protocol/protocol.ML"

ML_file "../psgraph_method.ML"        

lemma test: "a = ((a::nat) * 1)" by auto

 -- "method to apply proof strategy"

(*
 method_setup psgraph = 
  {* Scan.lift (Scan.succeed (fn ctxt => SIMPLE_METHOD (PSGraphMethod.psgraph_tac ctxt))) *}
  "application of active psgraph"
*)

 -- "set active strategy"
 declare [[psgraph = "unknown"]]
 
end



