theory prooftest  
imports
  "../provers/isabelle/build/basic/Eval"             
begin

-- "the conjunction wire"
ML{*
val conj_feature = Feature.Strings (StrName.NSet.single "HOL.conj","top-level-const");
val conj_bwire = BWire.default_wire
|> BWire.set_pos (F.NSet.single conj_feature)
|> BWire.set_name (SStrName.mk "asm_conj");
val conj_wire = Wire.default_wire
|> Wire.set_name (SStrName.mk "asm_conj")
|> Wire.set_facts (BW.NSet.single conj_bwire);
*} 

-- "the reasoning techniques"
ML{*
val simple_impI =
RTechn.id
|> RTechn.set_name "impI"
|> RTechn.set_inputs (W.NSet.single Wire.default_wire)
|> RTechn.set_outputs (W.NSet.single Wire.default_wire)
|> RTechn.set_atomic_appf (RTechn.Rule (StrName.NSet.single "HOL.impI"));

val impI =
RTechn.id
|> RTechn.set_name "impI"
|> RTechn.set_inputs (W.NSet.single Wire.default_wire)
|> RTechn.set_outputs (W.NSet.single conj_wire)
|> RTechn.set_atomic_appf (RTechn.Rule (StrName.NSet.single "HOL.impI"));

val conjI =
RTechn.id
|> RTechn.set_name "conjI"
|> RTechn.set_inputs (W.NSet.single conj_wire)
|> RTechn.set_outputs (W.NSet.single conj_wire)
|> RTechn.set_atomic_appf (RTechn.Rule (StrName.NSet.single "HOL.conjI"));

val fwd_conjunct =
RTechn.id
|> RTechn.set_name "fwd_conjunct"
|> RTechn.set_inputs (W.NSet.single conj_wire)
|> RTechn.set_outputs (W.NSet.single Wire.default_wire)
|> RTechn.set_atomic_appf (RTechn.FRule ("asm_conj",StrName.NSet.of_list ["conjunct1","conjunct2"]));

val artechn = RTechn.id
|> RTechn.set_name "assumption"
|> RTechn.set_atomic_appf (RTechn.Tactic (RTechn.TAllAsm,"atac"))
|> RTechn.set_inputs (W.NSet.single Wire.default_wire)
|> RTechn.set_outputs (W.NSet.single Wire.default_wire);

*}

ML{*
(* set path to where you want the graphs written *)
val path = "/u1/staff/gg112/";
*}

-- "short example"
ML{*
val gf = LIFTRT simple_impI THENG LIFTRT artechn;
val edata0 = RTechnEval.init_f @{theory} [@{prop "A --> A"}] gf;
*}

ML{*
val [edata] = RTechnEval.eval_any edata0 |> Seq.list_of;
Strategy_Dot.write_dot_to_file false (path ^ "vsimplex.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

ML{*
val [edata] = RTechnEval.eval_any edata |> Seq.list_of;
Strategy_Dot.write_dot_to_file false (path ^ "vsimplex.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

(* to do (Colin)
- use pplan object (see proof/pplan.ML and proof/pnode.ML)
- try to turn the tree into a structured proof
*)
ML{*
val pplan = RTechnEval.EData.get_pplan edata;
(* root node (name) *)
val roots = PPlan.get_root_nms pplan;
(* turn into a singleton list *)
val [rootname] = StrName.NSet.list_of roots;
(* get the actual root node *)
val (SOME root) = PPlan.lookup_node pplan rootname;
(* get the children (now using proof node) *)
val childnames = PNode.get_result root;

val script = Pretty.block
[Pretty.str "lemma: ",
Syntax.pretty_term (PNode.get_ctxt root) (Thm.concl_of (PNode.get_goal root))];

val script = Pretty.block [script,Pretty.fbrk,Pretty.str "proof -",Pretty.fbrk,Pretty.str "qed"];

Pretty.writeln (Print_Mode.setmp [] (fn () => script) ())
*}

(*
;
*)



(* fixme: fails in exporting *)
ML{*
PPExpThm.export_name (RTechnEval.EData.get_pplan edata) "g" |> PPExpThm.prj_thm
*}


-- "long example"
ML{*
val gf = LIFTRT impI THENG LIFTRT conjI THENG LIFTRT fwd_conjunct THENG LIFTRT artechn;
val edata0 = RTechnEval.init_f @{theory} [@{prop "A \<and> B --> B \<and> A"}] gf;
*}

ML{*

(* creates a dot file (open with graphviz) *)
Strategy_Dot.write_dot_to_file false (path ^ "simplex.dot")
(RTechnEval.EData.get_graph edata0 |> Strategy_Theory.Graph.minimise);
*}

ML{*
val [edata] = RTechnEval.eval_any edata0 |> Seq.list_of;
Strategy_Dot.write_dot_to_file false (path ^ "simplex.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

ML{*
val [edata] = RTechnEval.eval_any edata |> Seq.list_of;
Strategy_Dot.write_dot_to_file false (path ^ "simplexdebug.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

ML{*
val [edata] = RTechnEval.eval_full edata |> Seq.list_of;
Strategy_Dot.write_dot_to_file false (path ^ "simplexdebug.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

ML{*
PPlan.print (RTechnEval.EData.get_pplan edata)
*}

(* problem is facts is not working *)
ML{*
val graph = RTechnEval.EData.get_graph edata;
val gns = GraphEnv.get_goalnodes_of_graph graph |> V.NSet.list_of;
val [g1,g2] = map (GraphEnv.v_to_gnode graph) gns;
*}

ML{*
val pplan = RTechnEval.EData.get_pplan edata;
val (SOME goal) = PPlan.lookup_node pplan "j";
val assms = PNode.get_assms goal;
val lassms = PNode.get_lassms goal;
val th1 = StrName.NTab.get assms "h";
val th2 = [@{thm conjunct1},@{thm conjunct2}];
*}

ML{*
WMatch.bwire_match (RTechnEval.EData.get_fmatch edata) (PNode.get_ctxt goal) conj_bwire th1
*}


ML{*
val (_,prf) = PPlanEnv.apply_frule (goal,pplan) [th1] th2;
PPlan.print prf
*}

ML{*
val [edata] = RTechnEval.eval_any edata |> Seq.list_of;
Strategy_Dot.write_dot_to_file false (path ^ "simplex.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

ML{*
val edata = RTechnEval.eval_any edata |> Seq.list_of |> hd;
Strategy_Dot.write_dot_to_file false (path ^ "simplex.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

ML{*
val edata = RTechnEval.eval_any edata |> Seq.list_of |> hd;
Strategy_Dot.write_dot_to_file false (path ^ "simplex.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

ML{*
val edata = RTechnEval.eval_any edata |> Seq.list_of |> hd;
Strategy_Dot.write_dot_to_file false (path ^ "simplex.dot") (RTechnEval.EData.get_graph edata |> Strategy_Theory.Graph.minimise);
*}

ML{*
PPlan.print (RTechnEval.EData.get_pplan edata)
*}


end;

