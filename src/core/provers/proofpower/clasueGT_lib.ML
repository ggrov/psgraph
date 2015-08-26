structure ClauseGT_Lib = 
struct
 local open LoggingHandler TermFeatures in
 (* use a symbol table to represent those non-standdatd ascii symbols *)
 val symbol_table : string StrName.NTab.T Unsynchronized.ref  = Unsynchronized.ref StrName.NTab.empty;
 fun init_symbol_table l = symbol_table := StrName.NTab.of_list l; 
 
 fun decode_str str = case StrName.NTab.lookup (!symbol_table) str of (SOME str') => str' | _ => str;

 fun top_level_str' trm = 
  case top_level_str trm of
     NONE => []
   | SOME v => [decode_str v];

 fun top_symbol env pnode [r,ClauseGoalTyp.Var p] = 
        let 
          val tops = ClauseGoalTyp.project_terms env pnode r
                   |> maps top_level_str'
        in 
          (case StrName.NTab.lookup env p of
             NONE => map (fn s => StrName.NTab.ins (p,ClauseGoalTyp.Prover.E_Str s) env) tops
           | SOME (ClauseGoalTyp.Prover.E_Str s) => if member (op =) tops s then [env] else []
           | SOME _ => [])
        end
  |  top_symbol env pnode [r,ClauseGoalTyp.Name n] = 
        let 
          val tops = ClauseGoalTyp.project_terms env pnode r
                   |> maps top_level_str'
        in 
           if member (op =) tops n then [env] else []
        end
  |  top_symbol env pnode [r,ClauseGoalTyp.PVar p] = 
        let 
          val tops = ClauseGoalTyp.project_terms env pnode r
                   |> maps top_level_str'
        in 
          (case StrName.NTab.lookup (ClauseGoalTyp.Prover.get_pnode_env pnode) p of
             NONE => []
           | SOME (ClauseGoalTyp.Prover.E_Str s) => if member (op =) tops s then [env] else []
           | SOME _ => [])
        end
  | top_symbol _ _ [] = []
  | top_symbol _ _ [_,_] = []
  | top_symbol env pnode (x::xs) =
      maps (fn r => top_symbol env pnode [x,r]) xs;
   
end (* end of local *)
end;
open ClauseGT_Lib;
val _ = init_symbol_table [("%and%", "conj"), ("%implies%", "implies")];
