theory taut_tac
imports ai4fm_setup
begin
ML{*   
  (* define your local path here *)
  val pspath = OS.FileSys.getDir() ^ "/Workspace/StrategyLang/psgraph/src/dev/ai4fm/"
  val ps_file = "simple_taut.psgraph";
*}
  
ML{*
  val clause_def = 
 "c(Z) :- top_symbol(concl,Z)." ^
 "h(Z) :- member(X,hyps), top_symbol(X,Z)." ^
 "is_goal(Z) :- eq_term(concl, Z)." ^
 "has_hyp(Z) :- eq_term(hyps, Z)." ^
 "c_not_var(X) :- c(X), dest_term(concl, _, Y2), !is_var(Y2)." ^
 "h_not_var(X) :- member(X,hyps), top_symbol(X,Z), dest_term(Y, _, Z2), !is_var(Z2)." ^
 "asm_to_elim() :- h(conj)." ^
 "asm_to_elim() :- h(disj)." ^
 "asm_to_elim() :- h(eq)." ^
 "asm_to_elim() :- h(implies)." ^
 "asm_to_elim() :- h_non_var(not)." ^
 "taut_simp() :- is_goal(\"True\")." ^
 "taut_simp() :- has_hyp(concl)." ^
 "taut_simp() :- c(conj)." ^
 "taut_simp() :- c(disj)." ^
 "taut_simp() :- c(eq)." ^
 "taut_simp() :- c(implies)." ^
 "taut_simp() :- c_not_var(not).";

  val data =  
  data  
  |> Clause_GT.update_data_defs (fn x => (Clause_GT.scan_data IsaProver.default_ctxt clause_def) @ x);

  val taut = PSGraph.read_json_file (SOME data) (pspath ^ ps_file);
*}

ML{*
fun eval_text text =(
      (*writeln ("exec : "^ text);*)
      Secure.use_text ML_Env.local_context (1, "pp") (false) text  
    ) 
*}

ML{*-
TextSocket.safe_close();
*}

lemma "(A \<and> A \<and> B) \<longrightarrow> (B \<and> A \<and> True)"
ML_val{*
     val st = #goal @{Isar.goal};
     writeln (Proof_Display.string_of_goal @{context} st);
 val g = Thm.concl_of st;
val thm = Tinker.start_eval @{context} ( taut) ( []) ( g) (* prove the goal *)
          |> EData.get_pplan |> IsaProver.get_goal_thm(* get the theorem *)
*}

lemma "True"
ML{*-
  TextSocket.safe_close();
*}  

ML{* 
val g = @{prop "(A \<and> A \<and> B) \<longrightarrow> (B \<and> A \<and> True)"};
val thm = Tinker.start_eval @{context} ( taut) ( []) ( g) (* prove the goal *)
          |> EData.get_pplan |> IsaProver.get_goal_thm(* get the theorem *)
*}

ML{*-
val g = @{prop "(A \<and> A \<and> B) \<longrightarrow> (B \<and> A \<and> True)"};
val thm = Tinker.start_ieval @{context} (SOME taut) (SOME []) (SOME g) (* prove the goal *)
          |> EData.get_pplan |> IsaProver.get_goal_thm(* get the theorem *)
*}

ML{*-
val g =  @{prop "\<not> ( False \<and> (\<not>True))"};
val thm = Tinker.start_ieval @{context} (SOME taut) (SOME []) (SOME g) (* prove the goal *)
          |> EData.get_pplan |> IsaProver.get_goal_thm(* get the theorem *)
*}

ML{* -
val g = @{prop "(A \<or> B) \<longrightarrow> (B \<or> A)"};
val thm = Tinker.start_ieval @{context} (SOME taut) (SOME []) (SOME g) (* prove the goal *)
          |> EData.get_pplan |> IsaProver.get_goal_thm(* get the theorem *)
*}
end
