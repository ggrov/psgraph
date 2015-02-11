(* simple test of proof representation *)
theory BIsaP                                             
imports       
  "../../../../build/isabelle/Tinker"                                                                               
begin 
 
(* simple test of proof representation *)
      
ML{*
  val atomic_tracing = (*tracing*) (fn _ => ());
  val isar_tracing = (*tracing*) (fn _ => ());
*}

(* wrapping trm with name structure *)
  ML_file "../../termlib/rippling/unif_data.ML" 
  ML_file "../../termlib/rippling/collection.ML"   
  ML_file "../../termlib/rippling/pregraph.ML"  
  ML_file "../../termlib/rippling/rgraph.ML" 
  
  ML_file "../../termlib/rippling/embedding/paramtab.ML" 
  ML_file "../../termlib/rippling/embedding/trm.ML"  
  ML_file "../../termlib/rippling/embedding/isa_trm.ML"
  ML_file "../../termlib/rippling/embedding/instenv.ML"
  ML_file "../../termlib/rippling/embedding/typ_unify.ML"   

(* embeddings *)
  ML_file "../../termlib/rippling/embedding/eterm.ML"  
  ML_file "../../termlib/rippling/embedding/ectxt.ML" 
  ML_file "../../termlib/rippling/embedding/embed.ML" 
 
(* measure and skeleton *)
  ML_file "../../termlib/rippling/measure_traces.ML"
  ML_file "../../termlib/rippling/measure.ML" 
  (*ML_file "../../provers/isabelle/termlib/rippling/flow_measure.ML"*)
  ML_file "../..//termlib/rippling/dsum_measure.ML" 

(* wave rule set *)
  ML_file  "../../termlib/rippling/rulesets/substs.ML"
                         
  ML_file "../../termlib/term_fo_au.ML"  
  ML_file "../../termlib/term_features.ML"   


  ML_file "../isa_prover.ML"                     

(* rippling *) 
  ML_file "../../termlib/rippling/basic_ripple.ML" 
(* induction *)
  ML_file "../../termlib/induct.ML"

  ML_file "../simple_goaltyp.ML"         
                            

ML{*
   structure GT : BASIC_GOALTYPE = SimpleGoalTyp;
   structure Data = PSGraphDataFun(GT);
*}

ML{*
  structure PSDataIO = PSGraphIOFun(structure Data = Data);
*}
ML{*
structure Theory = PSGraph_TheoryFun(structure GoalTyp = SimpleGoalTyp  
                                     structure Data = Data);
*}
ML{*
structure Theory_IO = PSGraph_Theory_IOFun(structure PSTheory = Theory)
*}
ML{*
structure PSGraph = PSGraphFun(Theory_IO);
*}     
          
ML{*
 PSGraph.empty;
*}

ML{*
structure PSComb = PSCombFun (structure PSGraph = PSGraph)
*}

ML{*
structure EData =  EDataFun( PSGraph);
structure EVal = EValFun(EData);
structure IEVal = InteractiveEvalFun (EVal);
structure Tinker = TinkerProtocol (IEVal);
*}

end



