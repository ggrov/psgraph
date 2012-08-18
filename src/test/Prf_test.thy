(* simple test of proof representation *)
theory Prf_test                                                
imports        
  Main       
  "../build/IsapLib"                                         
uses
  "../proof/pnode.ML"                                                                                                                                                           
  "../proof/prf.ML"                   
begin

lemma "\<And> x. P x"
proof -
  fix x
  show "P x"
  proof -
   show "P x" sorry
  qed
qed

(*    fun fix_all_params' params alledt = 
        let val t = Term.strip_all_body alledt;
            val alls = rev (Term.strip_all_vars alledt);
            val ((newps, renamings), params2) = concat_to_params alls params;
        in (Term.subst_bounds (map Free newps, t), (newps, params2)) end;
*)

ML{*
Proof.add_fixes @{context} @{term "\<And> x y z. P x y \<Longrightarrow> (\<And> x. Q x z)"};
*}

(*
 meta-level quantifiers-- requires binding intro, has to done right away.
*)


(* quantifiers and free variables:
    free -> use Variable.lookup_fixed to filter
    /\ bound : see how it is done in isaplanner
      -> may need to "re-parse" 
 *)

ML{*
 val (gn,prf) = Proof.init @{context} @{term "(\<forall> x. P x) ==> \<forall> x. P x"};
 Proof.export_name prf (PNode.get_name gn);
 val ([g1],prf) = Proof.apply_tac (K (rtac @{thm allI} 1)) (gn,prf) |> Seq.list_of |> hd;
 val ([],prf) = Proof.apply_all_asm_tac (auto_tac) (g1,prf) |> Seq.list_of |> hd;
 Proof.export_name prf (PNode.get_name gn);
*}

(* this is fine *)
ML{*
 val (gn,prf) = Proof.init @{context} @{term "(\<And> x. P x) ==> (\<And> x. P x)"};
 val ([g1],prf) = Proof.apply_fixes prf gn;
 val ([],prf) = Proof.apply_all_asm_tac (auto_tac) (g1,prf) |> Seq.list_of |> hd;
 Proof.export_name prf (PNode.get_name gn);
*}

(* this is fine *)
ML{*
 val (gn,prf) = Proof.init @{context} @{term "(\<And> x. P x ==> P x)"};
 val ([g1],prf) = Proof.apply_fixes prf gn;
 val ([],prf) = Proof.apply_all_asm_tac (auto_tac) (g1,prf) |> Seq.list_of |> hd;
 Proof.export_name prf (PNode.get_name gn);
*}

(* this is fine *)
ML{*
 val (gn,prf) = Proof.init @{context} @{term "(\<And> x. P x) ==> \<exists> x. P x"};
 val ([g1],prf) = Proof.apply_tac (K (rtac @{thm exI} 1)) (gn,prf) |> Seq.list_of |> hd;
 val ([],prf) = Proof.apply_all_asm_tac (auto_tac) (g1,prf) |> Seq.list_of |> hd;
 Proof.export_name prf (PNode.get_name gn);
*}

