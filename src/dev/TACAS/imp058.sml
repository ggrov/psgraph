structure ExistenceProofs : ExistenceProofs = struct
val lthy = get_current_theory_name ();
val _ = open_theory "basic_hol";
val _ = push_merge_pcs ["'propositions","'paired_abstractions"];
fun lget x = fst(hd x);
val _ = new_pc "build_predicates";
val _ = set_rw_eqn_cxt ((lget o get_rw_eqn_cxt) "'propositions" @
		(lget o get_rw_eqn_cxt) "'paired_abstractions")
		"build_predicates";
val _ = set_sc_eqn_cxt ((lget o get_sc_eqn_cxt) "'propositions" @
		(lget o get_sc_eqn_cxt) "'paired_abstractions")
		"build_predicates";
val _ = set_st_eqn_cxt ((lget o get_st_eqn_cxt) "'propositions" @
		(lget o get_st_eqn_cxt) "'paired_abstractions")
		"build_predicates";
val _ = set_rw_canons ((lget o get_rw_canons) "'propositions" @
		(lget o get_rw_canons) "'paired_abstractions")
		"build_predicates";
val pp'ts_def = get_defn "misc" "pp'ts_def";
val �_not_binding_thm = tac_proof(([],�� p:BOOL � (� x:'a� p) = p�),
	rewrite_tac[]);
val �_not_binding_thm = tac_proof(([],�� p:BOOL � (� x:'a� p) = p�),
	rewrite_tac[]);
val uncurry_curry_thm = (
push_goal([],�� f f' � (Uncurry(Curry f) = f) � (Curry(Uncurry f') = f')�);
a(rewrite_tac[ext_thm, pair_clauses]);
pop_thm());
val �_uncurry_thm = (
push_goal([],�� P � (� f � P f) � (� f' � P(Uncurry f'))�);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(�_tac�Curry f� THEN asm_rewrite_tac[uncurry_curry_thm]);
(* *** Goal "2" *** *)
a(�_tac�Uncurry f'� THEN asm_rewrite_tac[]);
pop_thm());
fun list_min ([]:int list) = fail "list_min" 0 []
| list_min (a :: x) = (
let	fun aux (sofar:int) [] = sofar
	| aux sofar (a1 :: x1) = (
		if a1 < sofar
		then aux a1 x1
		else aux sofar x1);
in
	aux a x
end);
fun two_way (f:'a -> bool) (lst : 'a list) : 'a list * 'a list = (
let	fun aux lst1 lst2 [] = (rev lst1,rev lst2)
	| aux lst1 lst2 (a :: x) = (
		if f a
		then aux (a :: lst1) lst2 x
		else aux lst1 (a :: lst2) x
	);
in
	aux [] [] lst
end);
val tva = �'a�;
val tvb = �'b�;
fun match_mk_app(ftm:TERM, xtm:TERM) : TERM = (
let	val (fty1,_) = dest_�_type (type_of ftm);
	val tyinsts = type_match (type_of xtm) fty1 ;
in
	mk_app(inst [] tyinsts ftm, xtm)
end
handle complaint =>
list_divert complaint "match_mk_app" 
	[("dest_�_type",3006,[fn () => string_of_term ftm]),
	 ("type_match",3005,[fn () => string_of_term ftm,
		fn () => string_of_term xtm])]);
val strip_pair :TERM -> TERM list = strip_leaves dest_pair;
val full_strip_� : TERM -> TERM list = strip_leaves dest_�;
val full_strip_� : TERM -> TERM list = strip_leaves dest_�;
fun strip_n_simple_� 0 tm = tm
| strip_n_simple_� n tm = strip_n_simple_� (n - 1)(snd(dest_simple_� tm));
local
	open Sort;
in
fun	var_order (v1:TERM) (v2:TERM) : int = (
let	val (v1n,v1t) = dest_var v1;
	val (v2n,v2t) = dest_var v2;
	val no = string_order v1n v2n
in
	if no <> 0
	then no
	else string_order (string_of_type v1t) (string_of_type v2t)
end);
end;
fun NR_SIMPLE_�_THEN (ttac : THM -> TACTIC) = (fn thm =>
	let	val (x, b) = dest_simple_�(concl thm);
	in	(fn (seqasms, conc) =>
			let	val sideffect = if present (op =$) x
					(flat(map frees
					(conc :: asms thm @ seqasms)))	
				then term_fail "NR_SIMPLE_�_THEN" 0 [x]
				else ();
				val (sgs, pf) = ttac (asm_rule b) (seqasms, conc);
			in	(sgs, (simple_�_elim x thm) o pf)
			end)
	end
	handle ex => divert ex "dest_simple_�" "NR_SIMPLE_�_THEN" 28093 
		[fn () => string_of_thm thm]
);
fun N_SIMPLE_BINDER_C (0:int) (conv : CONV) :CONV = conv
| N_SIMPLE_BINDER_C n conv = SIMPLE_BINDER_C
	(N_SIMPLE_BINDER_C(n-1) conv);
fun LAST_SIMPLE_�_C (conv:CONV): CONV = (fn tm =>
	if is_simple_� (snd(dest_simple_� tm))
	then (SIMPLE_BINDER_C (LAST_SIMPLE_�_C conv)) tm
	else conv tm
);
local
	val ci = �pp'TS:BOOL � BOOL�;
in
fun mark (tm:TERM):TERM = mk_app(ci,tm)
end;
local
	val thm = tac_proof(([],�� t:BOOL � pp'TS t � t�),
		rewrite_tac[get_defn "misc" "pp'ts_def"]);
in
val unmark_conv : CONV = (fn tm => 
let	val (c,t) = dest_app tm
in
	simple_�_elim t thm
end);
val check_unmark_conv : CONV = (fn tm => 
let	val t = dest_mon_op "check_unmark_conv" 0 "pp'TS" tm
in
	simple_�_elim t thm
end)

end;
val local_pure_rewrite_conv : THM list -> CONV = (
	prim_rewrite_conv
	empty_net
	initial_rw_canon
	Nil
	TOP_MAP_C
	[]
);
local
	val tc = simple_eq_match_conv1 �_not_binding_thm;
in
val rec redundant_simple_�_conv: CONV = (fn tm =>
let	val (exs,bdy) = strip_simple_� tm;
	val bdy_frees = frees bdy;
	fun aux [] = false
	| aux (x :: rest) = (
		(present (op =$) x rest) orelse not(present (op =$) x bdy_frees)
		orelse aux rest
	);
	fun aux1 [] tm = fail "redundant_simple_�_conv" 0 []
	| aux1 (x :: rest) tm = (
		if (present (op =$) x rest) orelse not(present (op =$) x bdy_frees)
		then (tc THEN_TRY_C (aux1 rest)) tm
		else SIMPLE_BINDER_C (aux1 rest) tm
	);
in
	if aux exs
	then aux1 exs tm
	else fail "redundant_simple_�_conv" 0 []
end);
end;
local
	val tc = simple_eq_match_conv1 �_not_binding_thm;
in
val rec redundant_simple_�_conv: CONV = (fn tm =>
let	val (exs,bdy) = strip_simple_� tm;
	val bdy_frees = frees bdy;
	fun aux [] = false
	| aux (x :: rest) = (
		(present (op =$) x rest) orelse not(present (op =$) x bdy_frees)
		orelse (aux rest)
	);
	fun aux1 [] tm = fail "redundant_simple_�_conv" 0 []
	| aux1 (x :: rest) tm = (
		if (present (op =$) x rest) orelse not(present (op =$) x bdy_frees)
		then (tc THEN_TRY_C (aux1 rest)) tm
		else SIMPLE_BINDER_C (aux1 rest) tm
	);
in
	if aux exs
	then aux1 exs tm
	else fail "redundant_simple_�_conv" 0 []
end);
end;
local
	val rw_tac = (prim_rewrite_tac
		(make_net( map thm_eqn_cxt ((initial_rw_canon �_rewrite_thm) to 1)))
		id_canon 
		Nil
		TOP_MAP_C
		[]);
in
val simple_�_�_conv: CONV = (fn (tm : TERM) =>
let	val (vs,bdy) = strip_simple_� tm
		handle complaint =>
		divert complaint "strip_simple_�" "simple_�_�_conv" 
			58010 [fn () => string_of_term tm];
	val sideeffect = if is_nil vs orelse (not(is_� bdy))
		then term_fail "simple_�_�_conv" 58010 [tm]
		else ();
	val tm_frees = frees tm;
	val disjs = map mark (full_strip_� bdy);
	val disj_frees = map (fn x => rev(frees x drop 
		(fn xx => present (op =$) xx tm_frees))) disjs;
	val new_term = list_mk_�(map list_mk_simple_� (combine disj_frees disjs));
in
	conv_rule(RAND_C (ONCE_MAP_C check_unmark_conv))
	(tac_proof(([],mk_�(tm,new_term)),
		�_T2
		(fn thm1 => ((REPEAT_TTCL NR_SIMPLE_�_THEN THEN_TTCL
			REPEAT_TTCL �_THEN) asm_tac) thm1 THEN
		 (fn (seqasms,gl) => let val asm = hd seqasms;
			val asm_frees = rev(frees asm drop 
				(fn xx => present (op =$) xx tm_frees));
		in
			(LEMMA_T (list_mk_�(asm_frees,mark asm))
			(fn thm => rw_tac[�_t_intro thm])
			THEN MAP_EVERY_T simple_�_tac asm_frees
			THEN conv_tac unmark_conv
			THEN concl_in_asms_tac)
			(seqasms,gl)
		end))
		(fn thm2 => ((REPEAT_TTCL �_THEN THEN_TTCL
			REPEAT_TTCL NR_SIMPLE_�_THEN THEN_TTCL
			CONV_THEN unmark_conv) asm_tac) thm2 THEN
		MAP_EVERY_T simple_�_tac vs THEN
		POP_ASM_T (fn thm => rw_tac[�_t_intro thm]))
		))
end
handle complaint =>
divert complaint "tac_proof" "simple_�_�_conv" 58015 [fn () => string_of_term tm]);
end;
fun count_mem ([] : TERM list) (fls : (TERM list) list):(int * TERM) list = []
| count_mem (v :: rest) fls = (
let	fun aux [] n = (n,v)
	| aux (fl :: flrest) n = if present (op =$) v fl
		then aux flrest (n+1)
		else aux flrest n;
in
	(aux fls 0 :: count_mem rest fls)
end);
local
	open Sort;
	val sorted_bound_n = sort (fn (m,tm1) => fn(n,tm2) =>
		if m = n
		then var_order tm1 tm2
		else m - n);
	fun recombine_conjs [] conjs = list_mk_� conjs
	| recombine_conjs ((_,v) :: rest) conjs = (
	let	val (withit,without) = two_way (fn x => is_free_in v x) conjs;
	in
		recombine_conjs rest (mk_simple_�(v,list_mk_� withit) :: without)
	end);

in
val simple_�_�_conv = (fn (tm : TERM) =>
let	val (vs,bdy) = strip_simple_� tm
		handle complaint =>
		divert complaint "strip_simple_�" "simple_�_�_conv" 
			58012 [fn () => string_of_term tm];
	val sideeffect = if is_nil vs orelse (not(is_� bdy))
		then term_fail "simple_�_�_conv" 58012 [tm]
		else ();
	val tm_frees = frees tm;
	val conjs = map mark (full_strip_� bdy);
	val conj_frees = map
		(fn x => rev(frees x drop (fn xx => present (op =$) xx tm_frees))) 
		conjs;
	val length_vs = length vs;
	val sideeffect = if any conj_frees (fn x => length x < length_vs)
		then ()
		else term_fail "simple_�_�_conv" 58014 [tm];
	val bound_n = count_mem vs conj_frees;

	val new_term = recombine_conjs (sorted_bound_n  bound_n) conjs;
in
	conv_rule (RAND_C(ONCE_MAP_C check_unmark_conv))
	(tac_proof(([],mk_�(tm,new_term)),
		�_T2
		(fn thm1 => ((REPEAT_TTCL NR_SIMPLE_�_THEN
			THEN_TTCL
			REPEAT_TTCL �_THEN) asm_tac) thm1 
			THEN
		SOLVED_T(REPEAT_T
			(FIRST_T[
			(fn (seqasms,gl) => let val (v,b) = dest_simple_� gl;
				in simple_�_tac v(seqasms,gl)
				end),
			�_tac,
			(conv_tac check_unmark_conv THEN
			 concl_in_asms_tac)])))
		(fn thm2 => ((REPEAT_TTCL(NR_SIMPLE_�_THEN
				ORELSE_TTCL �_THEN) 
			THEN_TTCL (CONV_THEN unmark_conv))asm_tac) thm2
		THEN
		REPEAT_T (fn (seqasms,gl) => let val (v,b) = dest_simple_� gl;
				in simple_�_tac v(seqasms,gl)
				end)
		THEN
		REPEAT_T �_tac
		THEN
		concl_in_asms_tac)))
end
handle complaint =>
divert complaint "tac_proof" "simple_�_�_conv" 58015 
	[fn () => string_of_term tm]);
end; (* local open Sort *)
local
	fun �_�_canon thm = (
		strip_�_rule (all_�_elim thm));
	fun �_�_canon thm = (
		map  (fn x => conv_rule unmark_conv
			(all_�_elim x))
		(strip_�_rule thm));
in
val �_�_conv: CONV = (fn (tm : TERM) =>
let	val (vs,bdy) = strip_� tm;
in
	if is_nil vs
		then term_fail "�_�_conv" 58020 [tm]
		else if (not(is_� bdy))
		then (all_�_uncurry_conv tm handle (Fail _) =>
			term_fail "�_�_conv" 58020 [tm])
		else (
let	val tm_frees = frees tm;
	val conjs = map mark (full_strip_� bdy);
	val conj_frees = map (fn x => rev(frees x drop 
		(fn xx => present (op =$) xx tm_frees))) conjs;
	val new_term = list_mk_�(map list_mk_� (combine conj_frees conjs));
in
	conv_rule(RAND_C (ONCE_MAP_C check_unmark_conv))
	(tac_proof(([],mk_�(tm,new_term)),
		�_T2
		(fn thm1 => 
		let val thm1_can = �_�_canon thm1
		in
		REPEAT �_tac THEN REPEAT �_tac 
		THEN_LIST_T (map (fn thm => conv_tac unmark_conv 
			THEN accept_tac thm) thm1_can)
		end)
		(fn thm2 =>
		let val thm2_can = �_�_canon thm2
		in
		REPEAT �_tac THEN REPEAT �_tac 
		THEN_LIST_T (map accept_tac thm2_can)
		end)
		))
end
handle complaint =>
divert complaint "tac_proof" "�_�_conv" 58015 [fn () => string_of_term tm])
end);
end;
val rec all_simple_�_�_conv1 :CONV = (fn tm =>
	(simple_�_�_conv1 THEN_TRY_C
	(SIMPLE_BINDER_C all_simple_�_�_conv1)) tm
);
local
	val �_thm = tac_proof(([],�� x � x � x�),REPEAT strip_tac);
in
fun local_rule thm gl = (
let 	val (a,b) = dest_� gl;
	val (x,bdy) = dest_eq(concl thm);
	val ithm = simple_�_elim b �_thm;
in
	subst_rule[(eq_sym_rule thm,x)] gl ithm
end);
end;
local
	val �_�_thm = tac_proof(([],�� x � 
		(�(x � T) � (� x)) �
		(�(x � F) � x)�),
		REPEAT strip_tac THEN asm_rewrite_tac[]);
	val rwc = local_pure_rewrite_conv
		[�_rewrite_thm, �_rewrite_thm,
		�_rewrite_thm, eq_rewrite_thm, �_rewrite_thm,
			 �_rewrite_thm];
	val rw_tac1 = (prim_rewrite_tac	
		(make_net(flat(map (cthm_eqn_cxt 
			initial_rw_canon) 
			[�_rewrite_thm])))
		initial_rw_canon 
		Nil
		TOP_MAP_C
		[]);
	val rw_tac2_thm = tac_proof(([],
		�� t� � (F � t) � � (t � F) �
		�(� x � F) � �(� x � F) �
		(� x� x = x � T) � (F � t) �
		(� T � F) � (� F � T)�),
		rewrite_tac[]);
	val rw_rule = prim_rewrite_rule empty_net
		initial_rw_canon
		Nil
		TOP_MAP_C
		[]
		[rw_tac2_thm, �_�_thm];
	val rw_tac2 = (prim_rewrite_tac	
		(make_net(flat(map (cthm_eqn_cxt initial_rw_canon)
			[rw_tac2_thm])))
		initial_rw_canon 
		Nil
		TOP_MAP_C
		[]);
in
val simple_�_equation_conv : CONV = (fn mtm =>	
let	val (x,bdy) = dest_simple_� mtm
		handle complaint =>
		pass_on complaint "dest_simple_�" "simple_�_equation_conv";
	val (xnm,xty) = dest_var x;
	val (following_�, bdy') = strip_simple_� bdy;
	val rhs_ok = frees bdy' drop (fn xx => xx =$ x);
	fun aux_eq_usage binders tm = (
		case (dest_term tm) of
		DEq (tm1,tm2) => (if tm1 =$ x andalso
				(all (frees tm2) (fn xx => present (op =$) xx rhs_ok))
			then Value tm2
			else if tm2 =$ x andalso
				(all (frees tm1) (fn xx => present (op =$) xx rhs_ok))
			then Value tm1
			else Nil)
		| D� (tm1,tm2) => (if tm1 =$ x andalso
				(all (frees tm2) (fn xx => present (op =$) xx rhs_ok))
			then Value tm2
			else if tm2 =$ x andalso
				(all (frees tm1) (fn xx => present (op =$) xx rhs_ok))
			then Value tm1
			else Nil)
		| D�(vs,bdy) => (let val vss = strip_pair vs
			in
			if present (op =$) x vss
			then Nil
			else aux_eq_usage (vss @ binders) bdy
			end)
		| D�(vs,bdy) => (let val vss = strip_pair vs
			in
			if present (op =$) x vss
			then Nil
			else aux_eq_usage (vss @ binders) bdy
			end)
		| D�(tm1,tm2) => (case (aux_eq_usage binders tm1) of
			Nil => aux_eq_usage binders tm2
			| vx => vx)
		| DVar (anm,aty) => (if anm = xnm andalso aty =: xty
			then Value mk_t
			else Nil)
		| D� arg =>  (if arg =$ x
			then Value mk_f
			else Nil)
		| _ => Nil
		);
	val witness = case (aux_eq_usage [] bdy') of
		Value wit => wit
		| Nil => term_fail "simple_�_equation_conv" 58013 [mtm];
	val frees_witness = frees witness;
	val (move_out,keep_in) = two_way (fn y => present (op =$) y frees_witness) following_�;
in
	(
	(fn cnv =>
	if not (is_nil move_out)
	then ((�_reorder_conv (list_mk_simple_�((move_out @ [x] @ keep_in), bdy')) 
		THEN_C (N_SIMPLE_BINDER_C(length move_out) cnv )))
	else cnv)
(fn mtm' =>
let	val work_on_bdy = list_mk_simple_�(keep_in, bdy');
	val work_on_tm = mk_simple_� (x, work_on_bdy);
	val side_effect = if mtm' =$ work_on_tm
		then ()
		else term_fail "oops-simple_�_equation_conv" 0 [mtm];
	val new_term = var_subst [(witness,x)] work_on_bdy;
	val new_term_rw = (TRY_C rwc) new_term;
	val new_term' = snd(dest_eq(concl new_term_rw));
	val thm = tac_proof(([],mk_�(work_on_tm,new_term')),
		�_T2 (fn thm =>
		t_tac ORELSE
		conv_tac(fn ag => eq_sym_rule new_term_rw)
		THEN
		SIMPLE_�_THEN ante_tac thm
		THEN (
			let val x' = variant (frees(concl thm) @ frees new_term) x;
			in
			CASES_T2 (mk_eq(x',witness))
			(fn thm1 => fn (seqasms,gl) =>
			accept_tac (local_rule thm1 gl)(seqasms,gl))
			(fn thm1 => rw_tac2[
				thm1,
				((rw_rule thm1) handle (Fail _) => t_thm),
				�_eq_sym_rule thm1])
			end)			
		)
		(fn thm =>
		simple_�_tac witness THEN accept_tac 
			(�_mp_rule (eq_sym_rule new_term_rw) thm)
		))
		handle complaint =>
		if area_of complaint = "tac_proof"
		then term_fail "simple_�_equation_conv" 58022 [mtm,witness]
		else reraise complaint (area_of complaint);
in
	eq_trans_rule (refl_conv mtm') thm
end) 
)
mtm
end
handle complaint =>
divert complaint "tac_proof" "simple_�_equation_conv" 58013 
	[fn () => string_of_term mtm]);
end;
local
	val rw_tac = (prim_rewrite_tac	
	(make_net(flat(map (cthm_eqn_cxt initial_rw_canon)
		[eq_rewrite_thm, �_rewrite_thm, �_rewrite_thm, �_rewrite_thm])))
		initial_rw_canon 
		Nil
		TOP_MAP_C
		[(�(� x � y)z�,simple_�_conv)]
		[]);

	fun is_redundant_args frees_bdy tm1 tm2 x = (
	let	val (x',args) = strip_app tm1;
	in
		x' =$ x andalso
		(let	val ftm2 = frees tm2
		in
		not(any (frees tm1) (fn x => present (op =$) x ftm2))
		andalso
		all ftm2 (fn xx => present (op =$) xx frees_bdy)
		end)
	end);

	fun do_redundant_args tm1 tm2 x = (
	let	val (x',args) = strip_app tm1;
	in
		list_mk_simple_�(gen_vars(map type_of args) [tm2], tm2)
	end);
in
val simple_�_equation_conv1: CONV = (fn mtm =>
let	val (x,bdy) = dest_simple_� mtm;
	val (following_�, bdy') = strip_simple_� bdy;
	val frees_bdy = frees bdy';
	fun  aux tm = (case (dest_term tm) of
		DEq (tm1,tm2) => (
			if is_redundant_args frees_bdy tm1 tm2 x
			then do_redundant_args tm1 tm2 x
			else if is_redundant_args frees_bdy tm2 tm1 x
			then do_redundant_args tm2 tm1 x
			else term_fail "simple_�_equation_conv1" 0 [mtm]
		) | D� (tm1,tm2) => (
			if is_redundant_args frees_bdy tm1 tm2 x
			then do_redundant_args tm1 tm2 x
			else if is_redundant_args frees_bdy tm2 tm1 x
			then do_redundant_args tm2 tm1 x
			else term_fail "simple_�_equation_conv1" 0 [mtm]
		) | D�(vs,bdy) => (let val vss = strip_pair vs
			in
			if present (op =$) x vss
			then term_fail "simple_�_equation_conv1" 0 [mtm]
			else aux bdy
			end
		) | D�(vs,bdy) => (let val vss = strip_pair vs
			in
			if present (op =$) x vss
			then term_fail "simple_�_equation_conv1" 0 [mtm]
			else aux bdy
			end
		) | D� arg => (
			if is_redundant_args frees_bdy arg mk_f x
			then do_redundant_args arg mk_f x
			else term_fail "simple_�_equation_conv1" 0 [mtm]
		) | DApp _ => (
			if is_redundant_args frees_bdy tm mk_t x
			then do_redundant_args tm mk_t x
			else term_fail "simple_�_equation_conv1" 0 [mtm]
		) | DVar _ => (
			if is_redundant_args frees_bdy tm mk_t x
			then do_redundant_args tm mk_t x
			else term_fail "simple_�_equation_conv1" 0 [mtm]
		) | _ => term_fail "simple_�_equation_conv1" 0 [mtm]);
	val witness = aux bdy';
in
	((�_reorder_conv (list_mk_simple_�(following_� @ [x], bdy')))
	THEN_C
	(LAST_SIMPLE_�_C (fn mtm' =>
		tac_proof(([],mk_�(mtm',mk_t)),
		�_t_tac THEN
		simple_�_tac witness THEN
		(rw_tac ORELSE_T t_tac))))
	THEN_TRY_C
	(local_pure_rewrite_conv [�_rewrite_thm]))
	mtm
end);
end;
val pair_rewrite_thm = tac_proof(([],�� x y p �
	Fst (x, y) = x � Snd (x, y) = y �
	(Fst p, Snd p) = p�),
	rewrite_tac[pair_clauses]);


fun dc_simps (foc : string list) = (
	flat(map (fn (_,(_,thm)) => 
	initial_rw_canon thm) 
	(filter (fn (nm,_) => nm mem foc)
	(current_ad_�_vs_thms())))
);
fun can_handle tm = (
	is_var tm orelse
	(let val (dc,args) = strip_app tm
	in
	is_const dc andalso
	(let val nmdc = fst(dest_const dc)
	in
	any (current_ad_�_vs_thms()) (fn (nm,_) => nm = nmdc)
	end) andalso
	all args can_handle
	end)
);
fun n_true [] = 0
| n_true (true :: x) = 1 + n_true x
| n_true _ = 0;
fun an_f f mcxt mtm = (
let 	val (fnm,fty) = dest_var f
	fun aux cxt tm  = (
	case (dest_simple_term tm) of
	Var (anm,aty) => (if anm = fnm andalso aty =: fty
		then Value cxt
		else Nil
	) | Const _ => Nil
	| App (tm1,tm2) => (
		let val cxts1 = aux cxt tm1
		in
			case cxts1 of
			Value _ => cxts1
			| Nil => aux tm2 tm2
		end)
	| Simple�(y,tm1) => (if y =$ f
		then Nil
		else aux tm1 tm1)
	)
in
	aux mcxt mtm
end);

local
	fun is_fst_arg_dc tm = (
	let	val (_,args) = strip_app tm;
		val fst_arg = hd args;
	in
		is_app fst_arg orelse is_const fst_arg
	end);
in
fun an_f_dc f mcxt mtm = (
let 	val (fnm,fty) = dest_var f
	fun aux cxt tm  = (
	case (dest_simple_term tm) of
	Var (anm,aty) => (if anm = fnm andalso aty =: fty
			andalso is_fst_arg_dc cxt
		then Value cxt
		else Nil
	) | Const _ => Nil
	| App (tm1,tm2) => (
		let val cxts1 = aux cxt tm1
		in
			case cxts1 of
			Value _ => cxts1
			| Nil => aux tm2 tm2
		end)
	| Simple�(y,tm1) => (if y =$ f
		then Nil
		else aux tm1 tm1)
	)
in
	aux mcxt mtm
end);
end;
fun match_f_args (tml1:TERM list) (tml2:TERM list):(TERM * TERM) list = (
let	val cavs = current_ad_�_vs_thms();
	fun aux ([]:TERM list) ([]:TERM list):(TERM * TERM) list = []
	| aux (new :: nrest) (old :: orest) = (
	if is_var old
	then (new, old) :: aux nrest orest
	else (let val (dc,bits) = strip_app old;
		val (projs,thm) = lassoc3 cavs 
			(fst(dest_const dc));
	in
		aux ((map (fn x => match_mk_app(x,new)) projs) 
			@ nrest)
			(bits @ orest)
	end)
	)| aux _ _ = fail "match_f_args" 0 [];
in
	aux tml1 tml2
end);
local
	val gen_f = �'a � 'b � 'c�;
	val rwc = local_pure_rewrite_conv [
		tac_proof(([],�� x y f a � 
			(Uncurry f (x,y) = f x y) �
			(Uncurry f a = f (Fst a) (Snd a))�),
		rewrite_tac[pair_clauses])];
in
fun simple_�_paired_arg_conv (usages: TERM list):CONV = (fn mtm =>
let	val sideeffect = if any usages (fn tm => is_pair(snd(dest_app tm)))
		then ()
		else term_fail"simple_�_paired_arg_conv" 0 [];
	val (f,bdy) = dest_simple_� mtm;
	val P = mk_simple_�(f, bdy);
	val s1 = inst_type_rule(type_match (type_of f) gen_f) �_uncurry_thm;
	val s2 = simple_�_elim P s1;
	val f' = variant (frees bdy) f;
	val s3 = conv_rule(RAND_C(RAND_C (simple_�_conv 
			(fst(dest_var f')))) THEN_C
		ONCE_MAP_C simple_�_conv THEN_C
		rwc) s2;
in
	eq_trans_rule (refl_conv mtm) s3
end);
end;
local
fun lrassoc1 ((x, y) :: rest : (TERM * TERM) list) (what : TERM) : TERM = (
	if y =$ what
	then x
	else lrassoc1 rest what
) | lrassoc1 [] what = what;

in
fun opt_list_simple_�_elim (alist:(TERM * TERM) list) (thm:THM): THM = (
let 	val (vs,_) = strip_simple_� (concl thm);
	val vs' = map (lrassoc1 alist) vs;
in
	list_simple_�_elim vs' thm
end);
end;
fun local_rearrange_conv (f:TERM) (new_term:TERM) : CONV = (fn tm =>
	if tm ~=$ new_term
	then �_conv new_term tm
	else tac_proof(([],mk_�(tm,new_term)),
		let 	val cnsts = ((map fst (term_consts tm)) cup (map fst (term_consts new_term)));
			val ldc_simps = dc_simps cnsts;
			val prwc = local_pure_rewrite_conv ldc_simps;
			val prwr = conv_rule prwc;
			val prwt = conv_tac prwc;
		in
		�_T2
		(fn thm1 =>
		let val thm1s = strip_�_rule thm1
		in
		REPEAT simple_�_tac THEN 
		COND_T(fn _ => length thm1s > 1)
			(REPEAT �_tac THEN REPEAT simple_�_tac )
			(id_tac)
		THEN_LIST_T
		(map (fn thm => fn (seqasms,gl) =>
		let 	val conc = concl thm;
			val thm_fuse = case(an_f f conc conc) of
				Value tm => tm
				| Nil => mk_t;
			val gl_fuse = case(an_f f gl gl) of
				Value tm => tm
				| Nil => mk_t;
			val (_,match1) = term_match thm_fuse gl_fuse;
			val (omatch1,nmatch1) = split match1;
			val match2 = match_f_args nmatch1 omatch1;
			val thm' = opt_list_simple_�_elim match2 thm;
			val thm'' = (prwr thm'
				handle (Fail _) => thm');
		in
			(TRY_T prwt THEN
			accept_tac thm'') (seqasms,gl)
		end) 
		thm1s)
		end)
		(fn thm2 =>
		let val (ivs,bdy) = strip_simple_�(concl thm2);
			val thm2s = if is_� tm
				then (map (list_simple_�_intro ivs) 
					(strip_�_rule (all_simple_�_elim thm2)))
				else [thm2];
		in
			REPEAT �_tac THEN
			REPEAT simple_�_tac THEN_LIST_T
		(map (fn thm => fn (seqasms,gl) =>
		let 	val conc = concl thm;
			val thm_fuse = case(an_f f conc conc) of
				Value tm => tm
				| Nil => mk_t;
			val gl_fuse = case(an_f f gl gl) of
				Value tm => tm
				| Nil => mk_t;
			val (_,match1) = term_match gl_fuse thm_fuse;
			val thm' = opt_list_simple_�_elim match1 thm;
			val thm'' = (prwr thm'
				handle (Fail _) => thm');
		in
			(TRY_T  prwt
			THEN accept_tac thm'') (seqasms, gl)
		end) 
		thm2s)	
		end)
		end)
);
fun simple_�_varstruct_arg_conv (usages: TERM list): CONV = (
	fn (mtm: TERM) =>
let	val (f,bdy) = dest_simple_� mtm;
	val dest_f = dest_var f;
	val (following_�, bdy') = strip_simple_� bdy;
	val stripped_usages = map (snd o strip_app) usages;
	val ch = map (map can_handle) stripped_usages;
	val tryupto = list_min(map n_true ch);
in
	if tryupto < 1 
	then simple_�_paired_arg_conv usages mtm
	else
(let	val base_xs = (hd stripped_usages) to (tryupto -1);
	val base_xs' = map (fn y => if is_var y
			then y
			else mk_var("x",type_of y)) base_xs;
	val xs = list_variant (map mk_var(term_vars mtm)) base_xs';
	val conjs = full_strip_� bdy';

	fun process_conj conj = (
	let	val (vs, cbody) = strip_simple_� conj;
	in
		case (an_f f conj conj) of
		Nil => conj
		| Value fuse => (let val (f,args) = strip_app fuse;
			val args' = args to (tryupto -1);
			val substs = match_f_args xs args';
			val ncbody = subst (combine xs args'@ substs) cbody;
			val fl_fs = (flat(map frees args'));
			val vs' = vs drop (fn xx => present (op =$) xx fl_fs);
		in
			list_mk_simple_�(vs',ncbody)
		end)
	end);

	val new_conjs = map process_conj conjs;
	val new_body = list_mk_� new_conjs;
	val new_term = list_mk_simple_�(xs,new_body);
	val s1 = �_reorder_conv (list_mk_simple_�(following_� @ [f], bdy'))
		mtm;
	val s2 = conv_rule(RAND_C(ALL_SIMPLE_�_C 
		(local_rearrange_conv f new_term))) s1;
	val s3 = conv_rule(RAND_C(LAST_SIMPLE_�_C 
		(all_simple_�_�_conv1 THEN_TRY_C redundant_simple_�_conv))) s2;
in
	s3
end)
end);
fun add_to_last vl [a] = [(vl :: a)]
| add_to_last vl (a :: x) = a :: add_to_last vl x
| add_to_last vl [] = fail "add_to_last" 0 [];
fun add_to_named (dc_recog :: dc_recogs) (conjs :: conjsl) fst_arg conj = (
	if ((term_match fst_arg dc_recog;true) 
		handle Fail _ => false)
	then ((conj :: conjs) :: conjsl)
	else (conjs :: add_to_named dc_recogs conjsl fst_arg conj)
)
| add_to_named _ _ _ conj = term_fail "add_to_named" 0 [conj];
local
	val aux_thm = tac_proof(([],�� p q � (p � (q � pp'TS p)) � (q � p)�),
		rewrite_tac[pp'ts_def] THEN
		REPEAT strip_tac);
	val stored_build_predicates_pc = pending_push_pc "build_predicates";
in
fun evaluate_�_cd_thm (thm : THM) = (
let	val (new_fns,ue) = strip_� (concl thm);
	val all_nf = flat(map strip_pair new_fns);
	val (f,bdy) = dest_simple_� ue handle _ => dest_simple_��1 ue;
	val conjs = full_strip_� bdy;
	fun aux conj = (
	let	val (vs,bdy) = strip_� conj;
		val (lhs,rhs) = dest_eq bdy;
		val (f',recog) = dest_app lhs;
		val sideeffect = if f =$ f'
			then ()
			else thm_fail "evaluate_�_cd_thm" 58009 [thm];
		val (nf,args) = strip_app rhs;
		val sideeffect = if present (op =$) nf all_nf
			then ()
			else thm_fail "evaluate_�_cd_thm" 58023 [thm];
	in
		(recog, (lhs :: args), nf)
	end);
	val proc_conjs = map aux conjs;
	val preds = gen_vars (BOOL :: (map (fn (_,xs,_) => 
		list_mk_�_type(map type_of xs @ [BOOL]))
		proc_conjs))
 		[concl thm];
	val other_pred = hd preds;
	val preds' = tl preds;
	val preds_conjs = combine preds' proc_conjs;
	val tm1 = list_mk_�(map (fn (pred,(recog,args,_)) => 
		list_mk_simple_�(rev(frees recog),
			list_mk_app(pred,args)))
		preds_conjs
		@ [other_pred]);
	val tm2 = mk_simple_�(f, tm1);
	fun aux1 (pred,(recog,args,_)) = (
	let	val gvs = gen_vars (map type_of args) (pred :: args);
	in
		list_mk_simple_�(tl gvs,
			mk_simple_�(hd gvs,
			list_mk_app(pred, gvs)))
	end);
	val tm3 = list_mk_�((map aux1 preds_conjs) @ [other_pred]);
	val tm4 = mk_�(tm3, mark tm2);
	val tm5 = list_mk_simple_�(preds' @ [other_pred],
		mk_eq(tm2,tm4));
	fun mk_spec (pred,(recog,args,_)) = (
	let	val gvs_args = gen_vars(map type_of args)[pred];
	in
		list_mk_simple_�(tl gvs_args,
		mk_�(hd gvs_args,
		list_mk_app(pred,gvs_args)))
	end);
	val thm_specs = map (fn bdr =>
		mk_spec(find preds_conjs (fn (_,(_,_,abdr)) => bdr =$ abdr)))
		new_fns
		handle Fail _ => thm_fail "evaluate_�_cd_thm" 58024 [thm];
	val dummy = stored_build_predicates_pc();
	val cd_thm = tac_proof((asms thm,tm5),
		pure_rewrite_tac[aux_thm] THEN
		REPEAT �_tac THEN
		�_T(fn athm => MAP_EVERY_T asm_tac (strip_�_rule athm)) THEN
		strip_asm_tac (list_simple_�_elim thm_specs thm) THEN
		simple_�_tac f THEN asm_rewrite_tac[] THEN
		REPEAT (�_tac ORELSE_T simple_�_tac) THEN
		(fn (seqasms,gl) =>
		(let val (pred,args) = strip_app gl;
		in
		DROP_ASM_T (find seqasms (fn asm =>
			let val (_,bdy) = strip_� asm;
				val (_,bdy') = dest_simple_� bdy;
				val (pred',_) = strip_app bdy'
			in
				pred =$ pred'
			end
			handle Fail _ => false))
			(rewrite_thm_tac o �_�_rule o
			list_simple_�_elim(tl args))
		end) (seqasms,gl)))
		handle complaint =>
		(pop_pc();
		raise complaint); 
	val dummy = pop_pc();
	val recogs = map (fn (x,_,_) => x) proc_conjs;
	val nfrees_recogs = map (length o frees) recogs;
	val gen_f = type_of f;
	val dummies = map (rev o frees) recogs;
in
	(recogs, nfrees_recogs, gen_f, dummies, cd_thm)
end
handle complaint =>
list_divert complaint "evaluate_�_cd_thm" 
	[("dest_simple_��1",58007,[fn () => string_of_thm thm]),
	("dest_app",58008,[fn () => string_of_thm thm]),
	("dest_eq",58008,[fn () => string_of_thm thm]),
	("tac_proof",58021,[fn () => string_of_thm thm])
	]
);
end;
val _ = pp'set_eval_ad_�_cd_thms (map evaluate_�_cd_thm);
fun find_recursion_candidate (usages : TERM list) = (
let	val good_use = find usages 
		(fn tm => 
		((let val fst_arg = hd(snd(strip_app tm));
		in
		is_app fst_arg orelse is_const fst_arg
		end)
		handle Fail _ => false));
	val rarg = hd(snd(strip_app good_use));
	val poss_cand = find (current_ad_�_cd_thms()) 
		(fn (recogs,_,_,_,_) =>
		any recogs (fn recog => 
			((term_match rarg recog; true) handle Fail _ => false)));
in
	poss_cand
end
handle complaint =>
list_divert complaint "find_recursion_candidate" 
	[("hd",0,[]),
	 ("find",0,[])]
);
fun simple_�_cd_thm_conv (rthm : THM) : CONV = (fn tm =>
let	val (f,bdy) = dest_simple_� tm;
	val fname = fst(dest_var f);
	val conjs = strip_� bdy;
	val (lhs,rhs) = dest_eq(snd(strip_simple_�(concl rthm)));
	val (ft,bdyt) = dest_simple_� lhs;
	val ftname = fst(dest_var ft);
	val new_rthm = inst_type_rule (fst(term_match f ft)) rthm;
	val new_rthm' = conv_rule (ONCE_MAP_C 
		(COND_C (fn tm => is_simple_� tm andalso
			fst(dest_var(fst(dest_simple_� tm))) = ftname)
		(simple_�_conv fname)
		(fail_conv))) new_rthm;
	val (lhs',rhs') = dest_eq(snd(strip_simple_�(concl new_rthm')));
	val (ft',bdyt') = dest_simple_� lhs';
	val conjst = strip_� bdyt';
	val sideeffect = if f =$ ft'
		then ()
		else term_fail "simple_�_cd_thm_conv" 0 [tm];
	val avoid = map mk_var (term_vars tm);
	fun get_pred (conj, conjt) = (
	let	val (vs,cbdy) = strip_simple_� conj;
		val (vst,cbdyt) = strip_simple_� conjt;
		val renames = combine (vs to (length vst -1)) vst;
		val conj' = strip_n_simple_� (length vst) conj;
		val args = snd(strip_app cbdyt);
		val rnargs = map (var_subst renames) args;
		val gvs = gen_vars (map type_of args) avoid;
	in
		list_mk_simple_� (gvs,subst (combine gvs rnargs) conj')
	end);
	val preds = map get_pred (combine conjs conjst);
	val snd_thm = conv_rule(TRY_C all_simple_�_conv)
		 (list_simple_�_elim preds new_rthm');
	val fst_thm = TRY_C all_simple_�_conv tm;
in
	eq_trans_rule fst_thm snd_thm
end);

local 
	val lrrc_canon = REWRITE_CAN
		(REPEAT_CAN
		(simple_�_rewrite_canon ORELSE_CAN �_rewrite_canon)
		THEN_CAN (fn thm => [�_t_intro thm]));
	val rw_tac = (prim_rewrite_tac (make_net 
		(map thm_eqn_cxt (initial_rw_canon �_rewrite_thm)))
		lrrc_canon
		Nil
		Combinators.I
		[]);
in
fun local_recursion_rearrange_conv (new_tm : TERM) : CONV = (fn tm =>
	tac_proof(([],mk_�(tm,new_tm)),
	�_T(fn thm =>
	let val rw_tac' = rw_tac [thm]
	in
	(REPEAT (�_tac ORELSE_T �_tac)
	THEN (TRY_T rw_tac') THEN t_tac)
	end))
);
end;
fun simple_�_rec_arg_conv (usages: TERM list) = (fn (mtm: TERM) =>
let	val (f,bdy) = dest_simple_� mtm;
	val dest_f = dest_var f;
	val (following_�, bdy') = strip_simple_� bdy;
	val (dc_recogs,nvars_list,generic_f,dummy_vars_list,cand_thm) = 
		(find_recursion_candidate usages);
	val conjs = full_strip_� bdy';
	val init_conj_lists = [] :: map (fn x => []) dc_recogs;

	fun process_conjs conj_lists [] = conj_lists
	| process_conjs conj_lists (conj :: rest) = (
	process_conjs (
	let	val (vs, cbody) = strip_simple_� conj;
	in
		case (an_f_dc f conj conj) of
		Nil => add_to_last conj conj_lists
		| Value fuse => (
		let 	val (f,args) = strip_app fuse;
			val fst_arg = hd args;
			val fst_arg_frees = rev(frees fst_arg);
			val new_conj = list_mk_simple_�(fst_arg_frees @ 
				(vs drop (fn xx => present (op =$) xx fst_arg_frees)), cbody);
		in
			add_to_named dc_recogs 
				conj_lists 
				fst_arg
				new_conj
		end)
	end)
	rest);
	val new_conjs = process_conjs init_conj_lists conjs;
	val specific_types = type_match (type_of f) generic_f;

	fun group_conjs (nvars :: nvarsl) (dummy_vars:: dummy_varsl) (conjs :: conjsl) = (
		(
		if is_nil conjs
		then list_mk_simple_� ((map (inst [] specific_types) dummy_vars),mk_t)
		else (let val (vs1,_) = strip_simple_� (hd conjs);
			val initial_vs = vs1 to (nvars -1);
			fun rename_conj conj = (
			let val (vs,bdy) = strip_simple_� conj;
				val init_vs = vs to (nvars -1);
			in
				var_subst(combine initial_vs init_vs) 
					(list_mk_simple_�(vs from nvars,bdy))
			end);
			val nconjs = map rename_conj conjs;
		in
			list_mk_simple_�(initial_vs,list_mk_� nconjs)
		end)) :: 
		group_conjs nvarsl dummy_varsl conjsl
	)
	| group_conjs _ _ [no_fs] = (
		if is_nil no_fs
		then [mk_t]
		else [list_mk_� no_fs]
	) | group_conjs _ _ _ = fail "group_conjs" 0 [];
	val new_conjs1 = group_conjs nvars_list dummy_vars_list new_conjs;	
	val new_body = list_mk_� new_conjs1;
	val new_term = mk_simple_�(f,new_body);
	val s1 = �_reorder_conv (list_mk_simple_�(following_� @ [f], bdy'))
		mtm;
	val s2 = conv_rule(RAND_C(ALL_SIMPLE_�_C
		(local_recursion_rearrange_conv new_body))) s1;
	val s3 = conv_rule(RAND_C(LAST_SIMPLE_�_C 
		(simple_�_cd_thm_conv cand_thm))) s2;
in
	s3
end);
val simple_�_arg_conv : CONV = (fn mtm =>	
let	val (x,bdy) = dest_simple_� mtm;
	val (xnm,xty) = dest_var x;
	fun aux_usage cxt tm = (
		case (dest_simple_term tm) of
		Var (anm,aty) => (if xnm = anm andalso xty =: aty
			then [cxt]
			else []
		) | Const arg => []
		| App (tm1,tm2) => (
			let val cxts1 = aux_usage cxt tm1
			in
				cxts1 @ aux_usage tm2 tm2
			end)
		| Simple�(y,tm1) => (if y =$ x
			then []
			else aux_usage tm1 tm1)
	);
	val usages = aux_usage mtm bdy;
in
	((COND_C (fn _ => present (op =$) x usages) (fail_conv) 
		(simple_�_varstruct_arg_conv usages)) 
	AND_OR_C
	(simple_�_rec_arg_conv usages)
	AND_OR_C
	(fn _ => term_fail "simple_�_arg_conv" 0 [mtm]))
	mtm
end
handle complaint =>
divert complaint "dest_simple_� mtm" "simple_�_arg_conv" 0 
	[fn () => string_of_term mtm]);
val (basic_prove_�_conv : CONV) = (fn (tm : TERM) =>
let	fun aux tm = (
let	fun move_in_conv ltm = (case (dest_term ltm) of
		D� _ => aux ltm
		| D� (vs,_) => (
			(COND_C (fn _ => is_pair vs) 
			 all_�_uncurry_conv fail_conv)
			AND_OR_C
			(�_�_conv THEN_TRY_C move_in_conv)
			ORELSE_C
			(ALL_SIMPLE_�_C move_in_conv 
			THEN_TRY_C redundant_simple_�_conv)) ltm
		| D� _ => ALL_�_C move_in_conv ltm
		| D� _ => ALL_�_C move_in_conv ltm
		| _ => fail_with_conv "aux-pass through" ltm);
in
(
	(if is_� tm
	then
	(all_�_uncurry_conv
	AND_OR_C
	(redundant_simple_�_conv
	AND_OR_C
	(simple_�_�_conv THEN_TRY_C move_in_conv)
	ORELSE_C
	((REPEAT_C1 simple_�_equation_conv)
	AND_OR_C
	(simple_�_equation_conv1
	ORELSE_C
	(ALL_SIMPLE_�_C �_�_conv
	AND_OR_C
	((simple_�_arg_conv THEN_TRY_C move_in_conv)
	ORELSE_C
	((simple_�_�_conv THEN_TRY_C move_in_conv)
	ORELSE_C
	((SIMPLE_BINDER_C move_in_conv THEN_TRY_C aux)
	ORELSE_C (fn _ => term_fail "basic_prove_�_conv" 58002 [tm]))))))))) 
		(* we know its an � *)
	else term_fail "basic_prove_�_conv" 58001 [tm])
	tm
)
end);
in
	(aux THEN_TRY_C local_pure_rewrite_conv[pp'ts_def]) tm
end);

fun basic_prove_�_rule (tm : TERM) : THM = (
let	val s1 = basic_prove_�_conv tm
		handle complaint =>
		pass_on complaint "basic_prove_�_conv" "basic_prove_�_rule";
in
	if snd(dest_�(concl s1)) =$ mk_t
	then �_t_elim s1
	else term_fail "basic_prove_�_rule" 58003 [tm]
end);
val basic_prove_�_tac :TACTIC = (fn (seqasms, gl) =>
let	val s1 = basic_prove_�_conv gl
		handle complaint as (Fail _) =>
		if is_� gl
		then fail "basic_prove_�_tac" 58005 []
		else fail "basic_prove_�_tac" 58004 [];
in
	if snd(dest_�(concl s1)) =$ mk_t
	then accept_tac (�_t_elim s1) (seqasms,gl)
	else fail "basic_prove_�_tac" 58006 []
end);
val _ = delete_pc "build_predicates";
val _ = pop_pc();
val _ = open_theory lthy;
end; (* of structure ExistenceProofs *)
open ExistenceProofs;
