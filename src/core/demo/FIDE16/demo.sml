val tinkerhome = OS.FileSys.getDir() ^ "/../GIT/tinker";
use_file (tinkerhome ^ "/src/core/demo/FIDE16/tacas_setup");


val g : GOAL = 
 ([],
   �(� (x, r) � ((� x0 � x0 > (x:�)) � (� (y,z)� � y0� y0 < (y:�)))) � 
    (� (m, r) � (m = (2 : �) � (m + m = m * m)))�);

 val t = PSGraph.read_json_file NONE (pspath ^"simple_quantifier_tac.psgraph") |>   PSGraph.set_goaltype_data data; 

 set_goal g;
 apply_ps_i t;

 top_goal_state() |> print_goal_state;

 drop_main_goal();
 TextSocket.safe_close();
