open_theory "fef032";
(force_delete_theory "fef033" handle _ => ());
new_theory"fef033";
new_parent"fef031";
set_pc"hol";
push_consistency_goal�TableComputations�;
a(prove_�_tac);
a(strip_tac THEN rewrite_tac[tac_proof(([], ��x��z y� (y, z) = x�),
		strip_tac THEN �_tac�Snd x� THEN �_tac�Fst x� THEN rewrite_tac[])]);
save_consistency_thm�TableComputations� (pop_thm());
set_pc"hol";
set_goal([], ��i1 i2� BoolItem i1 = BoolItem i2 � i1 = i2�);
a(rewrite_tac(map get_spec[�BoolItem�, �ValuedItemItem�])
	THEN REPEAT �_tac THEN �_tac THEN_TRY asm_rewrite_tac[]);
a(LEMMA_T �VI_val(MkValuedItem sterling (BoolVal i1))
             = VI_val(MkValuedItem sterling (BoolVal i2))�
	(accept_tac o rewrite_rule(map get_spec[�MkValuedItem�, �BoolVal�]))
	THEN1 asm_rewrite_tac[]);
val BoolItem_OneOne_lemma = save_pop_thm"BoolItem_OneOne_lemma";
set_goal([], ��c r1 r2�
	HideDerTableRow c r1 = HideDerTableRow c r2 �
	Length (DTR_cols r1) = Length (DTR_cols r2)�);
