 use_file (OS.FileSys.getDir() ^ "/psgraph/src/core/demo/TACAS16/tacas_setup");

val g : GOAL = 
 ([],
   �(� (x, r) � ((� x0 � x0 > (x:�)) � (� (y,z)� � y0� y0 < (y:�)))) � 
    (� (m, r) � (m = (2 : �) � (m + m = m * m)))�);

 val ps = PSGraph.read_json_file NONE (pspath ^"simple_quantifier_tac.psgraph") |>   PSGraph.set_goaltype_data data; 

 PPIntf.set_psg_goal (SOME g) (SOME ps);

 top_goal_state() |> print_goal_state;

 TextSocket.safe_close();
