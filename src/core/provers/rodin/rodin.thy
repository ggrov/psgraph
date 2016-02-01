theory rodin                                           
imports       
  "./TinkeringRodin"
begin

ML{*structure C = Clause_GT*}
ML_file "./goaltype/clausalGT.ML"

ML{*
  fun finish ()  =
  (RodinSock.send (toJson ("SESSION_END",[]));
   RodinSock.disconnect ())

*}

ML{*
LoggingHandler.active_all_tags ();
LoggingHandler.print_active();

*}
ML{*
  open RodinHelper
     val on_hyp="on_hyp"
     val on_goal=  "on_goal"
     val auto_tactic=  "auto_tactic" 
(* 
     val ENV_left ="ENV_left"
     val ENV_hyps="ENV_hyps"
     val ENV_topsymbol_is="ENV_topsymbol_is"
      *)
     
(* 
     fun ENV_hyps args env pnode = 
      let val reply = execute ("GET_HYPS",[("NODE",pnode)])
          val hyps = getParamValues reply |> map (fn x => C.Prover.E_Str x)
          val C.Prover.A_Var var_name = List.hd args 
          val new_env=  StrName.NTab.ins (var_name,(C.Prover.E_L hyps)) env
      in            
        new_env
      end
     fun ENV_left args env pnode = 
      let val C.Prover.A_Str term = List.nth (args,1) 
          val C.Prover.A_Var var_name = List.hd args
          val C.Prover.E_L env_list = StrName.NTab.get env var_name
          val term_list  = env_list |> map (fn C.Prover.E_Str x => x) |> List.filter
            (
              fn x => 
              let  val reply = execute ("LEFT_IS",[("TERM",x), ("LEFT",term),("NODE", pnode)])
                  val result= getParam reply "RESULT"
              in
                  case result of "true" => true | _ => false
              end
            )
          val new_list = term_list |> map (fn x => C.Prover.E_Str x)

          val new_env = StrName.NTab.update (var_name, (C.Prover.E_L new_list)) env
       in
        new_env
       end
     
     fun ENV_topsymbol_is args env pnode = 
      let val C.Prover.A_Str symb = List.nth (args,1)
          val C.Prover.A_Var var_name = List.hd args
          val C.Prover.E_L env_list = StrName.NTab.get env var_name
          val term_list = env_list |> map (fn C.Prover.E_Str x => x) |> List.filter
            (fn x => 
              let  val reply = execute ("TOP_SYMB_IS",[("TERM",x), ("SYMB",symb),("NODE", pnode)])
                  val result= getParam reply "RESULT"
              in
                  case result of "true" => true | _ => false
              end
            )
          val new_list = term_list |> map (fn x => C.Prover.E_Str x)
          val new_env = C.Prover.E_L new_list
      in
         StrName.NTab.update (var_name,new_env) env
      end
      
     val autoprove="autoprove"

     val a = Theory.Graph_Utils.is_env_tactic_name "ENV_topsymbol_is" *)

*}
(* read and load a psgraph created by gui *)
ML{* 
 
  
*} 




ML{*

*}  
ML{*
open RJP;      

fun disconn_gui() = 
let open Json;
  val jobj=(Json.mk_object[("cmd", Json.mk_object[("name", Json.String  "CMD_END_EVAL_SESSION")])])
  in
    TextSocket.write (TextSocket.safe_local_client 1790) (Json.encode jobj)

end


*}
ML{*-
   RodinSock.disconnect (); 
*}
ML{*-
  TextSocket.safe_close();    
*}
 
ML{*-
  TextSocket.close ;   
*}

ML{*


fun EVAL_RODIN () = 
    let 
    val _ = writeln "eval_ start"
    val _ = SimpleNamer.init();
    val path2 =    
        let open RodinHelper in
           writeln "getting psgraph";
           get_psgraph() 
           handle exn => 
           case exn of RodinSock.Prover_exit => raise RodinSock.Prover_exit
               | a => (writeln "Waiting for Rodin to connect"; raise a)
           
        end;
    val _= writeln "got psgraph";
    val _ = writeln path2;
    val _ =  writeln "read psgraph";
    val ps = PSGraph.read_json_file NONE (path2)|> PSGraph.set_goaltype_data data ; 
    val _ =  writeln "starting eval";
    val _ = (Tinker.start_ieval "" (SOME ps) (SOME []) (SOME ""))
      handle exn => 
      (
         writeln " eval exn";
        (* finish(); *)
        TextSocket.safe_close(); 
        writeln " socket close";
        raise exn
      )
    
    in 
      PolyML.print "Tinkering Rodin...Done";
      finish();
       writeln " finishe";
      ()
    end;

fun Tinker_Main () repeat  = 
  (
    EVAL_RODIN()
    handle exn => (
        case exn of RodinSock.Prover_exit => 
            ( writeln "Rodin Exit";
            finish();
            disconn_gui();
            TextSocket.safe_close(); 
            (OS.Process.exit OS.Process.success))
        | RodinSock.Prover_cancellation => 
          ( writeln "Rodin Cancelled"; 
            finish();
            ())
        | e => ()
    ); 
    if repeat<100 then
    Tinker_Main () (repeat+1)
    else
    ()
  );

*}