a(rewrite_tac(MkDerTableRow_lemma :: map get_spec[�HideDerTableRow�, �Let�]));
a(REPEAT strip_tac);
a(LEMMA_T�Length(Map(� (c', i) � if c dominates c'
                   then (c', i)
                   else (c', ValuedItemItem (MkValuedItem sterling dummyVal)))
               (DTR_cols r1))
             = Length(Map (� (c', i) � if c dominates c'
                   then (c', i)
                   else (c', ValuedItemItem (MkValuedItem sterling dummyVal)))
               (DTR_cols r2))�
	(strip_asm_tac o once_rewrite_rule[length_map_thm])
	THEN1 asm_rewrite_tac[]);
val HideDerTableRow_Length_lemma = save_pop_thm"HideDerTableRow_Length_lemma";
set_goal([], ��c r i�
	1 � i � i � Length (DTR_cols r) �
	Nth (DTR_cols (HideDerTableRow c r)) i =
	(Fst (Nth (DTR_cols r) i),
	if	c dominates (Fst (Nth (DTR_cols r) i))
	then	Snd(Nth (DTR_cols r) i)
	else	ValuedItemItem (MkValuedItem sterling dummyVal))�);
a(REPEAT �_tac);
a(rewrite_tac(map get_spec[�Let�, �DTR_cols�, �HideDerTableRow�]));
a(LEMMA_T ��cols� DTR_cols r = cols�
	(REPEAT_TTCL STRIP_THM_THEN rewrite_thm_tac)
	THEN1 prove_�_tac);
a(intro_�_tac(�i�, �i�) THEN list_induction_tac�cols�);
(* *** Goal "1" *** *)
a(rewrite_tac(map get_spec[�Length�]));
a(REPEAT strip_tac THEN all_var_elim_asm_tac);
(* *** Goal "2" *** *)
a(rewrite_tac(map get_spec[�Length�, �Nth�]));
a(REPEAT �_tac);
a(cases_tac �i = 1� THEN asm_rewrite_tac(map get_spec[�Map�, �Nth�])
	THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(CASES_T �c dominates Fst x� rewrite_thm_tac);
(* *** Goal "2.2" *** *)
a(GET_ASM_T �1 � i� (strip_asm_tac o rewrite_rule[get_spec�$��]));
a(LEMMA_T�i = i' + 1� rewrite_thm_tac THEN1
	(POP_ASM_T (rewrite_thm_tac o eq_sym_rule)));
a(lemma_tac�1 � i' � i' � Length cols� THEN1 PC_T1 "lin_arith" asm_prove_tac[]);
a(all_asm_fc_tac[]);
val Nth_HideDerTableRow_lemma = save_pop_thm"Nth_HideDerTableRow_lemma";
push_goal([], ��c� DTR_row o HideDerTableRow c = DTR_row�);
a(PC_T1"hol2" REPEAT strip_tac);
a(rewrite_tac(
	map get_spec[�$o:(('a�'c)�(('b�'a)�('b�'c)))�,
	�HideDerTableRow�, �DTR_row�, �Let�]));
val DTR_row_o_HideDerTableRow_lemma = 
	save_pop_thm"DTR_row_o_HideDerTableRow_lemma";
set_goal([], ��f a b c� f(if a then b else c) = (if a then f b else f c)�);
a(REPEAT strip_tac THEN cases_tac�a:BOOL� THEN asm_rewrite_tac[]);
val fun_if_thm = save_pop_thm"fun_if_thm";
push_goal([], ��c rl�
	rl � {r|c dominates DTR_row r � c dominates DTR_where r} = []
	�
	(Map (HideDerTableRow c) (rl � {r|c dominates DTR_row r}))
		� {r|c dominates DTR_where r} = []�);
a(REPEAT �_tac);
a(list_induction_tac �rl� THEN asm_rewrite_tac(
	map get_spec[�Let�, �Map�, �DTR_row�, �HideDerTableRow�, �$��]));
(* *** Goal "1" *** *)
a(strip_tac THEN cases_tac �c dominates DTR_row x� THEN asm_rewrite_tac(
	map get_spec[�Let�, �Map�, �DTR_row�, �HideDerTableRow�, �$��]));
a(cases_tac�c dominates DTR_where x� THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(strip_tac THEN cases_tac �c dominates DTR_row x� THEN asm_rewrite_tac(
	map get_spec[�Let�, �Map�, �DTR_row�, �HideDerTableRow�, �$��]));
a(cases_tac�c dominates DTR_where x� THEN asm_rewrite_tac[]);
val �_null_map_hide_lemma = save_pop_thm"�_null_map_hide_lemma";
push_goal([], ��c rl1 rl2�
	Map (HideDerTableRow c) rl1 = Map(HideDerTableRow c) rl2
	�
	Map (HideDerTableRow c) (rl1 � {r | c dominates DTR_where r})
	=
	Map (HideDerTableRow c) (rl2 � {r | c dominates DTR_where r})�);
a(REPEAT_N 2 strip_tac);
a(list_induction_tac �rl1� THEN asm_rewrite_tac(
	map_null_thm::map get_spec[�Map�, �$��]) THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[get_spec�$��]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN strip_asm_tac(�_elim�rl2�list_cases_thm)
	THEN all_var_elim_asm_tac1 THEN asm_rewrite_tac[get_spec�Map�]);
a(rewrite_tac(MkDerTableRow_lemma::
	map get_spec[�HideDerTableRow�, �Let�, �Map�, �$��])
	THEN REPEAT strip_tac);
a(all_asm_fc_tac[] THEN asm_rewrite_tac[]);
a(cases_tac�c dominates DTR_where x'� THEN asm_rewrite_tac[get_spec�Map�]);
a(rewrite_tac(MkDerTableRow_lemma::
	map get_spec[�HideDerTableRow�, �Let�, �Map�, �$��])
	THEN REPEAT strip_tac);
val map_hide_map_hide_�_lemma = save_pop_thm"map_hide_map_hide_�_lemma";
set_goal([], ��l a b� l � (a � b) = (l � a) � b�);
a(REPEAT strip_tac);
a(list_induction_tac �l� THEN asm_rewrite_tac(
	map get_spec[�$��]));
a(strip_tac THEN PC_T1 "sets_ext1" rewrite_tac[]);
a(cases_tac�x � a� THEN asm_rewrite_tac[get_spec�$��]);
val �_�_lemma = save_pop_thm"�_�_lemma";
push_goal([], ��xy list�
	Split [] = ([], []) �
	Split (Cons xy list) =
	(Cons (Fst xy) (Fst (Split list)), Cons (Snd xy) (Snd (Split list)))�);
a(rewrite_tac[get_spec�Split�] THEN REPEAT strip_tac);
a(lemma_tac ��x y�xy = (x, y)� THEN1
	(�_tac�Fst xy� THEN �_tac�Snd xy�) THEN
	asm_rewrite_tac[get_spec�Split�]);
val split_thm = save_pop_thm"split_thm";
push_goal([], ��list�Length list = 0 � list = []�);
a(REPEAT strip_tac THEN_LIST [id_tac, asm_rewrite_tac[get_spec�Length�]]);
a(POP_ASM_T ante_tac THEN list_induction_tac�list�
	THEN rename_tac[] THEN asm_rewrite_tac[get_spec�Length�]);
val length_0_thm = save_pop_thm"length_0_thm";
push_goal([], ��list�Length list = 1 � �x�list = [x]�);
a(REPEAT strip_tac THEN_LIST [id_tac, asm_rewrite_tac[get_spec�Length�]]);
a(POP_ASM_T ante_tac THEN list_induction_tac�list�
	THEN rename_tac[] THEN asm_rewrite_tac[get_spec�Length�, length_0_thm]);
a(REPEAT strip_tac THEN prove_�_tac);
val length_1_thm = save_pop_thm"length_1_thm";
push_goal([], ��list�
	Fst(Split list) = Map Fst list �
	Snd(Split list)= Map Snd list �);
a(strip_tac);
a(list_induction_tac �list� THEN
	asm_rewrite_tac(split_thm::map get_spec[�Map�]));
val fst_snd_split_thm = save_pop_thm"fst_snd_split_thm";
push_goal([], ��c cl� lubl [] = lattice_bottom � lubl (Cons c cl) = c lub lubl cl�);
a(REPEAT �_tac THEN rewrite_tac(map get_spec[�lubl�, �Fold�]));
val lubl_lemma = save_pop_thm"lubl_lemma";
push_goal([], ��c� c lub lattice_bottom = c�);
a(REPEAT strip_tac THEN lemma_tac
	�c dominates c lub lattice_bottom �
		c lub lattice_bottom dominates c�
	THEN_LIST [rewrite_tac[get_spec�$lub�], all_fc_tac[get_spec�$lub�]]);
a(lemma_tac
	�c dominates c � c dominates lattice_bottom�
	THEN_LIST [rewrite_tac[get_spec�$lub�], all_fc_tac[get_spec�$lub�]]);
val lub_lattice_bottom_thm = save_pop_thm"lub_lattice_bottom_thm";
push_goal([], ��cc cil�
	cc dominates lubl (Map Fst cil)
	�
	Map (� (c, i)� (c, (if cc dominates c then i else Arbitrary))) cil
	= cil
�);
a(REPEAT �_tac);
a(list_induction_tac �cil�
	THEN asm_rewrite_tac(dominates_lub_lemma::lubl_lemma :: map get_spec[�Map�]));
a(REPEAT strip_tac THEN asm_rewrite_tac[]);
val dominates_lubl_map_hide_lemma = save_pop_thm "dominates_lubl_map_hide_lemma";
set_goal([], ��cc tst cev cevs ev�
	CaseVal cc tst [] ev =
	(�tl rl r�
	let	(tc, ti) = tst tl rl r
	in let	(ec, ei) = ev tl rl r
	in	if	cc dominates tc
		then	(ec, ei)
		else	(tc, ei))
�	CaseVal cc tst (Cons cev cevs) ev =
	(�tl rl r�
	let	(cr, ir) = CaseVal cc tst cevs ev tl rl r
	in let	(tc, ti) = tst tl rl r
	in let	(ce, cv) = cev
	in let 	(cec, cei) = ce tl rl r
	in let 	(cvc, cvi) = cv tl rl r
	in	if	ti = cei
		then	if	cc dominates tc � cc dominates cec
			then	(cvc, cvi)
			else if	�cc dominates tc
			then	(tc, cvi)
			else	(cec, cvi)
		else	if	cc dominates tc � cc dominates cec
			then	(cr, ir)
			else if	�cc dominates tc
			then	(tc, ir)
			else	(cec, ir))
�);
a(PC_T1 "predicates1" rewrite_tac[]);
a(rewrite_tac(map get_spec[�$dom�, �CaseVal�, �CheckTest�,
	�CaseValValue�, �CheckList�, �Let�, �Map�]) THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(cases_tac �cc dominates Fst (tst x x' x'')� THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(cases_tac �cc dominates Fst (tst x x' x'')� THEN
	cases_tac �cc dominates Fst (Fst cev x x' x'')� THEN
	cases_tac �Snd (tst x x' x'') = Snd (Fst cev x x' x'')� THEN
	asm_rewrite_tac[]);
val CaseVal_lemma = save_pop_thm "CaseVal_lemma";
set_pc"hol";
set_goal([], ��c� OK_TC�d c � OkTableComputation c�);
a(PC_T1"hol2"
	rewrite_tac(map get_spec[�OK_TC�d�, �OkTableComputation�, �RiskInputs�, �Let�])
	THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 2 (strip_asm_tac o eq_sym_rule));
a(DROP_NTH_ASM_T 2 (strip_asm_tac o conv_rule(RAND_C eq_sym_conv)));
a(all_asm_fc_tac[]);
val OK_TC�d_lemma = save_pop_thm"OK_TC�d_lemma";
set_goal([], ��c ci� DenoteConstant ci � OK_VC�d c�);
a(rewrite_tac(map get_spec[�OK_VC�d�, �DenoteConstant�]) THEN REPEAT strip_tac);
val DenoteConstant_OK�d_lemma = save_pop_thm"DenoteConstant_OK�d_lemma";
set_goal([], ��c i� Contents i � OK_VC�d c�);
a(rewrite_tac(map get_spec[�OK_VC�d�, �Contents�])
	THEN REPEAT strip_tac);
a(POP_ASM_T ante_tac THEN all_fc_tac[HideDerTableRow_Length_lemma]);
a(cases_tac �1 � i � i � # (DTR_cols r�1)� THEN asm_rewrite_tac[]);
a(lemma_tac�i � # (DTR_cols r�0)� THEN1 asm_rewrite_tac[]);
a(ALL_FC_T (MAP_EVERY(asm_tac o �_elim�c�)) [Nth_HideDerTableRow_lemma]);
a(contr_tac);
a(swap_nth_asm_concl_tac 4 THEN LIST_DROP_NTH_ASM_T [3, 8] rewrite_tac);
a(cases_tac �Fst (Nth (DTR_cols r�1) i) = Fst (Nth (DTR_cols r�0) i)�
	THEN asm_rewrite_tac[]);
a(conv_tac (RAND_C eq_sym_conv) THEN asm_rewrite_tac[]);
val Contents_OK�d_lemma = save_pop_thm"Contents_OK�d_lemma";
set_goal([], ��c i� Classification i � OK_VC�d c�);
a(rewrite_tac(map get_spec[�OK_VC�d�, �Classification�]) 
	THEN REPEAT strip_tac);
a(POP_ASM_T ante_tac THEN all_fc_tac[HideDerTableRow_Length_lemma]);
a(cases_tac �1 � i � i � # (DTR_cols r�1)� THEN asm_rewrite_tac[]);
a(lemma_tac�i � # (DTR_cols r�0)� THEN1 asm_rewrite_tac[]);
a(ALL_FC_T (MAP_EVERY(asm_tac o �_elim�c�)) [Nth_HideDerTableRow_lemma]);
a(contr_tac);
a(swap_nth_asm_concl_tac 4 THEN LIST_DROP_NTH_ASM_T [3, 8] rewrite_tac);
a(cases_tac �Fst (Nth (DTR_cols r�1) i) = Fst (Nth (DTR_cols r�0) i)�
	THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 3 ante_tac THEN asm_rewrite_tac[]);
val Classification_OK�d_lemma = save_pop_thm"Classification_OK�d_lemma";
set_goal([], ��c� CountAll � OK_VC�d c�);
a(rewrite_tac(map get_spec[�OK_VC�d�, �CountAll�,�Let�]) THEN REPEAT strip_tac);
a(lemma_tac��(# rl�0) = (# rl�1)�
	THEN1 PC_T1 "prop_eq" asm_prove_tac[]);
a(DROP_NTH_ASM_T 2 (fn x => id_tac));
a(POP_ASM_T ante_tac THEN POP_ASM_T ante_tac THEN POP_ASM_T ante_tac);
a(intro_�_tac(�r�1�,�r�1�));
a(intro_�_tac(�r�0�,�r�0�));
a(intro_�_tac(�rl�1�,�rl�1�));
a(list_induction_tac�rl�0� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(strip_asm_tac (�_elim�rl�1� list_cases_thm));
(* *** Goal "1.1" *** *)
a(DROP_NTH_ASM_T 2 ante_tac THEN asm_rewrite_tac[]);
(* *** Goal "1.2" *** *)
a(swap_asm_concl_tac
	�Map (HideDerTableRow c) [] = Map (HideDerTableRow c) rl�1�
	THEN asm_rewrite_tac(map get_spec[�Map�]));
(* *** Goal "2" *** *)
a(strip_asm_tac (�_elim�rl�1� list_cases_thm));
(* *** Goal "2.1" *** *)
a(swap_asm_concl_tac
	�Map (HideDerTableRow c) (Cons x rl�0) = Map (HideDerTableRow c) rl�1�
	THEN asm_rewrite_tac(map get_spec[�Map�]));
(* *** Goal "2.2" *** *)
a(var_elim_nth_asm_tac 1);
a(rewrite_tac[dominates_lub_lemma,lubl_lemma,get_spec�Map�]);
a(REPEAT strip_tac);
a(DROP_NTH_ASM_T 4 (strip_asm_tac o rewrite_rule[get_spec�Map�]));
a(DROP_NTH_ASM_T 6 (ante_tac o list_�_elim[�list2�,�x�,�x'�]));
a(REPEAT strip_tac);
a(DROP_NTH_ASM_T 5 (strip_asm_tac o rewrite_rule[get_spec�Length�]));
val CountAll_OK�d_lemma = save_pop_thm"CountAll_OK�d_lemma";
set_goal([], ��c f vc� vc � OK_VC�d c � MonOp f vc � OK_VC�d c�);
a(rewrite_tac(map get_spec[�OK_VC�d�, �MonOp�, �Let�]) THEN REPEAT strip_tac);
a(lemma_tac��Snd (vc tl�0 rl�0 r�0) = Snd (vc tl�1 rl�1 r�1)�
	THEN1 PC_T1 "prop_eq" asm_prove_tac[]);
a(all_asm_fc_tac[]);
val MonOp_OK�d_lemma = save_pop_thm"MonOp_OK�d_lemma";
set_goal([],
	��cc cil1 cil2�
	Map (�(c, i)� (c, if cc dominates c then i else Arbitrary)) cil1 =
	Map (�(c, i)� (c, if cc dominates c then i else Arbitrary)) cil2
	�	Fst(ComputeAnd cc cil1) = Fst(ComputeAnd cc cil2)
	�	(cc dominates Fst(ComputeAnd cc cil1)
		�	Snd(ComputeAnd cc cil1) = Snd(ComputeAnd cc cil2))
�);
a(rewrite_tac(�_elim�Fst� fun_if_thm :: �_elim�Snd� fun_if_thm ::
	map get_spec[�ComputeAnd�, �Map�, �Let�])
	THEN REPEAT �_tac THEN strip_tac);
a(lemma_tac�cil1 � {(c, i)|cc dominates c � � ItemBool i}
		= cil2 � {(c, i)|cc dominates c � � ItemBool i}�);
(* *** Goal "1" *** *)
a(all_asm_ante_tac THEN intro_�_tac(�cil2�, �cil2�)
	THEN list_induction_tac�cil1�
	THEN asm_rewrite_tac(map get_spec[�$��, �Map�]));
(* *** Goal "1.1" *** *)
a(rewrite_tac[map_null_thm]);
a(REPEAT strip_tac THEN asm_rewrite_tac[get_spec�$��]);
(* *** Goal "1.2" *** *)
a(REPEAT strip_tac);
a(strip_asm_tac(�_elim�cil2�list_cases_thm) THEN all_var_elim_asm_tac1
	THEN POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
a(REPEAT strip_tac THEN all_asm_fc_tac[]);
a(asm_rewrite_tac[get_spec�$��]);
a(cases_tac�cc dominates Fst x'� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 4 ante_tac THEN asm_rewrite_tac[]);
a(REPEAT strip_tac THEN asm_rewrite_tac[]);
a(cases_tac�� ItemBool (Snd x')� THEN asm_rewrite_tac[]);
a(PC_T1 "prop_eq_pair" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[]);
a(lemma_tac�Map Fst cil1 = Map Fst cil2�);
(* *** Goal "2.1" *** *)
a(LEMMA_T�
	Map Fst(Map (� (c, i)�
		(c, (if cc dominates c then i else Arbitrary))) cil1) = 
	Map Fst(Map (� (c, i)�
		(c, (if cc dominates c then i else Arbitrary))) cil2)�
	(ante_tac o rewrite_rule[map_o_lemma])
	THEN1 asm_rewrite_tac[]);
a(LEMMA_T �
	(Fst o (� (c, i:Item) � (c, (if cc dominates c then i else Arbitrary))))
	= Fst� rewrite_thm_tac);
a(PC_T1"hol2" rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(cases_tac�cil2 � {(c, i)|cc dominates c � �ItemBool i} = []� THEN
	asm_rewrite_tac[]);
a(strip_tac THEN LEMMA_T �cil1 = cil2� rewrite_thm_tac);
a(lemma_tac�cc dominates lubl (Map Fst cil1)� THEN1 asm_rewrite_tac[]);
a(all_fc_tac[dominates_lubl_map_hide_lemma]);
a(swap_nth_asm_concl_tac 8 THEN asm_rewrite_tac[]);
val ComputeAnd_lemma = save_pop_thm"ComputeAnd_lemma";
set_goal([],
	��c vcl� Elems vcl � OK_VC�d c � Elems vcl � OK_VC�c c 
	� BinOpAnd c vcl � OK_VC�d c�);
a(rewrite_tac(
	map get_spec[�BinOpAnd�, �OK_VC�d�, �OK_VC�c�])
	THEN REPEAT strip_tac THEN swap_nth_asm_concl_tac 1
	THEN POP_ASM_T ante_tac THEN strip_tac);
a(lemma_tac�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (� e� e tl�0 rl�0 r�0) vcl) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (� e� e tl�1 rl�1 r�1) vcl)�
	THEN_LIST [id_tac, all_fc_tac[ComputeAnd_lemma]]);
a(POP_ASM_T discard_tac THEN
	asm_ante_tac �Elems vcl � OK_VC�c c� THEN 
	asm_ante_tac �Elems vcl � OK_VC�d c�
	THEN list_induction_tac�vcl�);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
(* *** Goal "3" *** *)
a(PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
(* *** Goal "4" *** *)
a(asm_rewrite_tac(map get_spec[�Elems�, �Map�]) THEN REPEAT_N 3 strip_tac);
a(LEMMA_T�x � OK_VC�d c � x � OK_VC�c c�	
	(strip_asm_tac o rewrite_rule(map get_spec[�OK_VC�d�, �OK_VC�c�])) THEN1
	PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
a(all_asm_fc_tac[] THEN asm_rewrite_tac[]);
a(cases_tac�c dominates Fst (x tl�1 rl�1 r�1)� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (x tl�0 rl�0 r�0)� THEN1 asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
val BinOpAnd_OK�d_lemma = save_pop_thm"BinOpAnd_OK�d_lemma";
set_goal([],
	��cc cil1 cil2�
	Map (�(c, i)� (c, if cc dominates c then i else Arbitrary)) cil1 =
	Map (�(c, i)� (c, if cc dominates c then i else Arbitrary)) cil2
	�	Fst(ComputeOr cc cil1) = Fst(ComputeOr cc cil2)
	�	(cc dominates Fst(ComputeOr cc cil1)
		�	Snd(ComputeOr cc cil1) = Snd(ComputeOr cc cil2))
�);
a(rewrite_tac(�_elim�Fst� fun_if_thm :: �_elim�Snd� fun_if_thm ::
	map get_spec[�ComputeOr�, �Map�, �Let�])
	THEN REPEAT �_tac THEN strip_tac);
a(lemma_tac�cil1 � {(c, i)|cc dominates c � ItemBool i}
		= cil2 � {(c, i)|cc dominates c � ItemBool i}�);
(* *** Goal "1" *** *)
a(all_asm_ante_tac THEN intro_�_tac(�cil2�, �cil2�)
	THEN list_induction_tac�cil1�
	THEN asm_rewrite_tac(map get_spec[�$��, �Map�]));
(* *** Goal "1.1" *** *)
a(rewrite_tac[map_null_thm]);
a(REPEAT strip_tac THEN asm_rewrite_tac[get_spec�$��]);
(* *** Goal "1.2" *** *)
a(REPEAT strip_tac);
a(strip_asm_tac(�_elim�cil2�list_cases_thm) THEN all_var_elim_asm_tac1
	THEN POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
a(REPEAT strip_tac THEN all_asm_fc_tac[]);
a(asm_rewrite_tac[get_spec�$��]);
a(cases_tac�cc dominates Fst x'� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 4 ante_tac THEN asm_rewrite_tac[]);
a(REPEAT strip_tac THEN asm_rewrite_tac[]);
a(cases_tac�� ItemBool (Snd x')� THEN asm_rewrite_tac[]);
a(PC_T1 "prop_eq_pair" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[]);
a(lemma_tac�Map Fst cil1 = Map Fst cil2�);
(* *** Goal "2.1" *** *)
a(LEMMA_T�
	Map Fst(Map (� (c, i)�
		(c, (if cc dominates c then i else Arbitrary))) cil1) = 
	Map Fst(Map (� (c, i)�
		(c, (if cc dominates c then i else Arbitrary))) cil2)�
	(ante_tac o rewrite_rule[map_o_lemma])
	THEN1 asm_rewrite_tac[]);
a(LEMMA_T �
	(Fst o (� (c, i:Item) � (c, (if cc dominates c then i else Arbitrary))))
	= Fst� rewrite_thm_tac);
a(PC_T1"hol2" rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(cases_tac�cil2 � {(c, i)|cc dominates c � ItemBool i} = []� THEN
	asm_rewrite_tac[]);
a(strip_tac THEN LEMMA_T �cil1 = cil2� rewrite_thm_tac);
a(lemma_tac�cc dominates lubl (Map Fst cil1)� THEN1 asm_rewrite_tac[]);
a(all_fc_tac[dominates_lubl_map_hide_lemma]);
a(swap_nth_asm_concl_tac 8 THEN asm_rewrite_tac[]);
val ComputeOr_lemma = save_pop_thm"ComputeOr_lemma";
set_goal([],
	��c vcl� Elems vcl � OK_VC�d c � Elems vcl � OK_VC�c c 
	� BinOpOr c vcl � OK_VC�d c�);
a(rewrite_tac(
	map get_spec[�BinOpOr�, �OK_VC�d�, �OK_VC�c�])
	THEN REPEAT strip_tac THEN swap_nth_asm_concl_tac 1
	THEN POP_ASM_T ante_tac THEN strip_tac);
a(lemma_tac�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (� e� e tl�0 rl�0 r�0) vcl) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (� e� e tl�1 rl�1 r�1) vcl)�
	THEN_LIST [id_tac, all_fc_tac[ComputeOr_lemma]]);
a(POP_ASM_T discard_tac THEN
	asm_ante_tac �Elems vcl � OK_VC�c c� THEN 
	asm_ante_tac �Elems vcl � OK_VC�d c�
	THEN list_induction_tac�vcl�);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
(* *** Goal "3" *** *)
a(PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
(* *** Goal "4" *** *)
a(asm_rewrite_tac(map get_spec[�Elems�, �Map�]) THEN REPEAT_N 3 strip_tac);
a(LEMMA_T�x � OK_VC�d c � x � OK_VC�c c�	
	(strip_asm_tac o rewrite_rule(map get_spec[�OK_VC�d�, �OK_VC�c�])) THEN1
	PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
a(all_asm_fc_tac[] THEN asm_rewrite_tac[]);
a(cases_tac�c dominates Fst (x tl�1 rl�1 r�1)� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (x tl�0 rl�0 r�0)� THEN1 asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
val BinOpOr_OK�d_lemma = save_pop_thm"BinOpOr_OK�d_lemma";
set_goal([], ��c f vc1 vc2� vc1 � OK_VC�d c � vc2 � OK_VC�d c 
	� BinOp f vc1 vc2 � OK_VC�d c�);
a(rewrite_tac(dominates_lub_lemma :: map get_spec[�OK_VC�d�, �BinOp�, �Let�])
	THEN REPEAT strip_tac);
a(lemma_tac�Snd (vc2 tl�0 rl�0 r�0) = Snd (vc2 tl�1 rl�1 r�1)�
	THEN1 (contr_tac THEN all_asm_fc_tac[]));
a(lemma_tac��Snd (vc1 tl�0 rl�0 r�0) = Snd (vc1 tl�1 rl�1 r�1)�
	THEN1 PC_T1 "prop_eq" asm_prove_tac[]);
a(all_asm_fc_tac[]);
val BinOp_OK�d_lemma = save_pop_thm"BinOp_OK�d_lemma";
set_goal([], ��c f vc1 vc2 vc3�
	vc1 � OK_VC�d c � vc2 � OK_VC�d c � vc3 � OK_VC�d c �
	TriOp f vc1 vc2 vc3 � OK_VC�d c�);
a(rewrite_tac(dominates_lub_lemma :: map get_spec[�OK_VC�d�, �TriOp�, �Let�])
	THEN REPEAT strip_tac);
a(lemma_tac�Snd (vc2 tl�0 rl�0 r�0) = Snd (vc2 tl�1 rl�1 r�1) �
	Snd (vc3 tl�0 rl�0 r�0) = Snd (vc3 tl�1 rl�1 r�1)�
	THEN1 (contr_tac THEN all_asm_fc_tac[]));
a(lemma_tac��Snd (vc1 tl�0 rl�0 r�0) = Snd (vc1 tl�1 rl�1 r�1)�
	THEN1 PC_T1 "prop_eq" asm_prove_tac[]);
a(all_asm_fc_tac[]);
val TriOp_OK�d_lemma = save_pop_thm"TriOp_OK�d_lemma";
set_goal([], ��c te cel ee�
	te � OK_VC�d c �
	Elems (Map Fst cel) � OK_VC�d c �
	Elems (Map Snd cel) � OK_VC�d c �
	ee � OK_VC�d c �
	CaseVal c te cel ee � OK_VC�d c
�);
a(REPEAT �_tac);
a(list_induction_tac�cel� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(rewrite_tac(CaseVal_lemma:: map get_spec[�OK_VC�d�, �Let�])
	THEN REPEAT �_tac);
a(rewrite_tac[�_elim�Snd� fun_if_thm]);
a(CASES_T�c dominates Fst (te tl�0 rl�0 r�0)� rewrite_thm_tac);
a(CASES_T�c dominates Fst (te tl�1 rl�1 r�1)� rewrite_thm_tac);
(* *** Goal "1.1" (duplicates "1.2") *** *)
a(REPEAT strip_tac THEN
	DROP_ASM_T �ee � OK_VC�d c�
	(fn th => all_fc_tac[rewrite_rule(map get_spec[�OK_VC�d�])th])
	THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "3" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "4" *** *)
a(rewrite_tac(�_elim�Snd� fun_if_thm::�_elim�Fst� fun_if_thm::CaseVal_lemma::
	map get_spec[�OK_VC�d�, �Let�])
	THEN REPEAT �_tac);
a(MAP_EVERY (fn t => CASES_T t (fn th => rewrite_tac[th] THEN strip_asm_tac th))
	[�Snd (te tl�0 rl�0 r�0) = Snd (Fst x tl�0 rl�0 r�0)�,
	 �c dominates Fst (te tl�0 rl�0 r�0)�,
	 �c dominates Fst (Fst x tl�0 rl�0 r�0)�]);
(* *** Goal "4.1" *** *)
val tac1 = REPEAT strip_tac THEN
	LEMMA_T �Snd x � OK_VC�d c�
	(fn th => all_fc_tac[rewrite_rule(map get_spec[�OK_VC�d�])th])
	THEN1 PC_T1 "sets_ext" asm_prove_tac(map get_spec[�Elems�, �Map�]);
val tac2 = REPEAT strip_tac THEN
	cases_tac�Snd (te tl�0 rl�0 r�0) = Snd (te tl�1 rl�1 r�1)�
	THEN_LIST [
	asm_ante_tac �� Snd (te tl�1 rl�1 r�1) = Snd (Fst x tl�1 rl�1 r�1)�
	THEN POP_ASM_T (asm_rewrite_thm_tac o eq_sym_rule)
	THEN REPEAT strip_tac THEN
	LEMMA_T �Fst x � OK_VC�d c�
		(fn th => all_fc_tac[rewrite_rule(map get_spec[�OK_VC�d�])th])
	THEN1 PC_T1 "sets_ext" asm_prove_tac(map get_spec[�Elems�, �Map�])
	,
	DROP_ASM_T �te � OK_VC�d c�
	(fn th => all_fc_tac[rewrite_rule(map get_spec[�OK_VC�d�])th])];
a(MAP_EVERY (fn t => CASES_T t (fn th => rewrite_tac[th] THEN strip_asm_tac th))
	[�Snd (te tl�1 rl�1 r�1) = Snd (Fst x tl�1 rl�1 r�1)�,
	 �c dominates Fst (Fst x tl�1 rl�1 r�1)�,
	 �c dominates Fst (te tl�1 rl�1 r�1)�]
	THEN_LIST[tac1, tac1, tac1, tac1, tac2, tac2, tac2, tac2]);
(* *** Goal "4.2" *** *)
val tac3 = REPEAT strip_tac THEN
	cases_tac�Snd (te tl�0 rl�0 r�0) = Snd (te tl�1 rl�1 r�1)�
	THEN_LIST [
	asm_ante_tac �� Snd (te tl�0 rl�0 r�0) = Snd (Fst x tl�0 rl�0 r�0)�
	THEN asm_rewrite_tac[]
	THEN STRIP_T (asm_tac o conv_rule(RAND_C eq_sym_conv)) THEN
	LEMMA_T �Fst x � OK_VC�d c�
		(fn th => all_fc_tac[rewrite_rule(map get_spec[�OK_VC�d�])th])
	THEN1 PC_T1 "sets_ext" asm_prove_tac(map get_spec[�Elems�, �Map�])
	,
	DROP_ASM_T �te � OK_VC�d c�
	(fn th => all_fc_tac[rewrite_rule(map get_spec[�OK_VC�d�])th])];
val tac4 = REPEAT strip_tac THEN
	DROP_ASM_T �CaseVal c te cel ee � OK_VC�d c�
	(fn th => all_fc_tac[rewrite_rule(map get_spec[�OK_VC�d�])th]);
a(MAP_EVERY (fn t => CASES_T t (fn th => rewrite_tac[th] THEN strip_asm_tac th))
	[�Snd (te tl�1 rl�1 r�1) = Snd (Fst x tl�1 rl�1 r�1)�,
	 �c dominates Fst (Fst x tl�1 rl�1 r�1)�,
	 �c dominates Fst (te tl�1 rl�1 r�1)�]
	THEN_LIST[tac3, tac3, tac3, tac3, tac4, tac4, tac4, tac4]);
val CaseVal_OK�d_lemma = save_pop_thm"CaseVal_OK�d_lemma";
set_goal([], ��c cel ee�
	Elems (Map Fst cel) � OK_VC�d c �
	Elems (Map Snd cel) � OK_VC�d c �
	ee � OK_VC�d c �
	Case c cel ee � OK_VC�d c
�);
a(rewrite_tac(map get_spec[�Let�,�Case�]));
a(REPEAT �_tac);
a(list_induction_tac�cel� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN 
	rewrite_tac(map get_spec[�OK_VC�d�, �Let�,�Map�,�CaseC�,�CaseValue�])
	THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "3" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "4" *** *)
a(DROP_NTH_ASM_T 4 ante_tac THEN
	rewrite_tac(map get_spec[ �Let�,�Map�,�CaseC�,�CaseValue�,�OK_VC�d�])
	THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 5 (ante_tac o list_�_elim
	[�tl�0�,�tl�1�,�rl�0�,�rl�1�,�r�0�,�r�1�])
	THEN asm_rewrite_tac[]);
a(POP_ASM_T ante_tac 
	THEN cases_tac�� c dominates Fst (Fst x tl�0 rl�0 r�0)�
	THEN cases_tac�ItemBool (Snd (Fst x tl�0 rl�0 r�0))�
	THEN cases_tac�ItemBool (Snd (Fst x tl�1 rl�1 r�1))�

	THEN asm_rewrite_tac[]
	THEN REPEAT strip_tac);
(* 4.1 and 4.2 the same except for asm 1 *)
(* *** Goal "4.1" *** *)
a(POP_ASM_T (fn x => id_tac));
set_labelled_goal"4.2";
(* *** Goal "4.2" *** *)
a(POP_ASM_T (fn x => id_tac));
a(lemma_tac�Snd x � OK_VC�d c�
	THEN_LIST[PC_T1 "sets_ext" asm_prove_tac(map get_spec[�Elems�, �Map�]),
		all_asm_fc_tac[get_spec�OK_VC�d�]]);
(* *** Goal "4.3" *** *)
(* 4.3 and 4.4 the same except for asm 1 *)
a(POP_ASM_T (fn x => id_tac));
set_labelled_goal"4.4";
(* *** Goal "4.4" *** *)
a(POP_ASM_T (fn x => id_tac));
a(lemma_tac�Fst x � OK_VC�d c�
	THEN1 PC_T1 "sets_ext" asm_prove_tac(map get_spec[�Elems�, �Map�]));
a(lemma_tac�� Snd (Fst x tl�0 rl�0 r�0) = Snd (Fst x tl�1 rl�1 r�1)�
	THEN1 PC_T1 "prop_eq" asm_prove_tac[]);
a(all_asm_fc_tac[get_spec�OK_VC�d�]);
(* *** Goal "4.5" *** *)
a(lemma_tac�Fst x � OK_VC�d c�
	THEN1 PC_T1 "sets_ext" asm_prove_tac(map get_spec[�Elems�, �Map�]));
a(lemma_tac�� Snd (Fst x tl�0 rl�0 r�0) = Snd (Fst x tl�1 rl�1 r�1)�
	THEN1 PC_T1 "prop_eq" asm_prove_tac[]);
a(all_asm_fc_tac[get_spec�OK_VC�d�]);
val Case_OK�d_lemma = save_pop_thm"Case_OK�d_lemma";
set_goal([], ��c f vc� vc � OK_VC�d c � SetFuncAll f vc � OK_VC�d c�);
a(rewrite_tac(map get_spec[�SetFuncAll�, �OK_VC�d�, �Let�])
	THEN REPEAT strip_tac);
a(lemma_tac�� Snd(Split(Map(vc tl�0 rl�0) rl�0)) =
		Snd(Split(Map (vc tl�1 rl�1) rl�1))�
	THEN1 PC_T1 "prop_eq" asm_prove_tac[]);
a(lemma_tac ��rl1 rl2 rl�1�
	Map (HideDerTableRow c) rl1 = Map (HideDerTableRow c) rl2 �
	Map (HideDerTableRow c) rl�0 = Map (HideDerTableRow c) rl�1
             � � (Snd (Split (Map (vc tl�0 rl1) rl�0)))
                 = (Snd (Split (Map (vc tl�1 rl2) rl�1)))
             � � c dominates lubl (Fst (Split (Map (vc tl�0 rl1) rl�0)))�
	THEN_LIST[id_tac, all_asm_fc_tac[]]);
a(LIST_DROP_NTH_ASM_T [1, 2, 3, 4] (Combinators.K id_tac));
a(list_induction_tac�rl�0� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(strip_asm_tac (�_elim�rl�1� list_cases_thm));
(* *** Goal "1.1" *** *)
a(swap_asm_concl_tac
	 �� (Snd (Split (Map (vc tl�0 rl1) [])))
		= (Snd (Split (Map (vc tl�1 rl2) rl�1)))�
	THEN asm_rewrite_tac(map get_spec[�Split�, �Map�]));
(* *** Goal "1.2" *** *)
a(swap_asm_concl_tac
	�Map (HideDerTableRow c) [] = Map (HideDerTableRow c) rl�1�
	THEN asm_rewrite_tac(map get_spec[�Map�]));
(* *** Goal "2" *** *)
a(strip_asm_tac (�_elim�rl�1� list_cases_thm));
(* *** Goal "2.1" *** *)
a(swap_asm_concl_tac
	�Map (HideDerTableRow c) (Cons x rl�0) = Map (HideDerTableRow c) rl�1�
	THEN asm_rewrite_tac(map get_spec[�Map�]));
(* *** Goal "2.2" *** *)
a(var_elim_nth_asm_tac 1);
a(rewrite_tac[fst_snd_split_thm, lubl_lemma,
	get_spec�Map�, dominates_lub_lemma]);
a(swap_asm_concl_tac
	 �� (Snd (Split (Map (vc tl�0 rl1) (Cons x rl�0))))
		= (Snd (Split (Map (vc tl�1 rl2) (Cons x' list2))))�
	THEN asm_rewrite_tac[fst_snd_split_thm, lubl_lemma,
	get_spec�Map�, dominates_lub_lemma]);
a(GET_NTH_ASM_T 3 (strip_asm_tac o rewrite_rule[map_def]));
a(DROP_NTH_ASM_T 7 (strip_asm_tac o rewrite_rule[fst_snd_split_thm]));
a(contr_tac THEN all_asm_fc_tac[]);
val SetFuncAll_OK�d_lemma = save_pop_thm"SetFuncAll_OK�d_lemma";
set_goal([], ��c f vc� vc � OK_VC�d c � SetFuncDistinct f vc � OK_VC�d c�);
a(REPEAT strip_tac);
a(lemma_tac�SetFuncDistinct f vc = SetFuncAll (f o Elems) vc�
	THEN_LIST [rewrite_tac(map get_spec[�SetFuncDistinct�, �SetFuncAll�, �Let�]),
		POP_ASM_T rewrite_thm_tac]);
a(bc_tac[SetFuncAll_OK�d_lemma]THEN asm_rewrite_tac[]);
val SetFuncDistinct_OK�d_lemma = save_pop_thm"SetFuncDistinct_OK�d_lemma";
set_goal([], ��c vc� vc � OK_VC�d c � vc � OK_VC�c c 
	� SetFuncAllAnd c vc � OK_VC�d c�);
a(rewrite_tac(map get_spec[�SetFuncAllAnd�, �OK_VC�d�, �OK_VC�c�])
	THEN REPEAT strip_tac THEN swap_nth_asm_concl_tac 1
	THEN POP_ASM_T ante_tac THEN strip_tac);
a(lemma_tac�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�0 rl�0) rl�0) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�1 rl�1) rl�1)�
	THEN_LIST [id_tac, all_fc_tac[ComputeAnd_lemma]]);
a(LEMMA_T�
	�rl0 rl1�
	Map (HideDerTableRow c) rl0 = Map (HideDerTableRow c) rl1
	�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�0 rl�0) rl0) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�1 rl�1) rl1)�
	(fn th => all_fc_tac[th]));
a(strip_tac);
a(list_induction_tac�rl0� THEN asm_rewrite_tac[map_null_thm, get_spec�Map�]);
(* rewrite solves base case *)
a(REPEAT strip_tac);
a(strip_asm_tac(�_elim�rl1� list_cases_thm) THEN all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
a(strip_tac THEN ALL_ASM_FC_T rewrite_tac[]);
a(cases_tac�c dominates Fst (vc tl�1 rl�1 x')� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (vc tl�0 rl�0 x)�
	THEN1 ALL_ASM_FC_T asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
val SetFuncAllAnd_OK�d_lemma = save_pop_thm"SetFuncAllAnd_OK�d_lemma";
set_goal([], ��c vc� vc � OK_VC�d c � vc � OK_VC�c c � SetFuncAllOr c vc � OK_VC�d c�);
a(rewrite_tac(map get_spec[�SetFuncAllOr�, �OK_VC�d�, �OK_VC�c�])
	THEN REPEAT strip_tac THEN swap_nth_asm_concl_tac 1
	THEN POP_ASM_T ante_tac THEN strip_tac);
a(lemma_tac�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�0 rl�0) rl�0) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�1 rl�1) rl�1)�
	THEN_LIST [id_tac, all_fc_tac[ComputeOr_lemma]]);
a(LEMMA_T�
	�rl0 rl1�
	Map (HideDerTableRow c) rl0 = Map (HideDerTableRow c) rl1
	�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�0 rl�0) rl0) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�1 rl�1) rl1)�
	(fn th => all_fc_tac[th]));
a(strip_tac);
a(list_induction_tac�rl0� THEN asm_rewrite_tac[map_null_thm, get_spec�Map�]);
(* rewrite solves base case *)
a(REPEAT strip_tac);
a(strip_asm_tac(�_elim�rl1� list_cases_thm) THEN all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
a(strip_tac THEN ALL_ASM_FC_T rewrite_tac[]);
a(cases_tac�c dominates Fst (vc tl�1 rl�1 x')� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (vc tl�0 rl�0 x)�
	THEN1 ALL_ASM_FC_T asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
val SetFuncAllOr_OK�d_lemma = save_pop_thm"SetFuncAllOr_OK�d_lemma";
set_goal([], ��c vc� vc � OK_VC�d c � CountNonNull vc � OK_VC�d c�);
a(rewrite_tac(map get_spec[�CountNonNull�,  �Let�])
	THEN REPEAT strip_tac);
a(bc_tac[SetFuncAll_OK�d_lemma]THEN asm_rewrite_tac[]);
val CountNonNull_OK�d_lemma = save_pop_thm"CountNonNull_OK�d_lemma";
set_goal([], ��c vc� vc � OK_VC�d c � CountDistinct vc � OK_VC�d c�);
a(rewrite_tac(map get_spec[�CountDistinct�,  �Let�])
	THEN REPEAT strip_tac);
a(bc_tac[SetFuncDistinct_OK�d_lemma]THEN asm_rewrite_tac[]);
val CountDistinct_OK�d_lemma = save_pop_thm"CountDistinct_OK�d_lemma";
set_goal([], ��c vc� vc � OK_VC�d c � CommonValue vc � OK_VC�d c�);
a(rewrite_tac(map get_spec[�CommonValue�, �Let�])
	THEN REPEAT strip_tac);
a(ALL_FC_T rewrite_tac [SetFuncAll_OK�d_lemma]);
val CommonValue_OK�d_lemma = save_pop_thm"CommonValue_OK�d_lemma";
set_goal([], ��c tc� tc � OK_TC�d c � tc � OK_TC�c c � ExistsTuples c tc � OK_VC�d c�);
a(rewrite_tac(BoolItem_OneOne_lemma :: dominates_lub_lemma ::
	�_elim�Fst�fun_if_thm :: �_elim�Snd�fun_if_thm ::
	map get_spec[�OK_TC�d�, �OK_TC�c�, �OK_VC�d�, �ExistsTuples�, �Let�]));
a(REPEAT strip_tac THEN POP_ASM_T ante_tac);
a(all_asm_fc_tac[]);
a(asm_rewrite_tac[]);
a(cases_tac �c dominates Fst (tc tl�1)� THEN asm_rewrite_tac[BoolItem_OneOne_lemma]);
a(cases_tac �HideDerTable c (Snd (tc tl�0)) = HideDerTable c (Snd (tc tl�1))�);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac(MkDerTable_lemma::
	map get_spec[�HideDerTable�, �HideDerTableData�, �Let�]));
a(strip_tac);
a(once_rewrite_tac[�_null_map_hide_lemma]);
a(asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(all_asm_fc_tac[]);
a(POP_ASM_T ante_tac THEN asm_rewrite_tac[]);
val ExistsTuples_OK�d_lemma = save_pop_thm"ExistsTuples_OK�d_lemma";
set_goal([], ��c tc� tc � OK_TC�d c � tc � OK_TC�c c � SingleValue c tc � OK_VC�d c�);
a(rewrite_tac(BoolItem_OneOne_lemma :: dominates_lub_lemma ::
	�_elim�Fst�fun_if_thm :: �_elim�Snd�fun_if_thm ::
	map get_spec[�OK_TC�d�, �OK_TC�c�, �OK_VC�d�, �SingleValue�, �Let�]));
a(REPEAT strip_tac THEN POP_ASM_T ante_tac);
a(all_asm_fc_tac[] THEN asm_rewrite_tac[]);
a(cases_tac �c dominates Fst (tc tl�1)� THEN asm_rewrite_tac[]);
a(cases_tac ��HideDerTable c (Snd (tc tl�0)) = HideDerTable c (Snd (tc tl�1))�);
(* *** Goal "1" *** *)
a(all_asm_fc_tac[]);
a(POP_ASM_T ante_tac THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac(MkDerTable_lemma::
	pc_rule1 "sets_ext1" prove_rule[]
	�{r|c dominates DTR_row r � c dominates DTR_where r} =
	{r|c dominates DTR_row r} � {r|c dominates DTR_where r}�::
	map get_spec[�HideDerTable�, �HideDerTableData�, �Let�]));
a(rewrite_tac[�_�_lemma] THEN strip_tac);
a(all_fc_tac[map_hide_map_hide_�_lemma]);
a(LEMMA_T�
	#(Map (HideDerTableRow c)
		((DT_rows (Snd (tc tl�0)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r})) =
	#(Map (HideDerTableRow c)
		((DT_rows (Snd (tc tl�1)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r}))�
	(strip_asm_tac o rewrite_rule[length_map_thm])
	THEN1 asm_rewrite_tac[]);
a(cases_tac�
	#((DT_rows (Snd (tc tl�1)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r}) = 1�
	THEN asm_rewrite_tac[]);
a(lemma_tac�
	#((DT_rows (Snd (tc tl�0)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r}) = 1�
	THEN1 asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T[1,2]
	(MAP_EVERY(strip_asm_tac o rewrite_rule[length_1_thm])));
a(asm_rewrite_tac[]);
a(lemma_tac�HideDerTableRow c x = HideDerTableRow c x'�);
(* *** Goal "2.1" *** *)
a(DROP_NTH_ASM_T 5 ante_tac THEN asm_rewrite_tac[get_spec�Map�]);
(* *** Goal "2.2" *** *)
a(POP_ASM_T ante_tac THEN
	rewrite_tac[MkDerTableRow_lemma, let_def, get_spec�HideDerTableRow�]);
a(strip_tac);
a(LEMMA_T�
	#(Map (� (c', i)� if c dominates c'
		then (c', i)
		else (c', ValuedItemItem (MkValuedItem sterling dummyVal)))
               (DTR_cols x)) =
	#(Map (� (c', i)� if c dominates c'
		then (c', i)
		else (c', ValuedItemItem (MkValuedItem sterling dummyVal)))
               (DTR_cols x'))�
	(strip_asm_tac o rewrite_rule[length_map_thm])
	THEN1 asm_rewrite_tac[]);
a(asm_rewrite_tac[]);
a(cases_tac�# (DTR_cols x') = 1� THEN asm_rewrite_tac[]);
a(lemma_tac�# (DTR_cols x) = 1� THEN1 asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T[1,2]
	(MAP_EVERY(strip_asm_tac o rewrite_rule[length_1_thm])));
a(DROP_NTH_ASM_T 4 ante_tac THEN asm_rewrite_tac[get_spec�Map�]);
a(cases_tac�c dominates Fst x''� THEN asm_rewrite_tac[]);
a(cases_tac�c dominates Fst x'''� THEN asm_rewrite_tac[]
	THEN REPEAT strip_tac THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 3 ante_tac THEN asm_rewrite_tac[]);
val SingleValue_OK�d_lemma = save_pop_thm"SingleValue_OK�d_lemma";
set_goal([], ��c i� JoinedRowExistence i � OK_VC�d c�);
a(rewrite_tac(map get_spec[�OK_VC�d�, �JoinedRowExistence�])
	THEN REPEAT strip_tac);
a(GET_NTH_ASM_T 2 ante_tac THEN
	rewrite_tac(MkDerTableRow_lemma::map get_spec[�HideDerTableRow�, �Let�])
	THEN REPEAT strip_tac);
a(PC_T1 "prop_eq" asm_prove_tac[]);
val JoinedRowExistence_OK�d_lemma = save_pop_thm"JoinedRowExistence_OK�d_lemma";
set_goal([], ��c ci� DenoteConstant ci � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_VC�c�, �DenoteConstant�]) THEN REPEAT strip_tac);
val DenoteConstant_OK�c_lemma = save_pop_thm"DenoteConstant_OK�c_lemma";
set_goal([], ��c i� Contents i � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_VC�c�, �Contents�])
	THEN REPEAT strip_tac);
a(all_fc_tac[HideDerTableRow_Length_lemma]);
a(cases_tac �1 � i � i � # (DTR_cols r�1)� THEN asm_rewrite_tac[]);
a(lemma_tac�i � # (DTR_cols r�0)� THEN1 asm_rewrite_tac[]);
a(ALL_FC_T (MAP_EVERY(ante_tac o �_elim�c�)) [Nth_HideDerTableRow_lemma]);
a(asm_rewrite_tac[]);
a(PC_T1 "prop_eq_pair" prove_tac[]);
val Contents_OK�c_lemma = save_pop_thm"Contents_OK�c_lemma";
set_goal([], ��c i� Classification i � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_VC�c�, �Classification�]) 
	THEN REPEAT strip_tac);
a(all_fc_tac[HideDerTableRow_Length_lemma]);
a(cases_tac �1 � i � i � # (DTR_cols r�1)� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 4 ante_tac THEN
	rewrite_tac(MkDerTableRow_lemma::map get_spec[�Let�, �HideDerTableRow�])
	THEN taut_tac);
val Classification_OK�c_lemma = save_pop_thm"Classification_OK�c_lemma";
set_goal([], ��c� CountAll � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_VC�c�, �CountAll�,�Let�]) THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [1,3] discard_tac);
a(POP_ASM_T ante_tac);
a(intro_�_tac(�rl�1�,�rl�1�));
a(list_induction_tac�rl�0�);
(* *** Goal "1" *** *)
a(�_tac);
a(strip_asm_tac (�_elim�rl�1� list_cases_thm)
	THEN asm_rewrite_tac(map get_spec[�Map�]));
(* *** Goal "2" *** *)
a(REPEAT �_tac);
a(strip_asm_tac (�_elim�rl�1� list_cases_thm)
	THEN asm_rewrite_tac(map get_spec[�Map�]));
a(rewrite_tac(lubl_lemma::MkDerTableRow_lemma::map get_spec[�Let�, �HideDerTableRow�])
	THEN REPEAT strip_tac);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
val CountAll_OK�c_lemma = save_pop_thm"CountAll_OK�c_lemma";
set_goal([], ��c f vc� vc � OK_VC�c c � MonOp f vc � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_VC�c�, �MonOp�, �Let�]) THEN REPEAT strip_tac);
val MonOp_OK�c_lemma = save_pop_thm"MonOp_OK�c_lemma";
set_goal([],
	��c vcl� Elems vcl � OK_VC�d c � Elems vcl � OK_VC�c c 
	� BinOpAnd c vcl � OK_VC�c c�);
a(rewrite_tac(
	map get_spec[�BinOpAnd�, �OK_VC�d�, �OK_VC�c�])
	THEN REPEAT strip_tac);
a(lemma_tac�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (� e� e tl�0 rl�0 r�0) vcl) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (� e� e tl�1 rl�1 r�1) vcl)�
	THEN_LIST [id_tac, all_fc_tac[ComputeAnd_lemma]]);
a(asm_ante_tac �Elems vcl � OK_VC�c c� THEN asm_ante_tac �Elems vcl � OK_VC�d c�
	THEN list_induction_tac�vcl�);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
(* *** Goal "3" *** *)
a(PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
(* *** Goal "4" *** *)
a(asm_rewrite_tac(map get_spec[�Elems�, �Map�]) THEN REPEAT_N 3 strip_tac);
a(LEMMA_T�x � OK_VC�d c � x � OK_VC�c c�	
	(strip_asm_tac o rewrite_rule(map get_spec[�OK_VC�d�, �OK_VC�c�])) THEN1
	PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
a(all_asm_fc_tac[] THEN asm_rewrite_tac[]);
a(cases_tac�c dominates Fst (x tl�1 rl�1 r�1)� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (x tl�0 rl�0 r�0)� THEN1 asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
val BinOpAnd_OK�c_lemma = save_pop_thm"BinOpAnd_OK�c_lemma";
set_goal([],
	��c vcl� Elems vcl � OK_VC�d c � Elems vcl � OK_VC�c c 
	� BinOpOr c vcl � OK_VC�c c�);
a(rewrite_tac(
	map get_spec[�BinOpOr�, �OK_VC�d�, �OK_VC�c�])
	THEN REPEAT strip_tac);
a(lemma_tac�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (� e� e tl�0 rl�0 r�0) vcl) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (� e� e tl�1 rl�1 r�1) vcl)�
	THEN_LIST [id_tac, all_fc_tac[ComputeOr_lemma]]);
a(asm_ante_tac �Elems vcl � OK_VC�c c� THEN asm_ante_tac �Elems vcl � OK_VC�d c�
	THEN list_induction_tac�vcl�);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
(* *** Goal "3" *** *)
a(PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
(* *** Goal "4" *** *)
a(asm_rewrite_tac(map get_spec[�Elems�, �Map�]) THEN REPEAT_N 3 strip_tac);
a(LEMMA_T�x � OK_VC�d c � x � OK_VC�c c�	
	(strip_asm_tac o rewrite_rule(map get_spec[�OK_VC�d�, �OK_VC�c�])) THEN1
	PC_T1"sets_ext1" asm_prove_tac[get_spec�Elems�]);
a(all_asm_fc_tac[] THEN asm_rewrite_tac[]);
a(cases_tac�c dominates Fst (x tl�1 rl�1 r�1)� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (x tl�0 rl�0 r�0)� THEN1 asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
val BinOpOr_OK�c_lemma = save_pop_thm"BinOpOr_OK�c_lemma";
set_goal([], ��c f vc1 vc2� vc1 � OK_VC�c c � vc2 � OK_VC�c c 
	� BinOp f vc1 vc2 � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_VC�c�, �BinOp�, �Let�])
	THEN REPEAT strip_tac);
a(ALL_ASM_FC_T rewrite_tac[]);
val BinOp_OK�c_lemma = save_pop_thm"BinOp_OK�c_lemma";
set_goal([], ��c f vc1 vc2 vc3�
	vc1 � OK_VC�c c � vc2 � OK_VC�c c � vc3 � OK_VC�c c �
	TriOp f vc1 vc2 vc3 � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_VC�c�, �TriOp�, �Let�])
	THEN REPEAT strip_tac);
a(ALL_ASM_FC_T rewrite_tac[]);
val TriOp_OK�c_lemma = save_pop_thm"TriOp_OK�c_lemma";
set_goal([], ��c te cel ee�
	te � OK_VC�d c �
	te � OK_VC�c c �
	Elems (Map Fst cel) � OK_VC�d c �
	Elems (Map Fst cel) � OK_VC�c c �
	Elems (Map Snd cel) � OK_VC�c c �
	ee � OK_VC�c c �
	CaseVal c te cel ee � OK_VC�c c
�);
a(REPEAT �_tac);
a(list_induction_tac�cel� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LIST_DROP_NTH_ASM_T [1,5] (MAP_EVERY ante_tac)
	THEN rewrite_tac(CaseVal_lemma:: map get_spec[�OK_VC�c�, �Let�])
	THEN REPEAT strip_tac);
a(rewrite_tac[�_elim�Fst� fun_if_thm]);
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "2" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "3" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "4" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "5" *** *)
a(rewrite_tac(�_elim�Snd� fun_if_thm::�_elim�Fst� fun_if_thm::CaseVal_lemma::
	map get_spec[�OK_VC�c�, �Let�])
	THEN REPEAT strip_tac);
a(lemma_tac�
	Fst (te tl�0 rl�0 r�0) = Fst (te tl�1 rl�1 r�1) �
	Fst (Fst x tl�0 rl�0 r�0) = Fst (Fst x tl�1 rl�1 r�1) �
	Fst (Snd x tl�0 rl�0 r�0) = Fst (Snd x tl�1 rl�1 r�1) �
	Fst (CaseVal c te cel ee tl�0 rl�0 r�0) =
		 Fst (CaseVal c te cel ee tl�1 rl�1 r�1)�);
(* *** Goal "5.1" *** *)
a(lemma_tac �Fst x � OK_VC�c c � Snd x � OK_VC�c c�
	THEN1 PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
a(LIST_DROP_NTH_ASM_T [1,2,10,12]
	(MAP_EVERY(strip_asm_tac o rewrite_rule[get_spec�OK_VC�c�])));
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "5.2" *** *)
a(asm_rewrite_tac[]);
a(cases_tac�c dominates Fst (te tl�1 rl�1 r�1)�
	THEN cases_tac�c dominates Fst (Fst x tl�1 rl�1 r�1)�
	THEN asm_rewrite_tac[]);
(* *** Goal "5.2.1" *** *)
a(LEMMA_T�Snd (te tl�0 rl�0 r�0) = Snd (te tl�1 rl�1 r�1)
	� Snd (Fst x tl�0 rl�0 r�0) = Snd (Fst x tl�1 rl�1 r�1)�
	rewrite_thm_tac);
a(lemma_tac �Fst x � OK_VC�d c�
	THEN1 PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
a(LIST_DROP_NTH_ASM_T [1,16]
	(MAP_EVERY(strip_asm_tac o rewrite_rule[get_spec�OK_VC�d�])));
a(lemma_tac�c dominates Fst (te tl�0 rl�0 r�0)
	�	c dominates Fst (Fst x tl�0 rl�0 r�0)�
	THEN1 asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
(* *** Goal "5.2.2" *** *)
a(CASES_T �Snd (te tl�0 rl�0 r�0) = Snd (Fst x tl�0 rl�0 r�0)�
	rewrite_thm_tac
	THEN CASES_T�Snd (te tl�1 rl�1 r�1) = Snd (Fst x tl�1 rl�1 r�1)�
	rewrite_thm_tac);
(* *** Goal "5.2.3" *** *)
a(CASES_T �Snd (te tl�0 rl�0 r�0) = Snd (Fst x tl�0 rl�0 r�0)�
	rewrite_thm_tac
	THEN CASES_T�Snd (te tl�1 rl�1 r�1) = Snd (Fst x tl�1 rl�1 r�1)�
	rewrite_thm_tac);
(* *** Goal "5.2.4" *** *)
a(CASES_T �Snd (te tl�0 rl�0 r�0) = Snd (Fst x tl�0 rl�0 r�0)�
	rewrite_thm_tac
	THEN CASES_T�Snd (te tl�1 rl�1 r�1) = Snd (Fst x tl�1 rl�1 r�1)�
	rewrite_thm_tac);
val CaseVal_OK�c_lemma = save_pop_thm"CaseVal_OK�c_lemma";
set_goal([], ��c cel ee�
	Elems (Map Fst cel) � OK_VC�d c �
	Elems (Map Fst cel) � OK_VC�c c �
	Elems (Map Snd cel) � OK_VC�c c �
	ee � OK_VC�c c �
	Case c cel ee � OK_VC�c c
�);
a(rewrite_tac(map get_spec[�Let�,�Case�]));
a(REPEAT �_tac);
a(list_induction_tac�cel� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN 
	rewrite_tac(map get_spec[�OK_VC�c�, �Let�,�Map�,�CaseC�,�CaseValue�])
	THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "3" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "4" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
(* *** Goal "5" *** *)
a(rewrite_tac(map get_spec[ �Let�,�Map�,�CaseC�,�CaseValue�,�OK_VC�c�])
	THEN REPEAT strip_tac);
a(lemma_tac�Fst x � OK_VC�c c� THEN1
	PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
a(POP_ASM_T (fn th => all_asm_fc_tac[rewrite_rule[get_spec�OK_VC�c�]th]));
a(asm_rewrite_tac[]);
a(cases_tac�� c dominates Fst (Fst x tl�1 rl�1 r�1)�
	THEN asm_rewrite_tac[]);
a(lemma_tac�Snd x � OK_VC�c c� THEN1
	PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
a(POP_ASM_T (fn th => all_asm_fc_tac[rewrite_rule[get_spec�OK_VC�c�]th]));
a(asm_rewrite_tac[]);
a(LEMMA_T�Snd (Fst x tl�0 rl�0 r�0) = Snd (Fst x tl�1 rl�1 r�1)�
	rewrite_thm_tac);
(* *** Goal "5.1" *** *)
a(lemma_tac�Fst x � OK_VC�d c� THEN1
	PC_T1 "sets_ext1" asm_prove_tac(map get_spec[�Map�, �Elems�]));
a(POP_ASM_T (strip_asm_tac o rewrite_rule[get_spec�OK_VC�d�]));
a(lemma_tac�c dominates Fst (Fst x tl�0 rl�0 r�0)�
	THEN1 asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
(* *** Goal "5.2" *** *)
a(cases_tac�ItemBool (Snd (Fst x tl�1 rl�1 r�1))�
	THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 12 (fn th => all_asm_fc_tac[rewrite_rule[get_spec�OK_VC�c�]th]));
val Case_OK�c_lemma = save_pop_thm"Case_OK�c_lemma";
set_goal([], ��c f vc� vc � OK_VC�c c � SetFuncAll f vc � OK_VC�c c�);
a(rewrite_tac(map get_spec[�SetFuncAll�, �OK_VC�c�, �Let�])
	THEN REPEAT strip_tac);
a(lemma_tac ��tl�0 tl�1 rl1 rl2 rl�1�
	Map (HideDerTable c) tl�0 = Map (HideDerTable c) tl�1 �
	Map (HideDerTableRow c) rl1 = Map (HideDerTableRow c) rl2 �
	Map (HideDerTableRow c) rl�0 = Map (HideDerTableRow c) rl�1
             � Fst (Split (Map (vc tl�0 rl1) rl�0))
                 = Fst(Split (Map (vc tl�1 rl2) rl�1))�
	THEN_LIST[id_tac, ALL_ASM_FC_T rewrite_tac[]]);
a(LIST_DROP_NTH_ASM_T [1, 2, 3] discard_tac);
a(list_induction_tac�rl�0� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(strip_asm_tac (�_elim�rl�1� list_cases_thm));
(* *** Goal "1.1" *** *)
a(asm_rewrite_tac(map get_spec[�Map�]));
(* *** Goal "1.2" *** *)
a(var_elim_nth_asm_tac 1);
a(all_asm_ante_tac THEN asm_rewrite_tac(map get_spec[�Map�]));
(* *** Goal "2" *** *)
a(strip_asm_tac (�_elim�rl�1� list_cases_thm));
(* *** Goal "2.1" *** *)
a(swap_asm_concl_tac
	�Map (HideDerTableRow c) (Cons x rl�0) = Map (HideDerTableRow c) rl�1�
	THEN asm_rewrite_tac(map get_spec[�Map�]));
(* *** Goal "2.2" *** *)
a(var_elim_nth_asm_tac 1);
a(all_asm_ante_tac THEN rewrite_tac[fst_snd_split_thm, get_spec�Map�]
	THEN REPEAT strip_tac);
(* *** Goal "2.2.1" *** *)
a(all_asm_fc_tac[]);
(* *** Goal "2.2.2" *** *)
a(all_asm_fc_tac[]);
val SetFuncAll_OK�c_lemma = save_pop_thm"SetFuncAll_OK�c_lemma";
set_goal([], ��c f vc� vc � OK_VC�c c � SetFuncDistinct f vc � OK_VC�c c�);
a(REPEAT strip_tac);
a(lemma_tac�SetFuncDistinct f vc = SetFuncAll (f o Elems) vc�
	THEN_LIST [rewrite_tac(map get_spec[�SetFuncDistinct�, �SetFuncAll�, �Let�]),
		POP_ASM_T rewrite_thm_tac]);
a(bc_tac[SetFuncAll_OK�c_lemma]THEN asm_rewrite_tac[]);
val SetFuncDistinct_OK�c_lemma = save_pop_thm"SetFuncDistinct_OK�c_lemma";
set_goal([], ��c vc� vc � OK_VC�d c � vc � OK_VC�c c 
	� SetFuncAllAnd c vc � OK_VC�c c�);
a(rewrite_tac(map get_spec[�SetFuncAllAnd�, �OK_VC�d�, �OK_VC�c�])
	THEN REPEAT strip_tac);
a(lemma_tac�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�0 rl�0) rl�0) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�1 rl�1) rl�1)�
	THEN_LIST [id_tac, all_fc_tac[ComputeAnd_lemma]]);
a(LEMMA_T�
	�rl0 rl1�
	Map (HideDerTableRow c) rl0 = Map (HideDerTableRow c) rl1
	�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�0 rl�0) rl0) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�1 rl�1) rl1)�
	(fn th => all_fc_tac[th]));
a(strip_tac);
a(list_induction_tac�rl0� THEN asm_rewrite_tac[map_null_thm, get_spec�Map�]);
(* rewrite solves base case *)
a(REPEAT strip_tac);
a(strip_asm_tac(�_elim�rl1� list_cases_thm) THEN all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
a(strip_tac THEN ALL_ASM_FC_T rewrite_tac[]);
a(cases_tac�c dominates Fst (vc tl�1 rl�1 x')� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (vc tl�0 rl�0 x)�
	THEN1 ALL_ASM_FC_T asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
val SetFuncAllAnd_OK�c_lemma = save_pop_thm"SetFuncAllAnd_OK�c_lemma";
set_goal([], ��c vc� vc � OK_VC�d c � vc � OK_VC�c c � SetFuncAllOr c vc � OK_VC�c c�);
a(rewrite_tac(map get_spec[�SetFuncAllOr�, �OK_VC�d�, �OK_VC�c�])
	THEN REPEAT strip_tac);
a(lemma_tac�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�0 rl�0) rl�0) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�1 rl�1) rl�1)�
	THEN_LIST [id_tac, all_fc_tac[ComputeOr_lemma]]);
a(LEMMA_T�
	�rl0 rl1�
	Map (HideDerTableRow c) rl0 = Map (HideDerTableRow c) rl1
	�
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�0 rl�0) rl0) =
	Map (� (c', i)� (c', (if c dominates c' then i else Arbitrary)))
	(Map (vc tl�1 rl�1) rl1)�
	(fn th => all_fc_tac[th]));
a(strip_tac);
a(list_induction_tac�rl0� THEN asm_rewrite_tac[map_null_thm, get_spec�Map�]);
(* rewrite solves base case *)
a(REPEAT strip_tac);
a(strip_asm_tac(�_elim�rl1� list_cases_thm) THEN all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[get_spec�Map�]);
a(strip_tac THEN ALL_ASM_FC_T rewrite_tac[]);
a(cases_tac�c dominates Fst (vc tl�1 rl�1 x')� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (vc tl�0 rl�0 x)�
	THEN1 ALL_ASM_FC_T asm_rewrite_tac[]);
a(contr_tac THEN all_asm_fc_tac[]);
val SetFuncAllOr_OK�c_lemma = save_pop_thm"SetFuncAllOr_OK�c_lemma";
set_goal([], ��c vc� vc � OK_VC�c c � CountNonNull vc � OK_VC�c c�);
a(rewrite_tac(map get_spec[�CountNonNull�,  �Let�])
	THEN REPEAT strip_tac);
a(bc_tac[SetFuncAll_OK�c_lemma]THEN asm_rewrite_tac[]);
val CountNonNull_OK�c_lemma = save_pop_thm"CountNonNull_OK�c_lemma";
set_goal([], ��c vc� vc � OK_VC�c c � CountDistinct vc � OK_VC�c c�);
a(rewrite_tac(map get_spec[�CountDistinct�,  �Let�])
	THEN REPEAT strip_tac);
a(bc_tac[SetFuncDistinct_OK�c_lemma]THEN asm_rewrite_tac[]);
val CountDistinct_OK�c_lemma = save_pop_thm"CountDistinct_OK�c_lemma";
set_goal([], ��c vc� vc � OK_VC�c c � CommonValue vc � OK_VC�c c�);
a(rewrite_tac(map get_spec[�CommonValue�, �Let�])
	THEN REPEAT strip_tac);
a(ALL_FC_T rewrite_tac [SetFuncAll_OK�c_lemma]);
val CommonValue_OK�c_lemma = save_pop_thm"CommonValue_OK�c_lemma";
set_goal([], ��c tc� tc � OK_TC�d c � tc � OK_TC�c c � ExistsTuples c tc � OK_VC�c c�);
a(rewrite_tac(
	map get_spec[�OK_TC�d�, �OK_TC�c�, �OK_VC�c�, �ExistsTuples�, �Let�])
	THEN REPEAT strip_tac);
a(cases_tac�� HideDerTable c (Snd (tc tl�0)) = HideDerTable c (Snd (tc tl�1))�);
(* *** Goal "1" *** *)
a(all_asm_fc_tac[]);
a(DROP_ASM_T �� c dominates Fst (tc tl�0)� ante_tac THEN asm_rewrite_tac[]);
a(strip_tac THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(all_asm_fc_tac[]);
a(cases_tac�c dominates Fst (tc tl�1)� THEN asm_rewrite_tac[]);
a(DROP_ASM_T �HideDerTable c (Snd (tc tl�0)) = HideDerTable c (Snd (tc tl�1))�
	ante_tac);
a(rewrite_tac(MkDerTable_lemma::
	pc_rule1 "sets_ext1" prove_rule[]
	�{r|c dominates DTR_row r � c dominates DTR_where r} =
	{r|c dominates DTR_row r} � {r|c dominates DTR_where r}�::
	�_�_lemma::
	map get_spec[�HideDerTable�, �HideDerTableData�, �Let�])
	THEN REPEAT strip_tac);
a(all_fc_tac[map_hide_map_hide_�_lemma]);
a(lemma_tac�
	Map DTR_row(Map(HideDerTableRow c)
		((DT_rows (Snd (tc tl�0)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r})) =
	Map DTR_row(Map(HideDerTableRow c)
		((DT_rows (Snd (tc tl�1)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r}))�
	THEN1 asm_rewrite_tac[]);
a(POP_ASM_T ante_tac THEN 
	rewrite_tac[map_o_lemma, DTR_row_o_HideDerTableRow_lemma]);
a(STRIP_T rewrite_thm_tac);
val ExistsTuples_OK�c_lemma = save_pop_thm"ExistsTuples_OK�c_lemma";
set_goal([], ��c tc� tc � OK_TC�d c � tc � OK_TC�c c � SingleValue c tc � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_TC�d�, �OK_TC�c�, �OK_VC�c�, �SingleValue�, �Let�])
	THEN REPEAT strip_tac);
a(all_asm_fc_tac[] THEN asm_rewrite_tac[�_elim�Fst�fun_if_thm]);
a(cases_tac�c dominates Fst (tc tl�1)� THEN asm_rewrite_tac[]);
a(lemma_tac�c dominates Fst (tc tl�0)� THEN1 asm_rewrite_tac[]);
a(cases_tac��HideDerTable c (Snd (tc tl�0)) = HideDerTable c (Snd (tc tl�1))�
	THEN1 all_asm_fc_tac[]);
a(POP_ASM_T ante_tac THEN rewrite_tac(MkDerTable_lemma::
	pc_rule1 "sets_ext1" prove_rule[]
	�{r|c dominates DTR_row r � c dominates DTR_where r} =
	{r|c dominates DTR_row r} � {r|c dominates DTR_where r}�::
	map get_spec[�HideDerTable�, �HideDerTableData�, �Let�]));
a(rewrite_tac[�_�_lemma] THEN strip_tac);
a(all_fc_tac[map_hide_map_hide_�_lemma]);
a(LEMMA_T�
	#(Map (HideDerTableRow c)
		((DT_rows (Snd (tc tl�0)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r})) =
	#(Map (HideDerTableRow c)
		((DT_rows (Snd (tc tl�1)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r}))�
	(strip_asm_tac o rewrite_rule[length_map_thm])
	THEN1 asm_rewrite_tac[]);
a(cases_tac�
	#((DT_rows (Snd (tc tl�1)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r}) = 1�
	THEN asm_rewrite_tac[]);
a(lemma_tac�
	#((DT_rows (Snd (tc tl�0)) � {r|c dominates DTR_row r})
			� {r|c dominates DTR_where r}) = 1�
	THEN1 asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T[1,2]
	(MAP_EVERY(strip_asm_tac o rewrite_rule[length_1_thm])));
a(asm_rewrite_tac[]);
a(lemma_tac�HideDerTableRow c x = HideDerTableRow c x'�);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 5 ante_tac THEN asm_rewrite_tac[get_spec�Map�]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN
	rewrite_tac[MkDerTableRow_lemma, let_def, get_spec�HideDerTableRow�]);
a(strip_tac);
a(LEMMA_T�
	#(Map (� (c', i)� if c dominates c'
		then (c', i)
		else (c', ValuedItemItem (MkValuedItem sterling dummyVal)))
               (DTR_cols x)) =
	#(Map (� (c', i)� if c dominates c'
		then (c', i)
		else (c', ValuedItemItem (MkValuedItem sterling dummyVal)))
               (DTR_cols x'))�
	(strip_asm_tac o rewrite_rule[length_map_thm])
	THEN1 asm_rewrite_tac[]);
a(asm_rewrite_tac[]);
a(cases_tac�# (DTR_cols x') = 1� THEN asm_rewrite_tac[]);
a(lemma_tac�# (DTR_cols x) = 1� THEN1 asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T[1,2]
	(MAP_EVERY(strip_asm_tac o rewrite_rule[length_1_thm])));
a(DROP_NTH_ASM_T 4 ante_tac THEN asm_rewrite_tac[get_spec�Map�]);
a(cases_tac�c dominates Fst x''� THEN asm_rewrite_tac[]);
(* *** Goal "2.1" *** *)
a(cases_tac�c dominates Fst x'''� THEN asm_rewrite_tac[]
	THEN REPEAT strip_tac THEN asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(cases_tac�c dominates Fst x'''� THEN asm_rewrite_tac[]);
a(PC_T1 "prop_eq_pair" prove_tac[]);
val SingleValue_OK�c_lemma = save_pop_thm"SingleValue_OK�c_lemma";
set_goal([], ��c i� JoinedRowExistence i � OK_VC�c c�);
a(rewrite_tac(map get_spec[�OK_VC�c�, �JoinedRowExistence�])
	THEN REPEAT strip_tac);
val JoinedRowExistence_OK�c_lemma = save_pop_thm"JoinedRowExistence_OK�c_lemma";