(* simple test of proof representation *)
theory eval_test                                           
imports       
  "../build/BIsaP"    
begin

(* create a new graph *)
ML{*
  val asm = RTechn.id
            |> RTechn.set_name (RT.mk "assumption")
            |> RTechn.set_atomic_appf (RTechn.Tactic (RTechn.TAllAsm, "atac"));

   val intro = RTechn.id
            |> RTechn.set_name (RT.mk "rule impI | conjI")
            |> RTechn.set_atomic_appf (RTechn.Rule (StrName.NSet.of_list ["impI","conjI"]));

   val frule = RTechn.id
            |> RTechn.set_name (RT.mk "frule conjuncts")
            |> RTechn.set_atomic_appf (RTechn.FRule (C.mk "conj",StrName.NSet.of_list ["conjunct1","conjunct2"]));

   val gt = SimpleGoalTyp.default;

  infixr 6 THENG;
  val op THENG = PSComb.THENG;

  val psintro = PSComb.LIFT ([gt],[gt]) (intro);
  val psfrule = PSComb.LIFT ([gt],[gt]) (frule);
  val psasm = PSComb.LIFT ([gt],[]) (asm);
  val psfg3 = psintro THENG  psintro THENG psfrule THENG psasm;
  val psgraph = psfg3 PSGraph.empty;
*}

(* create a new proof node *)     
ML{*
val edata0 = EVal.init psgraph @{context} @{prop "A \<and> B \<longrightarrow> B \<and> A"} |> hd;
*}

ML{*
val pp = EData.get_pplan edata0;
val gn = EData.get_goals edata0 |> StrName.NTab.values |> hd;
*}
ML{*
BIsaAtomic.apply_rule "test" @{thm "impI"} (gn,pp) |> Seq.list_of;
open BIsaAtomic_DB;
*}

(* show graph *)
ML{*
PSGraph.PSTheory.write_dot "/u1/staff/gg112/test.dot" (EData.get_graph edata0)
*}


(* maybe have a debug mode? could spit out a lot of details *)
ML{*
EVal.EGraph.Util.all_rtechns (EData.get_graph edata0)
*}



(* why aren't nodes printed as lists? *)
ML{*
val edata1 = EVal.evaluate_any edata0 |> Seq.list_of |> hd;
PSGraph.PSTheory.write_dot "/u1/staff/gg112/test2.dot" (EData.get_graph edata1) 
*}

ML{*
 val edata1a = EVal.normalise_gnode edata1;
 val edata1a = EVal.normalise_gnode edata1a; 
PSGraph.PSTheory.write_dot "/u1/staff/gg112/test2a.dot" (EData.get_graph edata1a) 
*}

ML{*
val edata2 = EVal.evaluate_any edata1a |> Seq.list_of |> hd 
val edata2' = EVal.normalise_gnode edata2; 
PSGraph.PSTheory.write_dot "/u1/staff/gg112/test3.dot" (EData.get_graph edata2);  
PSGraph.PSTheory.write_dot "/u1/staff/gg112/test3_1.dot" (EData.get_graph edata2') 
*}

ML{*
  val r = EVal.EGraph.del_empty_gnode;
  val lhs = EVal.EGraph.Theory.Rule.get_lhs r;
  val rhs = EVal.EGraph.Theory.Rule.get_rhs r;  
PSGraph.PSTheory.write_dot "/u1/staff/gg112/rhs.dot" (rhs) ;
PSGraph.PSTheory.write_dot "/u1/staff/gg112/lhs.dot" (lhs); 
*}
ML{*
val edata3 = EVal.evaluate_any edata2 |> Seq.list_of |> hd |> EVal.normalise_gnode; 
PSGraph.PSTheory.write_dot "/u1/staff/gg112/test3.dot" (EData.get_graph edata2) 
*}



ML{*
structure V = EData.PSGraph.PSTheory.PS_GraphParam.PSVertexData;
open V;
*}

ML{*
match_data (l,v) empty_subst
*}
(* frule never called! *)
ML{*
val edata3 = EVal.evaluate_any edata2 |> Seq.list_of |> hd; 
PSGraph.PSTheory.write_dot "/u1/staff/gg112/test4dot" (EData.get_graph edata2) 
*}
       
end



