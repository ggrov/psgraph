theory setup_isabelle                                           
imports       
  "../../provers/isabelle/basic/build/BIsaP"    
begin

ML{*
  val path = "/Users/yuhuilin/Documents/Workspace/StrategyLang/psgraph/src/core/demo/AdvisoryBoardMeeting2015/" ;
*}
ML{*
val impI_thm = @{thm impI};
val conjI_thm = @{thm conjI};
fun rule_tac thm _ i =  rtac thm i;
fun id_tac  _ _  = all_tac;
fun assm_tac  _ i = atac i;
*}

(* choose which logging info do we want *)
ML{*
  LoggingHandler.clear_active_tags ();
  LoggingHandler.print_active();
  LoggingHandler.print_all_tags();
  map LoggingHandler.ins_active_tag ["EVAL", "GRAPH", "HIERARCHY", "SOCKET", "TACTIC"];
  LoggingHandler.print_active();
  LoggingHandler.clear_active_tags ();

*}

end