(* problem is when x is bound in the proof.. *)
ML{*
 val (gn,prf) = Proof.init @{context} @{term "(\<forall> x. P x) ==> \<forall> x. P x"};
 Proof.export_name prf (PNode.get_name gn);
 val ([g1],prf) = Proof.apply_tac (K (rtac @{thm allI} 1)) (gn,prf) |> Seq.list_of |> hd;
 val ([g2],prf) = Proof.apply_fixes prf g1;
 val ([],prf) = Proof.apply_all_asm_tac (auto_tac) (g2,prf) |> Seq.list_of |> hd;


 val (Proof.EClosed thm) = Proof.export_name prf (PNode.get_name g1); 
 val g = PNode.get_goal gn;  
 val (SOME gn') = Proof.lookup_node prf (PNode.get_name gn);
 val g' = PNode.get_goal gn';
*}

(* FIXME: 
ML{*
 val (Proof.EClosed thm) = Proof.export_name prf (PNode.get_name g2); 
 (Goal.conclude thm) RS g';
*}
notation ( output) "prop" ("#_" [1000] 1000)
ML{*
 g';
 thm;
 Goal.conclude thm;
 Goal.conclude g';
 (Goal.conclude thm) RS (Goal.conclude g');
 Proof.export_name prf (PNode.get_name gn);
 (Goal.conclude thm) RS g';
*}
 

(* also fails when no assumptions... *)
ML{*
 val (gn,prf) = Proof.init @{context} @{prop "(\<forall> x. (x::nat) \<ge> 0)"};
 Proof.export_name prf (PNode.get_name gn);
 val ([g1],prf) = Proof.apply_tac (K (rtac @{thm allI} 1)) (gn,prf) |> Seq.list_of |> hd;
 val ([],prf) = Proof.apply_all_asm_tac (auto_tac) (g1,prf) |> Seq.list_of |> hd;
 (* Proof.export_name prf (PNode.get_name gn); *)
*}

ML{*
 val c = Thm.cterm_of @{theory} @{prop "(\<forall> x. (x::nat) \<ge> 0)"} ;
 val g = Goal.init c;
 val g2 = rtac @{thm allI} 1 g |> Seq.list_of |> hd;
 val g3 = auto_tac @{context} g2 |> Seq.list_of |> hd;
 val g4 = Goal.conclude g3;

 val c' = Thm.cterm_of @{theory} @{prop "(\<And> x. (x::nat) \<ge> 0)"};
 val g' = Goal.init c'; 
 val g1' = auto_tac @{context} g' |> Seq.list_of |> hd;
 val mg = Goal.conclude g1';
 g2;
 rtac mg 1 g2 |> Seq.list_of;
 mg RS g2;
*}

lemma test: "\<And> x. 0 \<le> (x::nat)"
 apply auto
 done

thm test

ML{*
  @{thm test} RS (PNode.get_goal g1);
*}


 ML{* 

*}

ML{*
 val (gn,prf) = Proof.init @{context} @{prop "\<exists> x. P x"};
 Proof.export_name prf (PNode.get_name gn);
 val ([g1],prf) = Proof.apply_tac (K (rtac @{thm exI} 1)) (gn,prf) |> Seq.list_of |> hd;
 Proof.export_name prf (PNode.get_name gn); 
 PNode.get_goal g1 |> Thm.prop_of
*}

(* prop seems to work *)
ML{*
@{term "A ==> B ==> A \<and> B"};
 val (gn,prf) = Proof.init @{context} @{term "A ==> B ==> A \<and> B"};
 val ([g1,g2],prf) = Proof.apply_tac (K (rtac @{thm conjI} 1)) (gn,prf) |> Seq.list_of |> hd;
 val ([],prf) = Proof.apply_all_asm_tac (auto_tac) (g1,prf) |> Seq.list_of |> hd;
 val ([],prf) = Proof.apply_all_asm_tac (auto_tac) (g2,prf) |> Seq.list_of |> hd;
 val (Proof.EClosed t1) = Proof.export_name prf (PNode.get_name g1);
 val (Proof.EClosed t2) = Proof.export_name prf (PNode.get_name g2);
 val (Proof.EClosed t) = Proof.export_name prf (PNode.get_name gn);
 val x = Assumption.export false (PNode.get_ctxt g1) (PNode.parent_ctxt g1) t;
 Variable.export (PNode.get_ctxt g1) (PNode.parent_ctxt g1) [x];
*}

ML{*
t2;
t;
val (SOME g) = Proof.lookup_node prf (PNode.get_name gn);
val myt = PNode.get_goal g;
(Goal.conclude t2);
(Goal.conclude t2) RS myt;
*}

(* storing *)
setup {* (snd o Global_Theory.add_thm ((@{binding "tt"},t),[])) *}
thm tt

ML{*
  val t = @{term "\<And> x y. P x y"};
 Variable.focus t @{context}
*}

lemma test:
  fixes "A" "B" (* not sure what fixes does *)
  assumes r: "A & B"
  shows "A"
proof -
 from r have res: "A" by  (rule conjunct1)
 show ?thesis by (rule res)
qed

thm test
consts P :: "nat => bool"

lemma t: "! x. P x" sorry

thm t spec
thm t[THEN spec]


(* example backward proof *)
ML {*
val ctxt0 = @{context};
val ctxt = ctxt0;
(* fixes - for variables (not sure if meta-vars could be used in say goal) *)
val (_, ctxt) = Variable.add_fixes ["A","B"] ctxt;
(* adds assumption - need to name it! (or keep a map from name to thm) *)
val ([r], ctxt) = Assumption.add_assumes [@{cprop "A & B"}] ctxt;
(* start goal *)
val this = Goal.init @{cprop "A"};
(* fwd step *) 
val res = r RS @{thm conjunct1};
(* bck step *)
val this = rtac res 1 this |> Seq.list_of |> hd;
(* export result *)
val this = Assumption.export false ctxt ctxt0 this;
val [this] = Variable.export ctxt ctxt0 [this];
val this = Goal.conclude this; 
*}

(* storing *)
setup {* (snd o Global_Theory.add_thm ((@{binding "mytest"},this),[])) *}

thm mytest test

(* branching example *)
ML {*
val ctxt0 = @{context};
val ctxt = ctxt0;
(* fixes - for variables (not sure if meta-vars could be used in say goal) *)
val (_, ctxt) = Variable.add_fixes ["A","B"] ctxt;
(* adds assumption - need to name it! (or keep a map from name to thm) *)
val ([r], ctxt) = Assumption.add_assumes [@{cprop "A & B"}] ctxt;
(* start goal *)
val this = Goal.init @{cprop "A \<and> B"};

(* fwd step *) 
val res = r RS @{thm conjunct1};
(* bck step *)
val this = rtac @{thm conjI} 1 this |> Seq.list_of |> hd;
Thm.prems_of this |> map (Thm.cterm_of (Proof_Context.theory_of ctxt));

val this = rtac res 1 this |> Seq.list_of |> hd;
(* export result *)
val this = Assumption.export false ctxt ctxt0 this;
val [this] = Variable.export ctxt ctxt0 [this];
val this = Goal.conclude this; 
*}

(* shared meta-variable issues 
   - even any meta-variable issues!!
    - maybe there is quick way of changing current goal.
  say A is shared
   P A
   Q A
   then P A instantiates A to (f g)
   when then export P A to P ?A -> replace all ?A with (f g) and work with P (f g)
   - need to preserve all semantic information
   - but not sure how to instantae P A to start with (make it existential maybe?)

 *)

schematic_lemma a: "PPP ?x" sorry


schematic_lemma "A ==> ?B"
 oops

thm a

axiomatization
  PP :: "bool => bool" and
  QQ :: "bool => bool"
where
  ptrue: "PP True" and
  qfalse: "QQ False"

(* this shouldn't be true!!! *)
lemma "\<exists> x. (P x \<and> Q x)"
 apply (rule exI)
 apply (rule conjI)
 oops

ML {*
val ctxt0 = @{context};
val ctxt = ctxt0;
(* fixes - for variables (not sure if meta-vars could be used in say goal) *)
val (_, ctxt) = Variable.add_fixes ["A","B"] ctxt;
(* adds assumption - need to name it! (or keep a map from name to thm) *)
(* start goal *)
val this = Goal.init @{cprop "\<exists> x. P x \<and> Q x"};
(* fwd step *) 
val res = r RS @{thm conjunct1};
(* bck step *)
val this = rtac @{thm exI} 1 this |> Seq.list_of |> hd;
val this = rtac @{thm conjI} 1 this |> Seq.list_of |> hd;
val this = rtac @{thm ptrue} 1 this |> Seq.list_of |> hd;
val this = rtac @{thm qfalse} 1 this |> Seq.list_of |> hd;
Thm.prems_of this |> map (Thm.cterm_of (Proof_Context.theory_of ctxt));

val this = Assumption.export false ctxt ctxt0 this;
val [this] = Variable.export ctxt ctxt0 [this];
val this = Goal.conclude this; 
*}

(* removing assumptions that are not used *)
ML{*
thin_tac
*}
lemma "A ==> B x ==> C"
apply (thin_tac "A")
apply (tactic {*thin_tac @{context} "B x" 1*})
oops

thm thin_rl
(* problem is using facts! *)


consts
  A :: bool
  B :: bool
  c :: nat

lemma aa: "A = B" sorry

lemma "B"
 using aa apply (rule subst)
 using aa apply (tactic "all_tac")
 oops

(* use of facts - I wonder if parsing only refers to args... *)
lemma "A --> B"
  apply (rule conjI impI)
 oops

notepad
begin
assume a: A and b: B
have "A \<and> B"
apply (tactic "rtac @{thm conjI } 1" )
using a apply (tactic "resolve_tac facts 1" )
using b apply (tactic "resolve_tac facts 1" )

done
have "A \<and> B"
ML_val "@{Isar.goal}"
using a and b
ML_val "@{Isar.goal}" apply (tactic "Method.insert_tac facts 1")
ML_val "@{Isar.goal}"
apply (tactic "(rtac @{thm conjI } THEN_ALL_NEW atac) 1")
done
end






end



