open_theory "z_library";

use (OS.FileSys.getDir() ^ "/psgraph/src/core/build/proofpower/tinker");
val tinker_path = OS.FileSys.getDir()  ^ "/psgraph/";

val pspath = tinker_path ^ "src/core/examples/JFR16/psgraph/";

fun prove_with_ctxt0 ctxt = PC_T1 ctxt prove_tac [];
fun prove_with_ctxt [PPProver.A_Str ctxt] = PC_T1 ctxt prove_tac []
| prove_with_ctxt _ = fail_tac;

(*=====  GoalTyp definitions *)
 val clause_def = 
 "is_set() :- top_symbol(concl, member)." ^
 "is_arith() :- !top_symbol(concl,member).";

 val data = 
  default_gt_data
  |> ClauseGoalTyp.update_data_defs (fn x => (ClauseGoalTyp.scan_data PPProver.default_ctxt clause_def) @ x);

val simple = PSGraph.read_json_file (SOME data) (pspath^"simple.psgraph");

set_goal([], ��x� (1, x) � {(a, b) | a = 1 � b � 2} � (x � 3 � x � 4)�);
PPIntf.apply_ps_i simple;

top_thm();

TextSocket.safe_close();
