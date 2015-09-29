force_delete_theory"topology" handle Fail _ => ();
open_theory"bin_rel";
set_merge_pcs["basic_hol1", "'sets_alg"];
new_theory"topology";
new_parent"fincomb";
�HOLCONST
� Topology : 'a SET SET SET
�������
� 	Topology =
�	{� | (�V� V � � � � V � �) � (�A B�A � � � B � � � A � B � �)}
�
�HOLCONST
� Space�T : 'a SET SET � 'a SET
�������
� �Է Space�T � = � �
�
declare_postfix(400, "Closed");
�HOLCONST
� $Closed : 'a SET SET � 'a SET SET
�������
� �Է � Closed = {A | �B�B � � � A = Space�T � \ B}
�
declare_infix(280, "�T");
�HOLCONST
� $�T : 'a SET � 'a SET SET � 'a SET SET
�������
� �X Է 	(X �T �)
� =	{A | �B� B � � � A = B � X}
�
declare_infix(290, "��T");
�HOLCONST
� $��T : 'a SET SET � 'b SET SET � ('a � 'b) SET SET
�������
� �� Է	(� ��T �) = {C | � x y� (x, y) � C
�		� �A B� A � � � B � � � x � A � y � B � (A � B) � C}
�
�HOLCONST
� $1�T : ONE SET SET
�������
� 1�T = {{}; {One}}
�
�HOLCONST
� $��T : � � 'a SET SET � 'a LIST SET SET 
�������
� �� n� 	��T 0 � = { {}; {[]} }
� �		(��T (n+1) �) = {C | �[] � C � � x v� Cons x v � C �
�				�A B� A � � � B � ��T n � � x � A � v � B �
�					�y w�y � A � w � B � Cons y w � C}
�
declare_postfix(400, "Continuous");
�HOLCONST
� $Continuous : ('a SET SET � 'b SET SET) � ('a � 'b) SET
�������
� �� Է	(�, �) Continuous =
�	{f
�	|	(�x� x � Space�T � � f x � Space�T �)
�	�	(�A� A � � � {x | x � Space�T � � f x � A} � �)}
�
�HOLCONST
� Hausdorff : 'a SET SET SET
�������
� 	Hausdorff =
�	{� | �x y� x � Space�T � � y � Space�T � � �x = y
�	�	�A B�A � � � B � � � x � A � y � B � A � B = {}}
�
declare_postfix(400, "Compact");
�HOLCONST
� $Compact : 'a SET SET � 'a SET SET
�������
� �Է � Compact =
�	{A
�	 |	A � Space�T �
�	�	�V� V � � � A � � V � �W� W � V � W � Finite � A � � W}
�
declare_postfix(400, "Connected");
�HOLCONST
� $Connected : 'a SET SET � 'a SET SET
�������
� �Է � Connected =
�	{A | A � Space�T �
�	� �B C� B � � � C � � � A � B � C � A � B � C = {} � (A � B � A � C)}
�
declare_postfix(400, "Homeomorphism");
�HOLCONST
� $Homeomorphism : ('a SET SET � 'b SET SET) � ('a � 'b) SET
�������
� �� Է	(�, �) Homeomorphism =
�	{f
�	|	f � (�, �) Continuous
�	�	�g� 	g � (�, �) Continuous
�		�	(�x�x � Space�T � � g(f x) = x)
�		�	(�y�y � Space�T � � f(g y) = y)}
�
declare_infix(400, "Interior");
declare_infix(400, "Boundary");
declare_infix(400, "Closure");
�HOLCONST
� $Interior $Boundary $Closure: 'a SET SET � 'a SET � 'a SET
�������
� �� A�
�	� Interior A = {x | �B� B � � � x � B � B � A}
� � 	� Boundary A =
�	{x | x � Space�T � � �B� B � � � x � B � �B � A = {} � �B \ A = {}}
� � 	� Closure A = �{B | B � � Closed � A � Space�T � � B}
�
declare_postfix(400, "CoveringProjection");
�HOLCONST
� $CoveringProjection : ('a SET SET � 'b SET SET) � ('a � 'b) SET
�������
� �� Է	(�, �) CoveringProjection =
�	{p
�	|	p � (�, �) Continuous
�	�	�y� 	y � Space�T �
�		�	�C�	y � C � C � � �
�			�U�	U � �
�			�	(�x� x � Space�T � � p x � C
�					� �A� x � A � A � U)
�			�	(�A B� A � U � B � U � �A � B = {} � A = B)
�			�	(�A� A � U � p � (A �T �, C �T �) Homeomorphism)}
�
�HOLCONST
� Space�K : ('a SET � �) SET � 'a SET
�������
� �C� Space�K C = �{c | �m� (c, m) � C}
�
declare_infix(400, "Skeleton");
�HOLCONST
� $Skeleton : � � ('a SET � �) SET � 'a SET
�������
� �n C� n Skeleton C = �{c | �m�m � n � (c, m) � C}
�
�HOLCONST
� Protocomplex : 'a SET SET � ('a SET � �) SET SET
�������
� �C Է	C � Protocomplex � �
�	(�c m� (c, m) � C � c � � Closed)
� �	(�x� x � Space�K C �
�		��1 (c, m)� (c, m) � C � x � ((m Skeleton C) �T �) Interior c)
� �	(�A� A � Space�K C � (�c m� (c, m) � C � A � c � � Closed) � A � � Closed)
� �	(�c m� (c, m) � C � {(d, n) | (d, n) � C � n < m � �c � d = {}} � Finite)
�
force_delete_theory"metric_spaces" handle Fail _ => ();
open_theory"topology";
new_theory"metric_spaces";
new_parent"analysis";
new_parent"trees";
set_merge_pcs["basic_hol1", "'sets_alg", "'�", "'�"];
�HOLCONST
� Metric : ('a � 'a � �) SET
�������
� 	Metric =
�	{	D
�	|	(�x y� � 0 � D(x, y))
�	�	(�x y� D(x, y) = � 0 � x = y)
�	�	(�x y� D(x, y) = D (y, x))
�	�	(�x y z� D(x, z) � D (x, y) + D(y, z))}
�
declare_postfix(400, "MetricTopology");
�HOLCONST
� $MetricTopology : ('a � 'a � �) � 'a SET SET
�������
�  �D� D MetricTopology = {A | �x�x � A � �e� � 0 < e � (�y�D(x, y) < e � y � A)}
�
�HOLCONST
� ListMetric : ('a � 'a � �) � ('a LIST � 'a LIST) � �
�������
� �D x v y w�
�		ListMetric D ([], []) = 0.
� �		ListMetric D (Cons x v, []) = 1. + D(x, Arbitrary) + ListMetric D (v, [])
� �		ListMetric D ([], Cons y w) = 1. + D(Arbitrary, y) + ListMetric D ([], w)
� �		ListMetric D (Cons x v, Cons y w) = D(x, y) + ListMetric D (v, w)
�
force_delete_theory"topology_�" handle Fail _ => ();
open_theory"metric_spaces";
new_theory"topology_�";
set_merge_pcs["basic_hol1", "'sets_alg", "'�", "'�"];
declare_alias("O�R", �Open�R�);
�HOLCONST
� D�R : � � � � �
�������
�  �x y� D�R(x, y) = Abs(y - x)
�
�HOLCONST
� D�R2 : (� � �) � (� � �) � �
�������
�  �x1 y1 x2 y2� D�R2 ((x1, y1), (x2, y2)) = Abs(x2 - x1) + Abs(y2 - y1)
�
declare_postfix(400, "Space");

�HOLCONST
� $Space : � � � LIST SET SET
�������
�  �n� n Space = {v | #v = n} �T ListMetric D�R MetricTopology
�
declare_postfix(400, "Cube");

�HOLCONST
� $Cube : � � � LIST SET SET
�������
�  �n� n Cube = {v | Elems v � ClosedInterval 0. 1.} �T n Space
�
declare_postfix(400, "OpenCube");

�HOLCONST
� $OpenCube : � � � LIST SET SET
�������
�  �n� n OpenCube = {v | Elems v � OpenInterval 0. 1.} �T n Space
�
declare_postfix(400, "Sphere");

�HOLCONST
� $Sphere : � � � LIST SET SET
�������
�  �n� n Sphere = {v | �Elems v � {0.; 1.} = {}} �T n Cube
�
force_delete_theory"homotopy" handle Fail _ => ();
open_theory"topology_�";
new_theory"homotopy";
set_merge_pcs["basic_hol1", "'sets_alg", "'�", "'�"];
�HOLCONST
� Paths : 'a SET SET � (� � 'a) SET
�������
� �Է	Paths � =
�	{	f
�	|	f � (O�R, �) Continuous
�	�	(�x� x � 0. � f x = f 0.)
�	�	(�x� 1. � x � f x = f 1.)}
�
declare_postfix(400, "PathConnected");
�HOLCONST
� $PathConnected : 'a SET SET � 'a SET SET
�������
� �Է � PathConnected =
�	{	A
�	|	A � Space�T �
�	�	�x y� x � A � y � A
�	�	�f� 	f � Paths �
�		�	(� t� f t � A)
�		�	f (� 0) = x
�		�	f (� 1) = y}
�
�HOLCONST
� LocallyPathConnected : 'a SET SET SET
�������
� �Է	� � LocallyPathConnected
� �	�x A�x � A � A � � � �B�B � � � x � B � B � A � B � � PathConnected
�
declare_postfix(400, "Homotopy");
�HOLCONST
� $Homotopy : 'a SET SET � 'a SET � 'b SET SET � ('a � � � 'b) SET
�������
� �� X Է (�, X, �) Homotopy =
�	{ f | f � ((� ��T O�R), �) Continuous � �x s t�x � X � f(x, s) = f(x, t)}
�
declare_postfix(400, "HomotopyClass");
�HOLCONST
� $HomotopyClass : 'a SET SET � 'a SET � 'b SET SET � ('a � 'b) � ('a � 'b) SET
�������
� �� X � f� ((�, X, �) HomotopyClass) f =
�	{g
�	| �H� H � (�, X, �) Homotopy
�	� (�x� H(x, � 0) = f x) � (�x� H(x, � 1) = g x)}
�
declare_infix(300, "+�P");
�HOLCONST
� $+�P : (� � 'a) � (� � 'a) � (� � 'a)
�������
� �f g� f +�P g = (�t�if t � 1/2 then f (� 2*t) else g (� 2*(t - 1/2)))
�
�HOLCONST
� 0�P : 'a � (� � 'a)
�������
� �x� 0�P x = (�t� x)
�
�HOLCONST
� $~�P : (� � 'a) � (� � 'a)
�������
� �f� ~�P f = (�t� f(� 1 -  t))
�
�HOLCONST
� HomotopyLiftingProperty :
�	('a SET SET � ('b � 'c ) � 'b SET SET � 'c SET SET) SET
�������
� �� � � p�
�	(�, (p, �, �)) � HomotopyLiftingProperty
� �		� � Topology
�	�	� � Topology
�	�	� � Topology
�	�	p � (�, �) Continuous
�	�	(�f h�
�			f � (�, �) Continuous
�		�	h � (� ��T O�R, �) Continuous
�		�	(� x� x � Space�T � � h (x, 0.) = p (f x))
�		�	(�L�
�				L � (� ��T O�R, �) Continuous
�			� 	(� x� x � Space�T � � L (x, 0.) = f x)
�			�	(� x s�
�					x � Space�T �
�				�	s � ClosedInterval 0. 1.
�				�	p (L (x, s)) = h (x, s))))
�
open_theory"topology";
set_merge_pcs["basic_hol1", "'sets_alg"];

val enum_set_�_thm = save_thm ( "enum_set_�_thm", (
set_goal([], �
	� A B C�  (Insert A B) � C � A � C � B � C
�);
a(PC_T1 "sets_ext1" rewrite_tac[insert_def]);
a(prove_tac[]);
pop_thm()
));


val �_enum_set_clauses = save_thm ( "�_enum_set_clauses", (
set_goal([], �
	�{} = {}
�	� A B�  �(Insert A B) = A � (�B)
�);
a(REPEAT strip_tac THEN1 PC_T1 "sets_ext1" prove_tac[]);
a(PC_T "sets_ext1" strip_tac);
a(rewrite_tac[�_def, insert_def, �_def]);
a(prove_tac[]);
pop_thm()
));


val �_enum_set_clauses = save_thm ( "�_enum_set_clauses", (
set_goal([], �
	�{} = Universe
�	� A B�  �(Insert A B) = A � (�B)
�);
a(REPEAT strip_tac THEN1 PC_T1 "sets_ext1" prove_tac[]);
a(PC_T "sets_ext1" strip_tac);
a(rewrite_tac[�_def, insert_def, �_def]);
a(prove_tac[]);
pop_thm()
));
val enum_set_clauses = list_�_intro
	[enum_set_�_thm,  �_enum_set_clauses, �_enum_set_clauses];


val �_finite_thm = save_thm ( "�_finite_thm", (
set_goal([], ��V�
	 V  � Finite � V � Finite � �V � Finite
�);
a(REPEAT strip_tac);
a(lemma_tac��W� W � Finite � W � V � �W � Finite�);
(* *** Goal "1" *** *)
a(REPEAT strip_tac THEN POP_ASM_T ante_tac);
a(finite_induction_tac�W�);
(* *** Goal "1.1" *** *)
a(rewrite_tac[enum_set_clauses, empty_finite_thm]);
(* *** Goal "1.2" *** *)
a(LEMMA_T��{x} � W � V� rewrite_thm_tac);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "1.3" *** *)
a(REPEAT strip_tac THEN
	rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��a v��(a � v) = �a � �v�,
		enum_set_clauses]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��x a b c�{x} � a � b � b � c � x � c�]);
a(asm_rewrite_tac[�_finite_thm]);
(* *** Goal "2" *** *)
a(POP_ASM_T bc_thm_tac THEN REPEAT strip_tac);
pop_thm()
));


val finite_image_thm = save_thm ( "finite_image_thm", (
set_goal([], �� f : 'a � 'b; A : 'a SET�
	 A � Finite � {y | �x�x � A � y = f x} � Finite
�);
a(REPEAT strip_tac);
a(finite_induction_tac �A� THEN1 rewrite_tac[]);
(* *** Goal "1" *** *)
a(LEMMA_T�{y:'b|F} = {}� (fn th => rewrite_tac[th, empty_finite_thm])
	THEN1 PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2" *** *)
a(LEMMA_T �{y|� x'� x' � {x} � A � y = f x'} = {f x} � {y|� x'� x' � A � y = f x'}�
	rewrite_thm_tac
	THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(bc_thm_tac singleton_�_finite_thm THEN REPEAT strip_tac);
pop_thm()
));


val �_size_thm = save_thm ( "�_size_thm", (
set_goal([], ��a b� a � Finite � b � a � #b � #a�);
a(REPEAT strip_tac);
a(POP_ASM_T ante_tac THEN intro_�_tac(�b�, �b�));
a(finite_induction_tac�a� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LEMMA_T �b = {}� rewrite_thm_tac);
a(PC_T1"sets_ext1" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(cases_tac�x � b�);
(* *** Goal "2.1" *** *)
a(PC_T1 "predicates" lemma_tac�b \ {x} � a � �x � b \ {x}�
	THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(all_fc_tac[�_finite_thm]);
a(LEMMA_T�b = {x} � (b \ {x})� once_rewrite_thm_tac
	THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(ALL_FC_T rewrite_tac[size_singleton_�_thm]);
a(all_asm_fc_tac[]);
(* *** Goal "2.2" *** *)
a(lemma_tac�b � a� THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2.2.1" *** *)
a(asm_fc_tac[] THEN all_var_elim_asm_tac);
(* *** Goal "2.2.2" *** *)
a(ALL_FC_T rewrite_tac[size_singleton_�_thm]);
a(asm_fc_tac[] THEN PC_T1 "lin_arith" asm_prove_tac[]);
pop_thm()
));


val �_size_thm1 = save_thm ( "�_size_thm1", (
set_goal([],��a b� a � Finite � b � a � �b = a � #b < #a�);
a(REPEAT strip_tac);
a(lemma_tac�a \ b � a � �a \ b = {}� THEN1
	PC_T1 "sets_ext1" asm_prove_tac[]);
a(REPEAT strip_tac THEN all_fc_tac[�_finite_thm]);
a(LEMMA_T �# (b � (a \ b)) + # (b � (a \ b)) = # b + # (a \ b)� ante_tac THEN1
	(bc_thm_tac size_�_thm THEN REPEAT strip_tac));
a(LEMMA_T �b � (a \ b) = a � b � (a \ b) = {}� rewrite_thm_tac THEN1
	PC_T1 "sets_ext1" asm_prove_tac[]);
a(rewrite_tac[size_empty_thm]);
a(STRIP_T rewrite_thm_tac);
a(lemma_tac �� #(a \ b) = 0� THEN_LIST
	[id_tac, PC_T1 "lin_arith" asm_prove_tac[]]);
a(ALL_FC_T1 fc_�_canon asm_rewrite_tac[size_0_thm]);
pop_thm()
));



val finite_�_well_founded_thm = save_thm ( "finite_�_well_founded_thm", (
set_goal([],��p a�
	a � Finite
�	p a
�	�b�
	b � a
�	p b
�	�c�c � b � p c � c = b�);
a(REPEAT strip_tac);
a(PC_T1 "predicates" lemma_tac �#a � {n | �t� t � a � p t � n = #t}�);
(* *** Goal "1" *** *)
a(REPEAT strip_tac);
a(�_tac�a� THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(all_fc_tac[min_�_thm]);
a(�_tac�t� THEN REPEAT strip_tac);
a(contr_tac THEN all_fc_tac[�_finite_thm]);
a(all_fc_tac[�_size_thm1]);
a(DROP_NTH_ASM_T 9 discard_tac);
a(PC_T1 "predicates" lemma_tac �#c � {n | �t� t � a � p t � n = #t}�);
(* *** Goal "2.1" *** *)
a(REPEAT strip_tac);
a(�_tac�c� THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2.2" *** *)
a(all_fc_tac[min_�_thm]);
a(PC_T1 "lin_arith" asm_prove_tac[]);
pop_thm()
));

val topology_def = get_spec�$Topology�;
val space_t_def = get_spec�Space�T�;
val closed_def = get_spec�$Closed�;
val continuous_def = get_spec�$Continuous�;
val connected_def = get_spec�$Connected�;
val compact_def = get_spec�$Compact�;
val subspace_topology_def = get_spec�$�T�;
val product_topology_def = get_spec�$��T�;
val unit_topology_def = get_spec�1�T�;
val power_topology_def = get_spec���T�;
val hausdorff_def = get_spec�Hausdorff�;
val homeomorphism_def = get_spec�$Homeomorphism�;
local
	val thm1 = all_�_elim (get_spec�$Interior�);
	val [i_def, b_def, c_def] = strip_�_rule thm1;
in
	val interior_def = all_�_intro i_def;
	val boundary_def = all_�_intro b_def;
	val closure_def = all_�_intro c_def;
end;
val covering_projection_def = get_spec�$CoveringProjection�;
val space_k_def = get_spec�Space�K�;
val skeleton_def = get_spec�$Skeleton�;
val protocomplex_def = get_spec�Protocomplex�;

val empty_open_thm = save_thm ( "empty_open_thm", (
set_goal([], ��� : 'a SET SET � � � Topology � {} � Ԯ);
a(rewrite_tac[topology_def] THEN REPEAT strip_tac);
a(SPEC_NTH_ASM_T 2 �{}: 'a SET SET� ante_tac);
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��{} = {}�]);
pop_thm()
));


val space_t_open_thm = save_thm ( "space_t_open_thm", (
set_goal([], ��� : 'a SET SET � � � Topology � Space�T � � Ԯ);
a(rewrite_tac[topology_def, space_t_def] THEN REPEAT strip_tac);
a(SPEC_NTH_ASM_T 2 ��: 'a SET SET� ante_tac);
a(rewrite_tac[]);
pop_thm()
));


val empty_closed_thm = save_thm ( "empty_closed_thm", (
set_goal([], ��� : 'a SET SET � � � Topology � {} � � Closed�);
a(rewrite_tac[closed_def] THEN REPEAT strip_tac);
a(all_fc_tac[space_t_open_thm]);
a(�_tac�Space�T Ԯ THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val space_t_closed_thm = save_thm ( "space_t_closed_thm", (
set_goal([], ��� : 'a SET SET � � � Topology � Space�T � � � Closed�);
a(rewrite_tac[closed_def] THEN REPEAT strip_tac);
a(all_fc_tac[empty_open_thm]);
a(�_tac�{} : 'a SET� THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val open_open_neighbourhood_thm = save_thm ( "open_open_neighbourhood_thm", (
set_goal([], ��� A �
	� � Topology �
	(A � � � �x�x � A � �B� B � � � x � B � B � A)�);
a(rewrite_tac[topology_def, space_t_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(�_tac�A� THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�A = �{B | B � � � B � A}�);
(* *** Goal "2.1" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN
	contr_tac THEN all_asm_fc_tac[] THEN all_asm_fc_tac[]);
(* *** Goal "2.2" *** *)
a(POP_ASM_T once_rewrite_thm_tac THEN DROP_NTH_ASM_T 3 bc_thm_tac);
a(PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val closed_open_neighbourhood_thm = save_thm ( "closed_open_neighbourhood_thm", (
set_goal([], ��� A �
	� � Topology �
	(	A � � Closed
	� 	A � Space�T �
	�	�x�x � Space�T �  � �x � A � �B� B � � � x � B � B � A = {})�);
a(rewrite_tac[closed_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�x � B� THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(all_fc_tac[open_open_neighbourhood_thm]);
a(�_tac�B'� THEN PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(FC_T1 fc_�_canon once_rewrite_tac [open_open_neighbourhood_thm]);
a(�_tac�Space�T � \ A� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "3.1" *** *)
a(all_asm_fc_tac[]);
a(�_tac�B� THEN PC_T1 "sets_ext1" asm_rewrite_tac[]);
a(rewrite_tac[space_t_def] THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "3.1.1" *** *)
a(contr_tac THEN all_asm_fc_tac[]);
(* *** Goal "3.1.2" *** *)
a(REPEAT_N 2 (POP_ASM_T ante_tac) THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "3.2" *** *)
a(LIST_GET_NTH_ASM_T [1, 3] (MAP_EVERY ante_tac)  THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val �_space_t_thm = save_thm ( "�_space_t_thm", (
set_goal([], ��� x A �
	x � A � A � � � x � Space�T �
�);
a(rewrite_tac[space_t_def] THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));



val �_closed_�_space_t_thm = save_thm ( "�_closed_�_space_t_thm", (
set_goal([], ��� x A �
	x � A � A � � Closed � x � Space�T �
�);
a(rewrite_tac[space_t_def, closed_def] THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(all_asm_fc_tac[] THEN contr_tac THEN all_asm_fc_tac[]);
pop_thm()
));


val closed_open_complement_thm = save_thm ( "closed_open_complement_thm", (
set_goal([], ��� A �
	� � Topology �
	(	A � � Closed
	� 	A � Space�T �
	�	Space�T � \ A � �)�);
a(rewrite_tac[closed_def] THEN REPEAT strip_tac THEN_TRY all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�B � Space�T Ԯ THEN1
	(PC_T1 "sets_ext1" REPEAT strip_tac THEN all_fc_tac[�_space_t_thm]));
a(LEMMA_T �Space�T � \ (Space�T � \ B) = B� asm_rewrite_thm_tac
	THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(�_tac�Space�T � \ A� THEN PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val �_open_thm = save_thm ( "�_open_thm", (
set_goal([], ��� A B �
	� � Topology � A � � � B � � � A � B � �
�);
a(rewrite_tac[topology_def] THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(SPEC_NTH_ASM_T 4 �{A; B}� (strip_asm_tac o rewrite_rule[enum_set_clauses]));
pop_thm()
));


val �_open_thm = save_thm ( "�_open_thm", (
set_goal([], �� � V�
	� � Topology
�	V � �
�	�V � Ԯ);
a(rewrite_tac[topology_def] THEN REPEAT strip_tac
	THEN all_asm_fc_tac[]);
pop_thm()
));


val �_open_thm = save_thm ( "�_open_thm", (
set_goal([], ��� A B �
	� � Topology � A � � � B � � � A � B � �
�);
a(rewrite_tac[topology_def] THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val �_open_thm = save_thm ( "�_open_thm", (
set_goal([], �� � V�
	� � Topology
�	�V = {}
�	V � Finite
�	V � �
�	�V � Ԯ);
a(REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [1, 3, 4] (MAP_EVERY ante_tac));
a(intro_�_tac1 �Ԯ THEN1 finite_induction_tac�V�
	THEN REPEAT strip_tac);
a(POP_ASM_T (strip_asm_tac o rewrite_rule[
	pc_rule1"sets_ext1" prove_rule[]
		�(�x a� {x} � a � x � a)
	�	�a b c�a � b � c � a � c � b � c�]));
a(cases_tac�V = {}� THEN1 all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(LEMMA_T��x� �({x} � {}) = x� asm_rewrite_thm_tac);
a(DROP_ASMS_T discard_tac);
a(rewrite_tac[] THEN PC_T1 "sets_ext1" rewrite_tac[]
	THEN prove_tac[]);
a(POP_ASM_T bc_thm_tac THEN rewrite_tac[]);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [7] all_fc_tac);
a(lemma_tac�x � �V � Ԯ THEN1 all_fc_tac[�_open_thm]);
a(LEMMA_T��x b� �({x} � b) = x � �b� asm_rewrite_thm_tac);
a(DROP_ASMS_T discard_tac);
a(PC_T1 "sets_ext1" rewrite_tac[]
	THEN prove_tac[]);
a(POP_ASM_T bc_thm_tac THEN rewrite_tac[]);
pop_thm()
));



val �_closed_thm = save_thm ( "�_closed_thm", (
set_goal([], ��� A B �
	� � Topology � A � � Closed � B � � Closed � A � B � � Closed
�);
a(REPEAT strip_tac THEN REPEAT_N 2 (POP_ASM_T ante_tac));
a(ALL_FC_T1 fc_�_canon rewrite_tac[closed_open_complement_thm]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��a b s�a � s � b � s � a � b � s�]);
(* *** Goal "2" *** *)
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��s a b� s \ a � b = (s \ a) � (s \ b)�]);
a(all_fc_tac [�_open_thm]);
pop_thm()
));


val �_closed_thm = save_thm ( "�_closed_thm", (
set_goal([], �� � V�
	� � Topology
�	�V = {}
�	V � � Closed
�	�V � � Closed
�);
a(REPEAT strip_tac THEN POP_ASM_T (ante_tac o pc_rule1"sets_ext1"rewrite_rule[]));
a(PC_T1 "sets_ext1" POP_ASM_T strip_asm_tac);
a(ALL_FC_T1 fc_�_canon rewrite_tac[closed_open_complement_thm]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(LEMMA_T��t v� t \ �v  = �{a|�b�b � v � a = t \ b}� rewrite_thm_tac);
(* *** Goal "2.1" *** *)
a(DROP_ASMS_T discard_tac);
a(PC_T "sets_ext1" contr_tac THEN_TRY all_asm_fc_tac[]);
a(spec_nth_asm_tac 1 �t \ s�);
a(spec_nth_asm_tac 1 �s�);
(* *** Goal "2.2" *** *)
a(bc_thm_tac �_open_thm THEN REPEAT strip_tac);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac THEN all_var_elim_asm_tac1);
a(all_asm_fc_tac[]);
pop_thm()
));


val �_closed_thm = save_thm ( "�_closed_thm", (
set_goal([], ��� A B �
	� � Topology � A � � Closed � B � � Closed � A � B � � Closed
�);
a(REPEAT strip_tac THEN REPEAT_N 2 (POP_ASM_T ante_tac));
a(ALL_FC_T1 fc_�_canon rewrite_tac[closed_open_complement_thm]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��a b s�a � s � b � s � a � b � s�]);
(* *** Goal "2" *** *)
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��s a b� s \ (a � b) = (s \ a) � (s \ b)�]);
a(all_fc_tac [�_open_thm]);
pop_thm()
));

val �_closed_thm = save_thm ( "�_closed_thm", (
set_goal([], �� � V�
	� � Topology
�	�V = {}
�	V � Finite
�	V � � Closed
�	�V � � Closed�);
a(REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [1, 3, 4] (MAP_EVERY ante_tac));
a(intro_�_tac1 �Ԯ THEN1 finite_induction_tac�V�
	THEN REPEAT strip_tac);
a(POP_ASM_T (strip_asm_tac o rewrite_rule[
	pc_rule1"sets_ext1" prove_rule[]
		�(�x a� {x} � a � x � a)
	�	�a b c�a � b � c � a � c � b � c�]));
a(cases_tac�V = {}� THEN1 all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(LEMMA_T��x� �({x} � {}) = x� asm_rewrite_thm_tac);
a(DROP_ASMS_T discard_tac);
a(rewrite_tac[] THEN PC_T1 "sets_ext1" rewrite_tac[]
	THEN prove_tac[]);
a(�_tac�x� THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [7] all_fc_tac);
a(lemma_tac�x � �V � � Closed� THEN1 all_fc_tac[�_closed_thm]);
a(LEMMA_T��x b� �({x} � b) = x � �b� asm_rewrite_thm_tac);
a(DROP_ASMS_T discard_tac);
a(PC_T1 "sets_ext1" rewrite_tac[]
	THEN prove_tac[]);
a(�_tac�x� THEN asm_rewrite_tac[]);
pop_thm()
));





val finite_�_open_thm = save_thm ( "finite_�_open_thm", (
set_goal([], ��� V�
	� � Topology � V � � � �V = {} � V � Finite
�	�V � Ԯ);
a(rewrite_tac[topology_def] THEN REPEAT strip_tac);
a(POP_ASM_T (fn th => POP_ASM_T ante_tac THEN POP_ASM_T ante_tac THEN asm_tac th));
a(finite_induction_tac�V�);
(* *** Goal "1" *** *)
a(REPEAT strip_tac);
(* *** Goal "2" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(all_var_elim_asm_tac1 THEN rewrite_tac[]);
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��x y�{x} � y � x � y�]);
a(LEMMA_T��{x} = x� (fn th => rewrite_tac [th] THEN taut_tac));
(* *** Goal "3" *** *)
a(PC_T"sets_ext1" strip_tac THEN rewrite_tac[�_def] THEN prove_tac[]);
(* *** Goal "4" *** *)
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��x y z�{x} � z � y � x � y � z � y�]);
a(LEMMA_T��({x} � V) = x � �V� rewrite_thm_tac);
(* *** Goal "4.1" *** *)
a(PC_T"sets_ext1" strip_tac THEN rewrite_tac[�_def, �_def, �_def] THEN prove_tac[]);
(* *** Goal "4.2" *** *)
a(REPEAT strip_tac THEN all_asm_fc_tac[]);
pop_thm()
));


val subspace_topology_thm = save_thm ( "subspace_topology_thm", (
set_goal([], ��� X�
	� � Topology
�	(X �T �) � Topology�);
a(rewrite_tac[topology_def, subspace_topology_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_asm_ante_tac THEN1 PC_T1 "sets_ext1" REPEAT strip_tac);
a(�_tac ��{C| C � � � C � X � V}�  THEN REPEAT strip_tac THEN all_asm_fc_tac[]);
(* *** Goal "1.1" *** *)
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "1.2" *** *)
a(PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "1.2.1" *** *)
a(all_asm_fc_tac[] THEN all_var_elim_asm_tac1);
a(�_tac �B�  THEN REPEAT strip_tac);
(* *** Goal "1.2.2" *** *)
a(all_asm_fc_tac[] THEN all_var_elim_asm_tac1);
(* *** Goal "1.2.3" *** *)
a(�_tac �s � X�  THEN PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(all_var_elim_asm_tac1);
a(�_tac �B' � B''�   THEN PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val subspace_topology_space_t_thm = save_thm ( "subspace_topology_space_t_thm", (
set_goal([], ��� A�
	� � Topology
�	Space�T (A �T �) = A � Space�T Ԯ);
a(rewrite_tac[topology_def, space_t_def, subspace_topology_def] THEN
	PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(�_tac �B�  THEN REPEAT strip_tac THEN all_asm_fc_tac[]);
(* *** Goal "3" *** *)
a(�_tac �s � A�  THEN REPEAT strip_tac THEN all_asm_fc_tac[]);
a(�_tac �s �  THEN REPEAT strip_tac);
pop_thm()
));



val subspace_topology_space_t_thm1 = save_thm ( "subspace_topology_space_t_thm1", (
set_goal([], ��� A�
	� � Topology
�	A � Space�T �
�	Space�T (A �T �) = A�);
a(REPEAT strip_tac THEN ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��a b�a � b = a � b = a�]);
pop_thm()
));



val universe_subspace_topology_thm = save_thm ( "universe_subspace_topology_thm", (
set_goal([], ��Է (Universe �T �) = Ԯ);
a(REPEAT strip_tac THEN rewrite_tac[subspace_topology_def]);
a(rewrite_tac[pc_rule1 "sets_ext1" prove_rule[]
	��t� {a | �b� b � t � a = b} = t�]);
pop_thm()
));


val open_�_space_t_thm = save_thm ( "open_�_space_t_thm", (
set_goal([], ��� A�
	� � Topology
�	A � �
�	A � Space�T Ԯ);
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN all_fc_tac[�_space_t_thm]);
pop_thm()
));


val subspace_topology_space_t_thm2 = save_thm ( "subspace_topology_space_t_thm2", (
set_goal([], ��� A�
	� � Topology
�	A � �
�	Space�T (A �T �) = A�);
a(REPEAT strip_tac THEN bc_tac[
	subspace_topology_space_t_thm1,
	open_�_space_t_thm] THEN REPEAT strip_tac);
pop_thm()
));



val subspace_topology_space_t_thm3 = save_thm ( "subspace_topology_space_t_thm3", (
set_goal([], ��� A�
	� � Topology
�	A � � Closed
�	Space�T (A �T �) = A�);
a(REPEAT strip_tac THEN bc_thm_tac subspace_topology_space_t_thm1);
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN all_fc_tac[�_closed_�_space_t_thm]);
pop_thm()
));


val subspace_topology_closed_thm = save_thm ( "subspace_topology_closed_thm", (
set_goal([], ��X Է
	� � Topology
�	(X �T �) Closed = {A | �B� B � � Closed � A = B � X}
�);
a(REPEAT strip_tac THEN PC_T "sets_ext1" strip_tac);
a(lemma_tac�X �T � � Topology� THEN1 ALL_FC_T rewrite_tac [subspace_topology_thm]);
a(ALL_FC_T1 fc_�_canon rewrite_tac[closed_open_complement_thm,
	subspace_topology_space_t_thm]
	THEN rewrite_tac[subspace_topology_def]
	THEN REPEAT strip_tac
	THEN_TRY all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(�_tac� Space�T � \ B �);
a(lemma_tac�B � Space�T Ԯ THEN1
	(PC_T1 "sets_ext1" REPEAT strip_tac THEN all_fc_tac[�_space_t_thm]));
a(ALL_FC_T asm_rewrite_tac[pc_rule1"sets_ext1"prove_rule[]
	��b s�b � s � s \ b � s � s \ (s \ b) = b�]);
a(asm_rewrite_tac[pc_rule1"sets_ext1"prove_rule[]
	��b s x� (s \ b) � x = (x � s) \ (b � x)�]);
a(lemma_tac�B � X � X � Space�T Ԯ THEN1
	(POP_ASM_T ante_tac THEN PC_T1 "sets_ext1" prove_tac[]));
a(all_fc_tac[pc_rule1"sets_ext1"prove_rule[]
	��a b c� a � c � b � c � c \ a = b � a = c \ b�]);
(* *** Goal "2" *** *)
a(ALL_FC_T rewrite_tac[pc_rule1"sets_ext1"prove_rule[]
	��b s x� b � s � b � x � x � s�]);
(* *** Goal "3" *** *)
a(�_tac� Space�T � \ B � THEN REPEAT strip_tac);
a(rewrite_tac[pc_rule1"sets_ext1"prove_rule[]
	��b s x� (s \ b) � x = (x � s) \ (b � x)�]);
pop_thm()
));


val trivial_subspace_topology_thm = save_thm ( "trivial_subspace_topology_thm", (
set_goal([], ��Է
	� � Topology
�	(Space�T � �T �)  = Ԯ);
a(rewrite_tac[subspace_topology_def] THEN  REPEAT strip_tac);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_var_elim_asm_tac1 THEN all_fc_tac[space_t_open_thm]);
a(all_fc_tac[�_open_thm]);
(* *** Goal "2" *** *)
a(�_tac�x� THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
a(all_fc_tac[�_space_t_thm]);
pop_thm()
));


val �_subspace_topology_thm = save_thm ( "�_subspace_topology_thm", (
set_goal([], ��� A B�
	A � B
�	(A �T (B �T �))  = (A �T �)�);
a(rewrite_tac[subspace_topology_def] THEN REPEAT strip_tac);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac
	THEN all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(�_tac�B''� THEN asm_rewrite_tac[]);
a(POP_ASM_T discard_tac THEN PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(�_tac�B' � B� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(�_tac�B'� THEN asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(POP_ASM_T discard_tac THEN PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val product_topology_thm = save_thm ( "product_topology_thm", (
set_goal([], ��� : 'a SET SET; � : 'b SET SET�
	� � Topology
�	� � Topology
�	(� ��T �) � Topology�);
a(rewrite_tac[topology_def, product_topology_def]
	THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LIST_DROP_NTH_ASM_T  [3] all_fc_tac);
a(�_tac�A�  THEN �_tac �B� THEN REPEAT strip_tac);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��x y z�x � y � y � z � x � � z�]);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T  [3, 4] all_fc_tac);
a(�_tac�A' � A''�  THEN �_tac �B' � B''� THEN REPEAT strip_tac
	THEN_TRY SOLVED_T (all_asm_fc_tac[]));
a(MERGE_PCS_T1["'bin_rel", "sets_ext1"] asm_prove_tac[]);
pop_thm()
));


val product_topology_space_t_thm = save_thm ( "product_topology_space_t_thm", (
set_goal([], ��� : 'a SET SET; � : 'b SET SET�
	� � Topology
�	� � Topology
�	Space�T  (� ��T �)  = (Space�T � � Space�T �)�);
a(rewrite_tac[product_topology_def, space_t_def]);
a(MERGE_PCS_T1["'bin_rel", "sets_ext1"] REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_asm_fc_tac[] THEN contr_tac THEN all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(all_asm_fc_tac[] THEN contr_tac THEN all_asm_fc_tac[]);
(* *** Goal "3" *** *)
a(�_tac�s � s'� THEN MERGE_PCS_T1["'bin_rel", "sets_ext1"] REPEAT strip_tac);
a(�_tac�s� THEN �_tac�s'� THEN MERGE_PCS_T1["'bin_rel", "sets_ext1"] REPEAT strip_tac);
pop_thm()
));


val unit_topology_thm = save_thm ( "unit_topology_thm", (
set_goal([], � 1�T � Topology �);
a(rewrite_tac[topology_def, unit_topology_def]
	THEN MERGE_PCS_T1 ["'one", "sets_ext1"] rewrite_tac[]
	THEN REPEAT strip_tac
	THEN all_asm_fc_tac[]);
a(asm_prove_tac[]);
pop_thm()
));

val space_t_unit_topology_thm = save_thm ( "space_t_unit_topology_thm", (
set_goal([], � Space�T 1�T = Universe �);
a(rewrite_tac[space_t_def, unit_topology_def]
	THEN MERGE_PCS_T1 ["'one", "sets_ext1"] rewrite_tac[]
	THEN REPEAT strip_tac
	THEN all_asm_fc_tac[]);
a(�_tac �Universe� THEN asm_prove_tac[]);
pop_thm()
));


val power_topology_length_thm = save_thm ( "power_topology_length_thm", (
set_goal([], ��� n v� v � Space�T (��T n �) � Length v = n�);
a(REPEAT_N 2 strip_tac THEN induction_tac�n:�
	THEN rewrite_tac[power_topology_def, space_t_def]
	THEN REPEAT strip_tac THEN_TRY all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[length_def]);
(* *** Goal "2" *** *)
a(strip_asm_tac(�_elim�v� list_cases_thm) THEN all_var_elim_asm_tac1
	THEN all_asm_fc_tac[]);
a(all_fc_tac[�_space_t_thm]);
a(all_asm_fc_tac[] THEN asm_rewrite_tac[length_def]);
pop_thm()
));


val power_topology_thm = save_thm ( "power_topology_thm", (
set_goal([], ��� n� � � Topology � ��T n � � Topology�);
a(REPEAT strip_tac THEN induction_tac�n:�
	THEN rewrite_tac[power_topology_def]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" prove_tac[topology_def]);
(* *** Goal "2" *** *)
a(PC_T1 "sets_ext1" rewrite_tac[topology_def] THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(all_asm_fc_tac[]);
(* *** Goal "2.2" *** *)
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(�_tac�A� THEN �_tac�B� THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
a(�_tac�s� THEN REPEAT strip_tac THEN all_asm_fc_tac[]);
(* *** Goal "2.3" *** *)
a(LIST_DROP_NTH_ASM_T  [3, 5] all_fc_tac);
a(�_tac�A' � A''�  THEN �_tac �B' � B''� THEN REPEAT strip_tac
	THEN all_asm_fc_tac[�_open_thm]);
pop_thm()
));



val continuous_�_space_t_thm = save_thm ( "continuous_�_space_t_thm", (
set_goal([], �� �; �; f : 'a � 'b; x�
	f � (�, �) Continuous � x � Space�T � � f x � Space�T �
�);
a(rewrite_tac[continuous_def] THEN REPEAT strip_tac THEN all_asm_fc_tac[]);
pop_thm()
));


val continuous_open_thm = save_thm ( "continuous_open_thm", (
set_goal([], �� �; �; f : 'a � 'b; A�
	f � (�, �) Continuous � A � � � {x|x � Space�T � � f x � A} � �
�);
a(rewrite_tac[continuous_def] THEN REPEAT strip_tac THEN all_asm_fc_tac[]);
pop_thm()
));


val continuous_closed_thm = save_thm ( "continuous_closed_thm", (
set_goal([], �� � : 'a SET SET; � : 'b SET SET�
	(�, �) Continuous =
	{f
	|	(�x� x � Space�T � � f x � Space�T �)
	�	(�A� A � � Closed � {x | x � Space�T � � f x � A} � � Closed)}
�);
a(REPEAT �_tac THEN  rewrite_tac[continuous_def]);
a(PC_T1 "sets_ext1" once_rewrite_tac[] THEN strip_tac);
a(rename_tac[(�x�, "f")] THEN rewrite_tac[
		taut_rule ��p q r� (r � p � r � q) � (r � (p � q)) �,
		closed_def]);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
a(�_tac�{x|x � Space�T � � f x � B} � THEN asm_rewrite_tac[]);
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN all_asm_fc_tac[]);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 2 (ante_tac o �_elim�Space�T � \ A�));
a(LEMMA_T �� B� B � � � Space�T � \ A = Space�T � \ B� rewrite_thm_tac
	THEN1 asm_prove_tac[]);
a(REPEAT strip_tac);
a(LEMMA_T �{x|x � Space�T � � f x � A} = B� asm_rewrite_thm_tac);
a(lemma_tac�B � Space�T Ӯ THEN1
	(PC_T1 "sets_ext1" REPEAT strip_tac THEN all_fc_tac[�_space_t_thm]));
a(lemma_tac�{x|x � Space�T � � f x � A} � Space�T Ӯ THEN1
	(PC_T1 "sets_ext1" prove_tac[]));
a(ALL_FC_T1 fc_�_canon rewrite_tac[pc_rule1"sets_ext1" prove_rule[]
	� �a b c� a � c � b � c � (a = b � c \ a = c \ b)�]);
a(DROP_NTH_ASM_T 3 (rewrite_thm_tac o eq_sym_rule));
a(PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val subspace_continuous_thm = save_thm ( "subspace_continuous_thm", (
set_goal([], ��� � A B f�
	� � Topology
�	� � Topology
�	f � (�, �) Continuous
�	(�x� x � A � f x � B)
�	f � (A �T �, B �T �) Continuous
�);
a(REPEAT strip_tac THEN rewrite_tac[continuous_def]);
a(ALL_FC_T asm_rewrite_tac[subspace_topology_space_t_thm]);
a(DROP_NTH_ASM_T 2 (strip_asm_tac o rewrite_rule[continuous_def]));
a(rewrite_tac[subspace_topology_def]THEN REPEAT strip_tac
	THEN (all_var_elim_asm_tac1
		ORELSE all_asm_fc_tac[]));
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(�_tac�{x|x � Space�T � � f x � B'}� THEN asm_rewrite_tac[]);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val subspace_domain_continuous_thm = save_thm ( "subspace_domain_continuous_thm", (
set_goal([], ��� � A B f�
	� � Topology
�	� � Topology
�	f � (�, �) Continuous
�	f � (A �T �, �) Continuous
�);
a(REPEAT strip_tac);
a(LEMMA_T �� = Universe �T Ԯ once_rewrite_thm_tac
	THEN1 rewrite_tac[universe_subspace_topology_thm]);
a(bc_thm_tac subspace_continuous_thm THEN asm_rewrite_tac[]);
pop_thm()
));


val empty_continuous_thm = save_thm ( "empty_continuous_thm", (
set_goal([], ��� � f�
	� � Topology
�	� � Topology
�	f � ({} �T �, �) Continuous
�);
a(REPEAT strip_tac);
a(asm_rewrite_tac[continuous_def]);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]);
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]�{x|F} = {}�]);
a(REPEAT strip_tac THEN rewrite_tac[subspace_topology_def]);
a(�_tac�{}� THEN ALL_FC_T rewrite_tac[empty_open_thm]);
pop_thm()
));


val subspace_range_continuous_thm = save_thm ( "subspace_range_continuous_thm", (
set_goal([], ��� � f B�
	� � Topology
�	� � Topology
�	f � (�, B �T �) Continuous
�	f � (�, �) Continuous
�);
a(rewrite_tac[continuous_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_asm_fc_tac[] THEN POP_ASM_T ante_tac);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]
	THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(LEMMA_T ��x� x � Space�T � � f x � A �
	x � Space�T � � f x � A � B�
	rewrite_thm_tac);
(* *** Goal "2.1" *** *)
a(DROP_NTH_ASM_T 3 ante_tac);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]);
a(PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2" *** *)
a(DROP_NTH_ASM_T 2 bc_thm_tac);
a(rewrite_tac[subspace_topology_def]
	THEN asm_prove_tac[]);
pop_thm()
));


val subspace_range_continuous_�_thm = save_thm ( "subspace_range_continuous_�_thm", (
set_goal([], ���; �; f : 'a � 'b; B�
	� � Topology
�	� � Topology
�	B � Space�T �
�	(f � (�, B �T �) Continuous �
	 f � (�, �) Continuous � �x� x � Space�T � � f x � B)
�);
a(REPEAT strip_tac THEN1 all_fc_tac[subspace_range_continuous_thm]);
(* *** Goal "1" *** *)
a(all_fc_tac[continuous_�_space_t_thm]);
a(POP_ASM_T ante_tac THEN ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]);
a(REPEAT strip_tac);
(* *** Goal "2" *** *)
a(DROP_NTH_ASM_T 2 ante_tac THEN asm_rewrite_tac[continuous_def] THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]);
a(all_asm_fc_tac[] THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[subspace_topology_def] THEN strip_tac);
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(LEMMA_T ��x� x � Space�T � � f x � A � x � Space�T � � f x � B'�
	asm_rewrite_thm_tac);
a(all_var_elim_asm_tac1 THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [6] all_fc_tac);
pop_thm()
));


val subspace_range_continuous_bc_thm = save_thm ( "subspace_range_continuous_bc_thm", (
set_goal([], ���; �; f : 'a � 'b; B�
	� � Topology
�	� � Topology
�	B � Space�T �
�	(�x� x � Space�T � � f x � B)
�	f � (�, �) Continuous
�	f � (�, B �T �) Continuous
�);
a(REPEAT strip_tac THEN POP_ASM_T ante_tac);
a(ALL_FC_T1 fc_�_canon asm_rewrite_tac[subspace_range_continuous_�_thm]);
pop_thm()
));



val const_continuous_thm = save_thm ( "const_continuous_thm", (
set_goal([], ��� � c�
	� � Topology
�	� � Topology
�	c � Space�T �
�	(�x� c) � (�, �) Continuous
�);
a(REPEAT strip_tac);
a(rewrite_tac[continuous_def, topology_def] THEN
	PC_T1 "sets_ext1" REPEAT strip_tac);
a(cases_tac�c � A� THEN asm_rewrite_tac[]);
(* *** Goal "1" *** *)
a(rewrite_tac[pc_rule1"sets_ext" prove_rule[]�{x | x � Space�T �} = Space�T Ӯ]);
a(all_asm_fc_tac[space_t_open_thm]);
(* *** Goal "2" *** *)
a(rewrite_tac[pc_rule1"sets_ext" prove_rule[]�{x | F} = {}�]);
a(all_asm_fc_tac[empty_open_thm]);
pop_thm()
));


val id_continuous_thm = save_thm ( "id_continuous_thm", (
set_goal([], ��Է
	� � Topology
�	(�x� x) � (�, �) Continuous
�);
a(rewrite_tac[continuous_def, topology_def, space_t_def] THEN
	PC_T1 "sets_ext1" REPEAT strip_tac);
a(LEMMA_T � {x|x � � � � x � A} = A�  asm_rewrite_thm_tac);
a(POP_ASM_T ante_tac THEN PC_T1 "sets_ext1"  prove_tac[]);
pop_thm()
));


val comp_continuous_thm = save_thm ( "comp_continuous_thm", (
set_goal([], ��f g � � Է
	f � (�, �) Continuous
�	g � (�, �) Continuous
�	� � Topology
�	� � Topology
�	� � Topology
�	(�x� g(f x)) � (�, �) Continuous
�);
a(rewrite_tac[continuous_def] THEN REPEAT strip_tac THEN
	(all_asm_fc_tac[] THEN all_asm_fc_tac[]));
a( LEMMA_T �{x|x � Space�T � � g (f x) � A} ={x|x � Space�T � � f x � {x|x � Space�T � � g x � A}}�
	once_rewrite_thm_tac THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" prove_tac[] THEN all_asm_fc_tac[]);
pop_thm()
));


val left_proj_continuous_thm = save_thm ( "left_proj_continuous_thm", (
set_goal([], ��� : 'a SET SET; � : 'b SET SET�
	� � Topology
�	� � Topology
�	(�(x, y)� x) � ((� ��T �), �) Continuous
�);
a(REPEAT strip_tac THEN rewrite_tac[continuous_def]);
a(all_fc_tac[product_topology_thm]);
a(ALL_FC_T rewrite_tac [product_topology_space_t_thm]);
a(rewrite_tac[product_topology_def, �_def] THEN REPEAT strip_tac);
a(�_tac�A� THEN �_tac�Space�T Ԯ THEN
	ALL_FC_T asm_rewrite_tac[space_t_open_thm]);
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN_TRY asm_rewrite_tac[]);
a(all_fc_tac[�_space_t_thm]);
pop_thm()
));


val fst_continuous_thm = save_thm ( "fst_continuous_thm", (
set_goal([], ��� : 'a SET SET; � : 'b SET SET�
	� � Topology
�	� � Topology
�	Fst � ((� ��T �), �) Continuous
�);
a(REPEAT strip_tac);
a(LEMMA_T�Fst = �(x:'a, y:'b)�x� rewrite_thm_tac THEN1 prove_tac[]);
a(all_fc_tac[left_proj_continuous_thm]);
pop_thm()
));


val right_proj_continuous_thm = save_thm ( "right_proj_continuous_thm", (
set_goal([], ��� : 'a SET SET; � : 'b SET SET�
	� � Topology
�	� � Topology
�	(�(x, y)� y) � ((� ��T �), �) Continuous
�);
a(REPEAT strip_tac THEN rewrite_tac[continuous_def]);
a(all_fc_tac[product_topology_thm]);
a(ALL_FC_T rewrite_tac [product_topology_space_t_thm]);
a(rewrite_tac[product_topology_def, �_def] THEN REPEAT strip_tac);
a(�_tac�Space�T Ӯ THEN �_tac�A� THEN
	ALL_FC_T asm_rewrite_tac[space_t_open_thm]);
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN_TRY asm_rewrite_tac[]);
a(all_fc_tac[�_space_t_thm]);
pop_thm()
));


val snd_continuous_thm = save_thm ( "snd_continuous_thm", (
set_goal([], ��� : 'a SET SET; � : 'b SET SET�
	� � Topology
�	� � Topology
�	Snd � ((� ��T �), �) Continuous
�);
a(REPEAT strip_tac);
a(LEMMA_T�Snd = �(x:'a, y:'b)�y� rewrite_thm_tac THEN1 prove_tac[]);
a(all_fc_tac[right_proj_continuous_thm]);
pop_thm()
));


val product_continuous_thm = save_thm ( "product_continuous_thm", (
set_goal([], �� f : 'a � 'b; g : 'a � 'c; � : 'a SET SET; � : 'b SET SET; � : 'c SET SET�
	f � (�, �) Continuous
�	g � (�, �) Continuous
�	� � Topology
�	� � Topology
�	� � Topology
�	(�z�(f z, g z)) � (�, (� ��T �)) Continuous
�);
a(REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [4, 5] (MAP_EVERY ante_tac));
a(rewrite_tac[continuous_def]);
a(all_fc_tac[product_topology_thm]);
a(ALL_FC_T rewrite_tac [product_topology_space_t_thm]);
a(rewrite_tac[product_topology_def, �_def] THEN REPEAT strip_tac
	THEN_TRY (SOLVED_T (all_asm_fc_tac[])));
a(LIST_DROP_NTH_ASM_T (interval 6 16) discard_tac
	THEN ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]);
a(REPEAT strip_tac THEN all_asm_fc_tac[]);
a(LIST_DROP_NTH_ASM_T [11, 13] all_fc_tac);
a(�_tac�{x|x � Space�T � � g x � B} � {x|x � Space�T � � f x � A'}�);
a(ALL_FC_T rewrite_tac[�_open_thm]);
a(REPEAT strip_tac THEN PC_T1"sets_ext1" REPEAT strip_tac);
a(bc_thm_tac (pc_rule1"sets_ext" prove_rule[]��a xy�xy � a � a � A � xy � A�));
a(�_tac�{(v, w)|v � A' � w � B}� THEN REPEAT strip_tac);
pop_thm()
));


set_goal([], �� f : 'a � 'b; g : 'a � 'c; � : 'a SET SET; � : 'b SET SET; � : 'c SET SET�
	� � Topology
�	� � Topology
�	� � Topology
�	((�z�(f z, g z)) � (�, (� ��T �)) Continuous
	�	f � (�, �) Continuous
	�	g � (�, �) Continuous)

�);
a(REPEAT �_tac THEN �_tac);
a(lemma_tac�(� ��T �) � Topology� THEN1 all_fc_tac[product_topology_thm]);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LEMMA_T�(�z� (�(x, y)� x) ((�z�(f z, g z)) z))  � (�, �) Continuous�
	(fn th => ante_tac th THEN rewrite_tac[�_axiom]));
a(bc_thm_tac comp_continuous_thm);
a(�_tac�� ��T Ԯ THEN REPEAT strip_tac);
a(bc_thm_tac left_proj_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(LEMMA_T�(�z� (�(x, y)� y) ((�z�(f z, g z)) z))  � (�, �) Continuous�
	(fn th => ante_tac th THEN rewrite_tac[�_axiom]));
a(bc_thm_tac comp_continuous_thm);
a(�_tac�� ��T Ԯ THEN REPEAT strip_tac);
a(bc_thm_tac right_proj_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "3" *** *)
a(all_fc_tac[product_continuous_thm]);
val product_continuous_�_thm = save_pop_thm "product_continuous_�_thm";



val left_product_inj_continuous_thm = save_thm ( "left_product_inj_continuous_thm", (
set_goal([], ��� : 'a SET SET; � : 'b SET SET; y : 'b�
	� � Topology
�	� � Topology
�	y � Space�T �
�	(�x� (x, y)) � (�, � ��T �) Continuous
�);
a(REPEAT strip_tac);
a(ante_tac(list_�_elim[��x:'a� x�, ��x:'a�y�, �Ӯ, �Ӯ, �Ԯ] product_continuous_thm));
a(ALL_FC_T asm_rewrite_tac[id_continuous_thm, const_continuous_thm]);
pop_thm()
));


val right_product_inj_continuous_thm = save_thm ( "right_product_inj_continuous_thm", (
set_goal([], ���: 'a SET SET; � : 'b SET SET; x : 'a�
	� � Topology
�	� � Topology
�	x � Space�T �
�	(�y� (x, y)) � (�, � ��T �) Continuous
�);
a(REPEAT strip_tac);
a(ante_tac(list_�_elim[��y:'b� x�, ��y:'b�y�, �Ԯ, �Ӯ, �Ԯ] product_continuous_thm));
a(ALL_FC_T asm_rewrite_tac[id_continuous_thm, const_continuous_thm]);
pop_thm()
));


val range_unit_topology_continuous_thm = save_thm ( "range_unit_topology_continuous_thm", (
set_goal([], ���: 'a SET SET; f : 'a � ONE�
	� � Topology
�	f � (�, 1�T) Continuous
�);
a(rewrite_tac[continuous_def,
		unit_topology_def, space_t_unit_topology_thm] THEN
	REPEAT strip_tac
	THEN all_var_elim_asm_tac1);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" rewrite_tac[pc_rule1"sets_ext1" prove_rule[] �{x|F} = {}�]);
a(all_fc_tac[empty_open_thm]);
(* *** Goal "2" *** *)
a(rewrite_tac[one_def, pc_rule1"sets_ext1" prove_rule[] ��a�{x|x � a} = a�]);
a(all_fc_tac[space_t_open_thm]);
pop_thm()
));


val domain_unit_topology_continuous_thm = save_thm ( "domain_unit_topology_continuous_thm", (
set_goal([], ���: 'a SET SET; f : ONE � 'a�
	� � Topology
�	f One � Space�T �
�	f � (1�T, �) Continuous
�);
a(rewrite_tac[continuous_def,
		unit_topology_def, space_t_unit_topology_thm] THEN
	REPEAT strip_tac);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[one_def]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN POP_ASM_T ante_tac);
a(PC_T1 "sets_ext1" rewrite_tac[one_def]);
pop_thm()
));

val pair_continuous_thm = snd ( "pair_continuous_thm", (
set_goal([], �� � � � f g�
	� � Topology � � � Topology � � � Topology �
	f � (�, �) Continuous � g � (�, �) Continuous �
	Pair (f, g) � (�, � ��T �) Continuous
�);
a(REPEAT strip_tac THEN rewrite_tac[pair_def]
	THEN ALL_FC_T rewrite_tac[product_continuous_thm]);
pop_thm()
));

val o_continuous_thm = snd ( "o_continuous_thm", (
set_goal([], �� � � � f g�
	� � Topology � � � Topology � � � Topology �
	f � (�, �) Continuous � g � (�, �) Continuous �
	g o f � (�, �) Continuous
�);
a(REPEAT strip_tac THEN rewrite_tac[
		prove_rule[o_def] ��f g� g o f = �x� g(f x)�]
	THEN ALL_FC_T rewrite_tac[comp_continuous_thm]);
pop_thm()
));

val i_continuous_thm = snd ( "i_continuous_thm", (
set_goal([], ��Է � � Topology � CombI � (�, �) Continuous�);
a(REPEAT strip_tac THEN rewrite_tac[
		prove_rule[get_spec�CombI�] �CombI = �x� x�]
	THEN ALL_FC_T rewrite_tac[id_continuous_thm]);
pop_thm()
));

val k_continuous_thm = snd ( "k_continuous_thm", (
set_goal([], �� � � c�
	� � Topology � � � Topology � c � Space�T � �
	CombK c � (�, �) Continuous�);
a(REPEAT strip_tac THEN rewrite_tac[
		prove_rule[get_spec�CombK�] ��c�CombK c = �x� c�]
	THEN ALL_FC_T rewrite_tac[const_continuous_thm]);
pop_thm()
));


val �_space_t_product_thm = snd ( "�_space_t_product_thm", (
set_goal([], ��� � x�
	� � Topology � � � Topology � Fst x � Space�T � � Snd x � Space�T � �
	x � Space�T(� ��T �)�);
a(REPEAT strip_tac THEN ALL_FC_T rewrite_tac[product_topology_space_t_thm]);
a(asm_rewrite_tac[�_def]);
pop_thm()
));



local

(*
*)

val continuity_fact_thms : THM list = [
	product_topology_thm,
	�_space_t_product_thm,
	fst_continuous_thm,
	snd_continuous_thm,
	i_continuous_thm,
	k_continuous_thm,
	pair_continuous_thm,
	o_continuous_thm];

(*
*)

val (unary_v, unary_p) = dest_pair �(x, x � (�, �) Continuous)�;
val (binary_v, binary_p) = dest_pair �(x, Uncurry x � (�, �) Continuous)�;
val (parametrized_v, parametrized_p) = dest_pair �(h, (� x� h x p) � (�, �) Continuous)�;
val (object_v, object_p) = dest_pair �(�, � � Topology)�;

(*
*)

fun get_patterns
	(accs as (acc_u, acc_b, acc_p, acc_o)
		: TERM list * TERM list * TERM list * (string list * TERM) list)
	((thm :: more) : THM list)
	: TERM list * TERM list * TERM list * (string list * TERM) list = (
	let	val tm = (snd o strip_� o concl) thm;
	in	let	val (tym, tmm) = term_match tm binary_p;
			val bin = subst tmm (inst [] tym binary_v);
		in	get_patterns (acc_u, bin::acc_b, acc_p, acc_o) more
		end	handle Fail _ =>
		let	val (tym, tmm) = term_match tm parametrized_p;
			val par = subst tmm (inst [] tym parametrized_v);
		in	get_patterns (acc_u, acc_b, par::acc_p, acc_o) more
		end	handle Fail _ =>
		let	val (tym, tmm) = term_match tm unary_p;
			val un = subst tmm (inst [] tym unary_v);
		in	get_patterns (un::acc_u, acc_b, acc_p, acc_o) more
		end	handle Fail _ =>
		let	val (tym, tmm) = term_match tm object_p;
			val ob = subst tmm (inst [] tym object_v);
			val tvs = (list_cup o map term_tyvars o asms) thm;
		in	get_patterns (acc_u, acc_b, acc_p, (tvs, ob)::acc_o) more
		end	handle Fail _ => get_patterns accs more
	end
) | get_patterns accs [] = accs;

(*
*)

val fst_const : TERM = �Fst�;
val snd_const : TERM = �Snd�;
val product_t_const : TERM = �$��T�;

fun continuity_params (thms : THM list) :
	{facts: THM list,
	 unary: TERM list,
	 binary: TERM list,
	 witness_tac: TACTIC,
	 parametrized: TERM list} = (
	let	val (uns, bins, pars, obs) = get_patterns ([], [], [], []) thms;
	in
		{unary = fst_const :: snd_const :: uns,
		 binary = bins,
		 parametrized = pars,
		 facts = thms @ continuity_fact_thms,
		 witness_tac = �_object_by_type_tac (([], product_t_const) :: obs)}
	end
);

in
(*
*)
fun basic_continuity_tac (thms : THM list): TACTIC = (fn gl as (asms, _) =>
	basic_morphism_tac (continuity_params (thms @ map asm_rule asms)) [] gl
);
end (* local ... in ... end *);
local
	val �_topology_pattern = �� � Topology�;
in
fun basic_topology_tac (thms : THM list) : TACTIC = (fn gl as (asms, _) =>
	let
		val all_thms = map asm_rule asms @ thms;
		fun is_�_topology tm = (
			(term_match tm �_topology_pattern; true)
			handle Fail _ => false
		);
		fun is_rule thm = (
			let	val tm = (snd o strip_� o concl) thm;
			in
			is_� tm andalso (is_�_topology o snd o dest_�) tm
			end
		);
		val is_axiom = is_�_topology o snd o strip_� o concl;
		val rule_thms = product_topology_thm ::
					subspace_topology_thm ::
					all_thms drop (not o is_rule);
		val basic_thms = unit_topology_thm ::
					all_thms drop (not o is_axiom);
	in	(REPEAT o CHANGED_T o FIRST)
			[rewrite_tac basic_thms, bc_tac rule_thms]
	end	gl
);
end;


val diag_inj_continuous_thm = save_thm ( "diag_inj_continuous_thm", (
set_goal([], �� � : 'a SET SET�
	� � Topology
�	(�x� (x, x)) � (�, � ��T �) Continuous
�);
a(REPEAT strip_tac);
a(basic_continuity_tac[]);
pop_thm()
));


val cond_continuous_thm = save_thm ( "cond_continuous_thm", (
set_goal([], ��f g X � Է
	f � (�, �) Continuous
�	g � (�, �) Continuous
�	(�x�x � Space�T � �  (�A�x � A � A � � � �y z�y � A � z � A � y � X � �z � X)
		� f x = g x)
�	� � Topology
�	� � Topology
�	(�x� if x � X then f x else g x) � (�, �) Continuous
�);
a(rewrite_tac[continuous_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(cases_tac�x � X� THEN asm_rewrite_tac[] THEN all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]);
a(strip_tac THEN rewrite_tac[]);
a(cases_tac�x � X� THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(cases_tac�� � A� x � A � A � � � (� y z� y � A � z � A � y � X � � z � X)�);
(* *** Goal "2.1.1" *** *)
a(LIST_DROP_NTH_ASM_T [13] all_fc_tac);
a(�_tac�{x|x � Space�T � � f x � A} � A'�);
a(REPEAT strip_tac);
(* *** Goal "2.1.1.1" *** *)
a(bc_thm_tac �_open_thm THEN REPEAT strip_tac);
(* *** Goal "2.1.1.2" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(spec_nth_asm_tac 5 �x�);
a(spec_nth_asm_tac 1 �x'� THEN asm_rewrite_tac[]);
(* *** Goal "2.1.2" *** *)
a(LIST_DROP_NTH_ASM_T [9, 11] all_fc_tac);
a(�_tac�{x|x � Space�T � � f x � A} � {x | x � Space�T � � g x � A}�);
a(REPEAT strip_tac);
(* *** Goal "2.1.2.1" *** *)
a(bc_thm_tac �_open_thm THEN REPEAT strip_tac);
(* *** Goal "2.1.2.2" *** *)
a(LEMMA_T�f x = g x� (asm_rewrite_thm_tac o eq_sym_rule));
a(all_asm_fc_tac[]);
(* *** Goal "2.1.2.3" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(cases_tac �x' � X� THEN asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(cases_tac�� � A� x � A � A � � � (� y z� y � A � z � A � y � X � � z � X)�);
(* *** Goal "2.2.1" *** *)
a(LIST_DROP_NTH_ASM_T [11] all_fc_tac);
a(�_tac�{x|x � Space�T � � g x � A} � A'�);
a(REPEAT strip_tac);
(* *** Goal "2.2.1.1" *** *)
a(bc_thm_tac �_open_thm THEN REPEAT strip_tac);
(* *** Goal "2.2.1.2" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(spec_nth_asm_tac 5 �x'�);
a(spec_nth_asm_tac 1 �x� THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2" *** *)
a(LIST_DROP_NTH_ASM_T [9, 11] all_fc_tac);
a(�_tac�{x|x � Space�T � � f x � A} � {x | x � Space�T � � g x � A}�);
a(REPEAT strip_tac);
(* *** Goal "2.2.2.1" *** *)
a(bc_thm_tac �_open_thm THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2" *** *)
a(LEMMA_T�f x = g x� asm_rewrite_thm_tac);
a(all_asm_fc_tac[]);
(* *** Goal "2.2.2.3" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(cases_tac �x' � X� THEN asm_rewrite_tac[]);
pop_thm()
));


val closed_�_closed_continuous_thm = save_thm ( "closed_�_closed_continuous_thm", (
set_goal([], ��� � A B f g�
	� � Topology
�	� � Topology
�	A � � Closed
�	B � � Closed
�	f � (A �T �, �) Continuous
�	g � (B �T �, �) Continuous
�	(�x�x � A � B � f x = g x)
�	(�x� if x � A then f x else g x) � ((A � B) �T �, �) Continuous
�);
a(rewrite_tac[continuous_closed_thm] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LIST_DROP_NTH_ASM_T (interval 1 6) (MAP_EVERY ante_tac));
a(lemma_tac �A � B � � Closed� THEN1 all_fc_tac[�_closed_thm]);
a(ALL_FC_T rewrite_tac[subspace_topology_closed_thm,
	subspace_topology_space_t_thm3]);
a(PC_T1 "predicates" REPEAT strip_tac
	THEN cases_tac�x � A�);
(* *** Goal "1.1" *** *)
a(LIST_DROP_NTH_ASM_T [7] (ALL_FC_T asm_rewrite_tac));
(* *** Goal "1.2" *** *)
a(DROP_NTH_ASM_T 2 strip_asm_tac);
a(LIST_DROP_NTH_ASM_T [5] (ALL_FC_T asm_rewrite_tac));
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T (interval 1 6) (MAP_EVERY ante_tac));
a(lemma_tac �A � B � � Closed� THEN1 all_fc_tac[�_closed_thm]);
a(ALL_FC_T rewrite_tac[subspace_topology_closed_thm,
	subspace_topology_space_t_thm3]
	THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [3, 5] all_fc_tac);
a(�_tac�(B'' � A) � (B' � B)� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(bc_tac[�_closed_thm, �_closed_thm] THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(LIST_DROP_NTH_ASM_T [1, 3] (rewrite_tac o map eq_sym_rule));
a(DROP_NTH_ASM_T 4 ante_tac THEN DROP_ASMS_T discard_tac);
a(PC_T1 "sets_ext1" rewrite_tac[] THEN strip_tac THEN �_tac);
a(cases_tac�x � A� THEN asm_rewrite_tac[]
	THEN asm_prove_tac[]);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
pop_thm()
));



val open_�_open_continuous_thm = save_thm ( "open_�_open_continuous_thm", (
set_goal([], ��� � A B f g�
	� � Topology
�	� � Topology
�	A � �
�	B � �
�	f � (A �T �, �) Continuous
�	g � (B �T �, �) Continuous
�	(�x�x � A � B � f x = g x)
�	(�x� if x � A then f x else g x) � ((A � B) �T �, �) Continuous
�);
a(rewrite_tac[continuous_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LIST_DROP_NTH_ASM_T (interval 1 6) (MAP_EVERY ante_tac));
a(lemma_tac �A � B � Ӯ THEN1 all_fc_tac[�_open_thm]);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm2]);
a(rewrite_tac[subspace_topology_def]);
a(PC_T1 "predicates" REPEAT strip_tac
	THEN cases_tac�x � A�);
(* *** Goal "1.1" *** *)
a(LIST_DROP_NTH_ASM_T [7] (ALL_FC_T asm_rewrite_tac));
(* *** Goal "1.2" *** *)
a(DROP_NTH_ASM_T 2 strip_asm_tac);
a(LIST_DROP_NTH_ASM_T [5] (ALL_FC_T asm_rewrite_tac));
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T (interval 1 6) (MAP_EVERY ante_tac));
a(lemma_tac �A � B � Ӯ THEN1 all_fc_tac[�_open_thm]);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm2]);
a(rewrite_tac[subspace_topology_def] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [3, 5] all_fc_tac);
a(�_tac�(B'' � A) � (B' � B)� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(bc_tac[�_open_thm, �_open_thm] THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(LIST_DROP_NTH_ASM_T [1, 3] (rewrite_tac o map eq_sym_rule));
a(DROP_NTH_ASM_T 4 ante_tac THEN DROP_ASMS_T discard_tac);
a(PC_T1 "sets_ext1" rewrite_tac[] THEN strip_tac THEN �_tac);
a(cases_tac�x � A� THEN asm_rewrite_tac[]
	THEN asm_prove_tac[]);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
pop_thm()
));


val compatible_family_continuous_thm = save_thm ( "compatible_family_continuous_thm", (
set_goal([], ��� � X U G�
	� � Topology
�	� � Topology
�	(�x� x � X � U x � X)
�	(�x� x � X � x � U x)
�	(�x� x � X � U x � X �T �)
�	(�x� x � X � G x � (U x �T �, �) Continuous)
�	(�x y� x � X � y � U x � G y y = G x y)
�	(�x� G x x) � (X �T �, �) Continuous
�);
a(rewrite_tac[continuous_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]
	THEN REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T [4] (FC_T bc_tac));
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]
	THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�X � Space�T Ӯ);
(* *** Goal "2.1" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac);
a(all_asm_fc_tac[]);
a(lemma_tac �X �T � � Topology� THEN1 
	(bc_thm_tac subspace_topology_thm THEN REPEAT strip_tac));
a(LEMMA_T �x � Space�T (X �T �)� ante_tac THEN1 all_fc_tac[�_space_t_thm]);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]
	THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm1]);
a(lemma_tac�X �T � � Topology� THEN1 basic_topology_tac[]);
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]
	THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
a(LIST_DROP_NTH_ASM_T [3, 4](MAP_EVERY ante_tac));
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��a b c�a � b � b � c � a � c�]);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm1]);
a(rewrite_tac[subspace_topology_def] THEN REPEAT strip_tac);
a(lemma_tac�x � B � U x�
	THEN1 (DROP_NTH_ASM_T 3 (rewrite_thm_tac o eq_sym_rule)
		THEN asm_rewrite_tac[]));
a(�_tac�B � U x� THEN REPEAT strip_tac);
(* *** Goal "2.2.1" *** *)
a(�_tac�B � B'� THEN REPEAT strip_tac THEN1 all_fc_tac[�_open_thm]);
a(asm_rewrite_tac[] THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2.2" *** *)
a(DROP_NTH_ASM_T 4 (rewrite_thm_tac o eq_sym_rule));
a(PC_T1 "sets_ext1" REPEAT strip_tac
	THEN1 PC_T1 "sets_ext" all_asm_fc_tac[]);
a(LIST_DROP_NTH_ASM_T [15] (ALL_FC_T asm_rewrite_tac));
pop_thm()
));


val compatible_family_continuous_thm1 = save_thm ( "compatible_family_continuous_thm1", (
set_goal([], ��� : ('a � 'b) SET SET; � : 'c SET SET; X U G�
	� � Topology
�	� � Topology
�	(�v r� (v, r) � X � U (v, r) � X)
�	(�v r� (v, r) � X � (v, r) � U (v, r))
�	(�v r� (v, r) � X � U (v, r) � X �T �)
�	(�v r� (v, r) � X � G (v, r) � (U (v, r) �T �, �) Continuous)
�	(�v r w s� (v, r) � X � (w, s) � U (v, r) � G (w, s) (w, s) = G (v, r) (w, s))
�	(�(v, r)� G (v, r) (v, r)) � (X �T �, �) Continuous
�);
a(REPEAT strip_tac);
a(LEMMA_T �(�(v, r)� G (v, r) (v, r)) = (�x�G x x)� rewrite_thm_tac
	THEN1 rewrite_tac[]);
a(bc_thm_tac compatible_family_continuous_thm);
a(�_tac�U� THEN REPEAT strip_tac
	THEN pair_tac�x = (a : 'a, b : 'b)�
	THEN_TRY pair_tac�y = (c : 'a, d : 'b)�
	THEN asm_prove_tac[]);
pop_thm()
));


val same_on_space_continuous_thm = save_thm ( "same_on_space_continuous_thm", (
set_goal([], ��� � f g�
	� � Topology
�	� � Topology
�	g � (�, �) Continuous
�	(�x�x � Space�T � � f x = g x)
�	f � (�, �) Continuous
�);
a(rewrite_tac[continuous_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "2" *** *)
a(all_asm_fc_tac[]);
a(LEMMA_T ��x� x � Space�T � � f x � A � x � Space�T � � g x � A�
	asm_rewrite_thm_tac);
a(rewrite_tac[taut_rule ��p q r� (p � q � p � r) � (p � (q � r))�]);
a(�_tac THEN �_tac THEN ALL_ASM_FC_T rewrite_tac[]);
pop_thm()
));



val same_on_space_continuous_thm1 = save_thm ( "same_on_space_continuous_thm1", (
set_goal([], ��� � f g�
	� � Topology
�	� � Topology
�	(�x�x � Space�T � � f x = g x)
�	(f � (�, �) Continuous � g � (�, �) Continuous)
�);
a(REPEAT strip_tac THEN all_fc_tac[same_on_space_continuous_thm]);
a(DROP_NTH_ASM_T 2 (strip_asm_tac o conv_rule(ONCE_MAP_C eq_sym_conv)));
a(all_fc_tac[same_on_space_continuous_thm]);
pop_thm()
));



val subspace_product_continuous_thm = save_thm ( "subspace_product_continuous_thm", (
set_goal([], ��� � � f A B�
	� � Topology
�	� � Topology
�	� � Topology
�	�(A � B) = {}
�	A � Space�T �
�	B � Space�T �
�	(f � ((A � B) �T (� ��T �), �) Continuous �
	(�a b� a � A � b � B � f(a, b) � Space�T �) �
	(�a b E� a � A � b � B � f(a, b) � E � E � �
		�	�C D� a � C � C � � � b � D � D � � � �x y�
				x � A � C � y � B � D � f(x, y) � E))
�);
a(REPEAT_UNTIL is_� strip_tac);
a(lemma_tac�� ��T � � Topology� THEN1 basic_topology_tac[]);
a(rewrite_tac[continuous_def]);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm,
		product_topology_space_t_thm]);
a(PC_T1 "sets_ext1" rewrite_tac[�_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 4 bc_thm_tac THEN asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T [1, 2, 5, 6] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [5] all_fc_tac);
a(POP_ASM_T ante_tac);
a(lemma_tac�{(v, w)|v � A � w � B} �T � ��T � � Topology�
	THEN1 (bc_thm_tac subspace_topology_thm THEN REPEAT strip_tac));
a(LIST_GET_NTH_ASM_T [8, 9] (PC_T1 "sets_ext1" all_fc_tac));
a(PC_T1 "sets_ext1" rewrite_tac[product_topology_def, subspace_topology_def, �_def] THEN REPEAT strip_tac);
a(TOP_ASM_T (ante_tac o list_�_elim[�a�, �b�])
	THEN rewrite_tac[] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(�_tac�A'� THEN �_tac�B''� THEN asm_rewrite_tac[]
	THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 11 (ante_tac o list_�_elim[�x�, �y�])
	THEN rewrite_tac[] THEN REPEAT strip_tac
	THEN all_asm_fc_tac[]);
(* *** Goal "3" *** *)
a(DROP_NTH_ASM_T 6 (ante_tac o list_�_elim[�Fst x�, �Snd x�])
	THEN asm_rewrite_tac[]);
(* *** Goal "4" *** *)
a(rename_tac[(�A'�, "E")]
	THEN LEMMA_T �
	{x |((Fst x � A � Snd x � B) � Fst x � Space�T � � Snd x � Space�T �) � f x � E} =
	{(c, d) | (c � A � c � Space�T �) � (d � B � d �  Space�T �) � f(c, d) � E}� rewrite_thm_tac
	THEN1 MERGE_PCS_T1 ["'pair", "sets_ext1"] prove_tac[]);
a(LEMMA_T��x� x � A � x � Space�T � � x � A� rewrite_thm_tac
	THEN1 (GET_NTH_ASM_T 6 ante_tac THEN PC_T1 "sets_ext1" prove_tac[]));
a(LEMMA_T��x� x � B � x � Space�T � � x � B� rewrite_thm_tac
	THEN1 (GET_NTH_ASM_T 5 ante_tac THEN PC_T1 "sets_ext1" prove_tac[]));
a(lemma_tac�{(v, w)|v � A � w � B} �T � ��T � � Topology�
	THEN1 (bc_thm_tac subspace_topology_thm THEN REPEAT strip_tac));
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[
	open_open_neighbourhood_thm]);
a(REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T [6] all_fc_tac);
a(�_tac�(A � C) � (B � D)�
	THEN once_rewrite_tac[taut_rule��p q�p � q � q � p�]
	THEN REPEAT strip_tac);
(* *** Goal "4.1" *** *)
a(MERGE_PCS_T1 ["'pair", "sets_ext1"] asm_rewrite_tac[�_def]);
(* *** Goal "4.2" *** *)
a(MERGE_PCS_T1 ["'pair", "sets_ext1"] rewrite_tac[�_def]
	THEN REPEAT strip_tac
	THEN all_asm_fc_tac[]);
(* *** Goal "4.3" *** *)
a(rewrite_tac[subspace_topology_def]);
a(�_tac�C � D�
	THEN once_rewrite_tac[taut_rule��p q�p � q � q � p�]
	THEN REPEAT strip_tac);
(* *** Goal "4.3.1" *** *)
a(MERGE_PCS_T1 ["'pair", "sets_ext1"] asm_rewrite_tac[�_def]);
a(taut_tac);
(* *** Goal "4.3.2" *** *)
a(rewrite_tac[product_topology_def, �_def]
	THEN REPEAT strip_tac);
a(�_tac�C� THEN �_tac�D� THEN REPEAT strip_tac);
pop_thm()
));


val subspace_topology_hausdorff_thm = save_thm ( "subspace_topology_hausdorff_thm", (
set_goal([], ��� X�
	� � Topology
�	� � Hausdorff
�	(X �T �) � Hausdorff
�);
a(rewrite_tac [hausdorff_def]);
a(REPEAT �_tac THEN �_tac);
a(ALL_FC_T rewrite_tac [subspace_topology_space_t_thm]);
a(rewrite_tac[subspace_topology_def] THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
a(�_tac�A � X� THEN �_tac �B � X� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(�_tac�A� THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(�_tac�B� THEN REPEAT strip_tac);
(* *** Goal "3" *** *)
a(POP_ASM_T ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val product_topology_hausdorff_thm = save_thm ( "product_topology_hausdorff_thm", (
set_goal([], ��� Է
	� � Topology
�	� � Topology
�	� � Hausdorff
�	� � Hausdorff
�	(� ��T �) � Hausdorff
�);
a(rewrite_tac [hausdorff_def]);
a(REPEAT �_tac THEN �_tac);
a(ALL_FC_T rewrite_tac [product_topology_space_t_thm]);
a(rewrite_tac[product_topology_def,
	pc_rule1"prop_eq_pair" prove_rule[]
		��p q��p = q � �Fst p = Fst q � �Snd p = Snd q�,
	merge_pcs_rule1["'bin_rel", "sets_ext1"] prove_rule[]
		��p a b�p � (a � b) � Fst p � a � Snd p � b�]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_asm_fc_tac[]);
a(�_tac�A � Space�T Ԯ THEN �_tac �B � Space�T Ԯ);
a(rewrite_tac[merge_pcs_rule1["'bin_rel", "sets_ext1"] prove_rule[]
		��p a b�p � (a � b) � Fst p � a � Snd p � b�]
	THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(�_tac�A� THEN �_tac �Space�T Ԯ THEN ALL_FC_T asm_rewrite_tac[space_t_open_thm]);
(* *** Goal "1.2" *** *)
a(�_tac�B� THEN �_tac �Space�T Ԯ THEN ALL_FC_T asm_rewrite_tac[space_t_open_thm]);
a(asm_rewrite_tac[merge_pcs_rule1["'bin_rel", "sets_ext1"] prove_rule[]
		��a b c d� (a � b) � (c � d) = ((a � c) � (b � d))  � ({} � a) = {}�]);
(* *** Goal "2" *** *)
a(all_asm_fc_tac[]);
a(�_tac�Space�T � � A� THEN �_tac �Space�T � � B�);
a(rewrite_tac[merge_pcs_rule1["'bin_rel", "sets_ext1"] prove_rule[]
		��p a b�p � (a � b) � Fst p � a � Snd p � b�]
	THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(�_tac�Space�T Ӯ THEN �_tac �A� THEN ALL_FC_T asm_rewrite_tac[space_t_open_thm]);
(* *** Goal "2.2" *** *)
a(�_tac�Space�T Ӯ THEN �_tac �B� THEN ALL_FC_T asm_rewrite_tac[space_t_open_thm]);
a(asm_rewrite_tac[merge_pcs_rule1["'bin_rel", "sets_ext1"] prove_rule[]
		��a b c d� (a � b) � (c � d) = ((a � c) � (b � d))  � (a � {}) = {}�]);
pop_thm()
));


val punctured_hausdorff_thm = save_thm ( "punctured_hausdorff_thm", (
set_goal([], ��� X x�
	� � Topology
�	� � Hausdorff
�	X � Space�T �
�	x � Space�T �
�	(X \ {x}) � (X �T �)
�);
a(rewrite_tac [hausdorff_def] THEN REPEAT strip_tac);
a(lemma_tac � (X �T �) � Topology �
	THEN1 ALL_FC_T rewrite_tac[subspace_topology_thm]);
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[
	open_open_neighbourhood_thm]);
a(rewrite_tac[subspace_topology_def]
	THEN REPEAT strip_tac);
a(all_asm_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��x X S�x � X � X � S � x � S�]);
a(LIST_DROP_NTH_ASM_T [7] all_fc_tac);
a(�_tac�A � X� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(asm_prove_tac[]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN POP_ASM_T ante_tac
	THEN DROP_ASMS_T discard_tac);
a(PC_T "sets_ext1" contr_tac
	THEN all_var_elim_asm_tac1
	THEN all_asm_fc_tac[]);
pop_thm()
));


val compact_topological_thm = save_thm ( "compact_topological_thm", (
set_goal([], ��� X�
	� � Topology
�	(X � � Compact � X � (X �T �) Compact)�);
a(rewrite_tac[compact_def] THEN PC_T1 "sets_ext1" REPEAT �_tac THEN �_tac);
a(ALL_FC_T1 fc_�_canon rewrite_tac[subspace_topology_space_t_thm]);
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��a b�a � a � b � a � b�]);
a(rewrite_tac[subspace_topology_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(lemma_tac�X � �{B | B � � � B � X � V} � THEN1 PC_T1 "sets_ext" REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(LIST_GET_NTH_ASM_T [1, 2, 3] (PC_T1 "sets_ext1" (MAP_EVERY strip_asm_tac)));
a(all_asm_fc_tac[]);
a(LIST_GET_NTH_ASM_T [3] all_fc_tac THEN all_var_elim_asm_tac1);
a(�_tac�B� THEN REPEAT strip_tac);
(* *** Goal "1.2" *** *)
a(lemma_tac�{B | B � � � B � X � V} � Ԯ THEN1 PC_T1 "sets_ext" prove_tac[]);
a(all_asm_fc_tac[]);
a(ante_tac(list_�_elim[��B�B � X�, �W�]finite_image_thm));
a(asm_rewrite_tac[] THEN REPEAT strip_tac);
a(�_tac �{C|� B� B � W � C = B � X}� THEN REPEAT strip_tac);
(* *** Goal "1.2.1" *** *)
a(PC_T "sets_ext1"  strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1);
a(LIST_GET_NTH_ASM_T [5] (PC_T1 "sets_ext1" all_fc_tac));
(* *** Goal "1.2.2" *** *)
a(PC_T "sets_ext1"  strip_tac THEN REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T [3] (PC_T1 "sets_ext1" all_fc_tac));
a(�_tac�s � X� THEN REPEAT strip_tac);
a(�_tac�s� THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(lemma_tac�X � �{C | �B� B � V � C = B � X} � THEN1 PC_T1 "sets_ext" REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(LIST_GET_NTH_ASM_T [2] (PC_T1 "sets_ext1" all_fc_tac));
a(�_tac�s � X� THEN REPEAT strip_tac);
a(�_tac�s� THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(lemma_tac�{C | �B� B � V � C = B � X} � {A|� B� B � � � A = B � X}�
	THEN1 (PC_T "sets_ext" strip_tac THEN REPEAT strip_tac));
(* *** Goal "2.2.1" *** *)
a(all_var_elim_asm_tac1 THEN �_tac �B� THEN
	REPEAT strip_tac THEN PC_T1 "sets_ext1" all_asm_fc_tac[]);
(* *** Goal "2.2.2" *** *)
a(all_asm_fc_tac[]);
a(lemma_tac��f��C� C � W � f C � V � C = f C � X� THEN1 prove_�_tac);
(* *** Goal "2.2.2.1" *** *)
a(REPEAT strip_tac);
a(cases_tac��C' � W� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 4 (PC_T1 "sets_ext1" strip_asm_tac));
a(LIST_DROP_NTH_ASM_T [1] all_fc_tac);
a(all_var_elim_asm_tac1 THEN �_tac�B� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2" *** *)
a(strip_asm_tac(list_�_elim[�f�, �W�]finite_image_thm));
a(�_tac�{y|� x� x � W � y = f x}� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2.1" *** *)
a(PC_T "sets_ext1"  strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
(* *** Goal "2.2.2.2.2" *** *)
a(PC_T "sets_ext1"  strip_tac THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 4 (PC_T1 "sets_ext1" strip_asm_tac));
a(LIST_DROP_NTH_ASM_T [1] all_fc_tac);
a(�_tac�f s� THEN asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T [5] all_fc_tac);
a(DROP_NTH_ASM_T 4 ante_tac);
a(POP_ASM_T (fn th => conv_tac(LEFT_C(once_rewrite_conv[th]))));
a(REPEAT strip_tac THEN rename_tac[]);
a(�_tac�s� THEN REPEAT strip_tac);
pop_thm()
));


val image_compact_thm = save_thm ( "image_compact_thm", (
set_goal([], ��f C � Է
	f � (�, �) Continuous
�	C � � Compact
�	� � Topology
�	� � Topology
�	{y | �x� x � C � y = f x} � � Compact
�);
a(rewrite_tac[compact_def, continuous_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac );
a(all_var_elim_asm_tac1 THEN PC_T1 "sets_ext1" all_asm_fc_tac[] THEN all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�{A | �B� B � V � A = {x|x � Space�T � � f x � B}} � Ӯ);
(* *** Goal "2.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN GET_NTH_ASM_T 8 bc_thm_tac);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��x a b�x � a � a � b � x � b�]);
(* *** Goal "2.2" *** *)
a(lemma_tac�C � �{A | �B� B � V � A = {x|x � Space�T � � f x � B}}�);
(* *** Goal "2.2.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(LEMMA_T�f x � {y|� x� x � C � y = f x}�  asm_tac THEN1
	(REPEAT strip_tac THEN �_tac�x� THEN REPEAT strip_tac));
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��x a b�x � a � a � b � x � b�]);
a(�_tac�{x|x � Space�T � � f x � s}� THEN REPEAT strip_tac);
a(�_tac�s� THEN REPEAT strip_tac);
(* *** Goal "2.2.2" *** *)
a(all_asm_fc_tac[]);
a(lemma_tac��h��A� A � W � h A � V � A = {x | x � Space�T � � f x � h A}�
	THEN1 prove_�_tac THEN REPEAT strip_tac);
 (* *** Goal "2.2.2.1" *** *)
a(cases_tac �A' � W�  THEN asm_rewrite_tac[]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��x a b�x � a � a � b � x � b�]);
a(�_tac�B� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2" *** *)
a(strip_asm_tac (list_�_elim[�h�, �W�] finite_image_thm));
a(�_tac�{y|� x� x � W � y = h x}� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
(* *** Goal "2.2.2.2.2" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1);
a(DROP_NTH_ASM_T 7 discard_tac);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��b�x' � C � C � b � x' � b�]);
a(�_tac�h s� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2.2.1" *** *)
a(all_asm_fc_tac[]);
a(POP_ASM_T (fn th => DROP_NTH_ASM_T 5 (ante_tac o once_rewrite_rule[th])));
a(REPEAT strip_tac);
(* *** Goal "2.2.2.2.2.2" *** *)
a(�_tac�s� THEN REPEAT strip_tac);
pop_thm()
));


val �_compact_thm = save_thm ( "�_compact_thm", (
set_goal([], ��C D ӷ
	C � � Compact
�	D � � Compact
�	� � Topology
�	C � D � � Compact
�);
a(rewrite_tac[compact_def] THEN REPEAT strip_tac
	THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��a b c�a � b � c � a � c � b � c�]);
a(all_asm_fc_tac[]);
a(�_tac �W � W'� THEN
	rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��a b��(a � b) = �a � �b�]
	THEN ALL_FC_T rewrite_tac[
	pc_rule1"sets_ext1" prove_rule[]��a b c�a � c � b � c � a � b � c�,
	pc_rule1"sets_ext1" prove_rule[]��a b c d�a � c � b � d � a � b � d � c�,
	conv_rule(ONCE_MAP_C eq_sym_conv) �_finite_thm]);
pop_thm()
));


val compact_closed_lemma = (* not saved *) snd ( "compact_closed_lemma", (
set_goal([], ��� V p�
	� � Topology
�	V � �
�	V � Finite
�	p � Space�T �
�	(�A� A � V � �B� B � � � p � B � A � B = {})
�	�B� B � � � p � B � B � �V = {}�);
a(REPEAT strip_tac);
a(lemma_tac�
	�b��A�A � V � b A � � � p � b A � A � b A = {}
� THEN1 prove_�_tac);
(* *** Goal "1" *** *)
a(REPEAT strip_tac);
a(cases_tac��A' � V� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 2 bc_thm_tac THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(cases_tac��V = {}�);
(* *** Goal "2.1" *** *)
a(�_tac �Space�T Ԯ THEN ALL_FC_T asm_rewrite_tac[space_t_open_thm]);
(* *** Goal "2.2" *** *)
a(lemma_tac ��{y|� x� x � V � y = b x} � Ԯ THEN1 bc_thm_tac finite_�_open_thm);
(* *** Goal "2.2.1" *** *)
a(asm_rewrite_tac[] THEN ALL_FC_T rewrite_tac[finite_image_thm]);
a(REPEAT strip_tac THEN PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
(* *** Goal "2.2.1.1" *** *)
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
(* *** Goal "2.2.1.2" *** *)
a(rewrite_tac[]);
a(cases_tac�V = {}� THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(POP_ASM_T (PC_T1 "sets_ext1" strip_asm_tac));
a(�_tac�b x� THEN �_tac�x� THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2.2" *** *)
a(�_tac��{y|� x� x � V � y = b x}� THEN asm_rewrite_tac[]);
a(REPEAT strip_tac);
(* *** Goal "2.2.2.1" *** *)
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
(* *** Goal "2.2.2.2" *** *)
a(PC_T "sets_ext1" strip_tac THEN rewrite_tac[�_def, �_def, �_def]);
a(REPEAT strip_tac);
a(�_tac�b s� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2.1" *** *)
a(�_tac� s� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2.2" *** *)
a(PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val compact_closed_thm = save_thm ( "compact_closed_thm", (
set_goal([], ��� C�
	� � Topology
�	� � Hausdorff
�	C � � Compact
�	C � � Closed�);
a(REPEAT strip_tac);
a(ALL_FC_T1 fc_�_canon  rewrite_tac[closed_open_neighbourhood_thm]);
a(once_rewrite_tac[prove_rule[]��p1 p2� p1 � p2 � p1 � (p1 � p2)�]);
a(REPEAT strip_tac THEN1
	(POP_ASM_T ante_tac THEN prove_tac[compact_def]));
a(lemma_tac�C � � {A | A � � � �B�B � � � x � B � A � B = {}}�);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 5 (strip_asm_tac o rewrite_rule[hausdorff_def]));
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(lemma_tac�x' � Space�T Ԯ THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(lemma_tac��x' = x� THEN1 (contr_tac THEN all_var_elim_asm_tac1));
a(all_asm_fc_tac[]);
a(�_tac�A� THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(DROP_NTH_ASM_T 5 (strip_asm_tac o rewrite_rule[compact_def]));
a(lemma_tac�{A | A � � � �B�B � � � x � B � A � B = {}} � Ԯ
	THEN1 PC_T1 "sets_ext1" prove_tac[]);
a(all_asm_fc_tac[]);
a(lemma_tac�W � Ԯ THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(lemma_tac�� A� A � W � (� B� B � � � x � B � A � B = {})�);
(* *** Goal "2.1" *** *)
a(REPEAT strip_tac);
a(PC_T1 "sets_ext1" all_asm_fc_tac[]);
a(�_tac�B� THEN PC_T1 "sets_ext1" asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(all_fc_tac[compact_closed_lemma]);
a(�_tac�B� THEN  asm_rewrite_tac[]);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[] ��X� C � X � B � X = {} � B � C = {}�]);
pop_thm()
));


val closed_�_compact_thm = save_thm ( "closed_�_compact_thm", (
set_goal([], ��� B C�
	� � Topology
�	� � Hausdorff
�	C � � Compact
�	B � � Closed
�	B � C
�	B � � Compact�);
a(REPEAT strip_tac THEN GET_NTH_ASM_T 3 ante_tac);
a(rewrite_tac[compact_def] THEN REPEAT strip_tac
	THEN all_fc_tac[closed_open_complement_thm]);
a(all_fc_tac[compact_closed_thm]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��t a x�a � t � x � t � a � {x} � t�]);
a(LEMMA_T��c b s v� c � s � b � �v � c � �(v � {s \ b})�
	(fn th => all_fc_tac[�_elim�C� th]));
(* *** Goal "1" *** *)
a(DROP_ASMS_T discard_tac THEN PC_T1 "sets_ext1" prove_tac[]);
a(cases_tac�x � b� THEN all_asm_fc_tac[]);
(* *** Goal "1.1" *** *)
a(contr_tac THEN all_asm_fc_tac[]);
(* *** Goal "1.2" *** *)
a(�_tac�s \ b� THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [8] all_fc_tac);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��w v x� w � v � {x} � w \ {x} � v � w \ {x} � w�]);
a(all_fc_tac[�_finite_thm]);
a(�_tac�W \ {Space�T � \ B}� THEN REPEAT strip_tac);
a(LEMMA_T��c w s b� b � c � c � �w � b � �(w \ {s \ b})�
	(fn th => bc_thm_tac (�_elim�C�th)
		THEN contr_tac THEN all_asm_fc_tac[]));
a(DROP_ASMS_T discard_tac THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(�_tac�s'� THEN contr_tac THEN all_var_elim_asm_tac1);
pop_thm()
));


val compact_basis_thm = save_thm ( "compact_basis_thm", (
set_goal([], ��U � X�
	� � Topology
�	U � �
�	(�A��x� x � A � A � � � �B� x � B � B � A � B � U)
�	X � Space�T �
�	(�V� V � U � X � � V � � W� W � V � W � Finite � X � � W)
�	X � � Compact
�);
a(rewrite_tac[compact_def] THEN REPEAT strip_tac);
a(lemma_tac�{B | B � U � � A� A � V � B � A} � U� THEN1 PC_T1 "sets_ext1" prove_tac[]);
a(lemma_tac�X � �{B | B � U � � A� A � V � B � A}�
	THEN1 PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 3 (fn th => PC_T1 "sets_ext1" all_fc_tac[th]));
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��x a�x � a � a � � � x � Ԯ]);
a(DROP_NTH_ASM_T 9 (fn th => all_fc_tac[th]));
a(�_tac�B� THEN REPEAT strip_tac);
a(�_tac�s� THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(DROP_NTH_ASM_T 5 (fn th => all_fc_tac[th]));
a(lemma_tac��f��B�B � W � f B � V � B � f B� THEN1 prove_�_tac);
(* *** Goal "2.1" *** *)
a(REPEAT strip_tac THEN cases_tac�B' � W� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 4 (fn th => all_fc_tac[pc_rule1 "sets_ext1" once_rewrite_rule[] th]));
a(�_tac �A� THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(ante_tac(list_�_elim[�f�, �W�] finite_image_thm) THEN asm_rewrite_tac[]);
a(REPEAT strip_tac);
a(�_tac �{y|� x� x � W � y = f x}� THEN REPEAT strip_tac);
(* *** Goal "2.2.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
(* *** Goal "2.2.2" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 4 (fn th => all_fc_tac[pc_rule1 "sets_ext1" once_rewrite_rule[] th]));
a(�_tac �f s� THEN rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "2.2.2.1" *** *)
a(PC_T1 "sets_ext" asm_prove_tac[]);
(* *** Goal "2.2.2.2" *** *)
a(�_tac �s� THEN asm_rewrite_tac[] );
pop_thm()
));


val compact_basis_product_topology_thm = save_thm ( "compact_basis_product_topology_thm", (
set_goal([], ��� � X�
	� � Topology
�	� � Topology
�	X � Space�T (� ��T �)
�	(�V� 	V � (� ��T �)
	�	(�D� D � V � �B C� B � � � C � � � D = (B � C))
	�	X � � V
	�	� W� W � V � W � Finite � X � � W)
�	X � (� ��T �) Compact
�);
a(REPEAT strip_tac THEN bc_thm_tac compact_basis_thm);
a(ALL_FC_T asm_rewrite_tac[product_topology_thm]);
a(�_tac�{D | �B C� B � � � C � � � D = (B � C)}� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(rewrite_tac[product_topology_def] THEN PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(�_tac�B� THEN �_tac�C� THEN asm_rewrite_tac[]);
a(POP_ASM_T ante_tac THEN asm_rewrite_tac[�_def]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[product_topology_def] THEN REPEAT strip_tac);
a(POP_ASM_T (ante_tac o list_�_elim[�Fst x�, �Snd x�]));
a(asm_rewrite_tac[] THEN REPEAT strip_tac);
a(�_tac�A' � B� THEN REPEAT strip_tac THEN1 asm_rewrite_tac[�_def]);
a(�_tac�A'� THEN �_tac�B� THEN asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 2 (fn th => ante_tac(pc_rule1 "sets_ext1" once_rewrite_rule[] th)));
a(rewrite_tac[taut_rule��p1 p2�(p1 � p2 � p1) � p1 � p2�]);
a(REPEAT strip_tac THEN PC_T "sets_ext" strip_tac THEN REPEAT strip_tac);
a(all_asm_fc_tac[] THEN all_var_elim_asm_tac1);
a(rewrite_tac[product_topology_def] THEN REPEAT strip_tac);
a(POP_ASM_T (strip_asm_tac o rewrite_rule[�_def]));
a(�_tac�B� THEN �_tac�C� THEN asm_rewrite_tac[]);
pop_thm()
));


val compact_product_lemma = (* not saved *) snd ( "compact_product_lemma", (
set_goal([], ��� � W x�
	� � Topology
�	� � Topology
�	x � Space�T �
�	W � Finite
�	(�D�D � W � �B C� x � B � B � � � C � � � D = (B � C))
�	�A� x � A � A � � � �t y�(x, y) � �W � t � A � (t, y) � �W�);
a(REPEAT strip_tac);
a(lemma_tac��V� V � Finite � V � W �
	�A� x � A � A � � � �t y�(x, y) � �V � t � A � (t, y) � �V�);
a(REPEAT strip_tac THEN POP_ASM_T ante_tac);
a(finite_induction_tac �V�);
(* *** Goal "1.1" *** *)
a(rewrite_tac[enum_set_clauses]);
a(all_fc_tac[space_t_open_thm] THEN contr_tac THEN all_asm_fc_tac[]);
(* *** Goal "1.2" *** *)
a(LEMMA_T ��{x'} � V � W� rewrite_thm_tac);
a(GET_NTH_ASM_T 2 ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "1.3" *** *)
a(REPEAT strip_tac);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[] ��x a b� {x} � a � b � x � b�]);
a(LIST_DROP_NTH_ASM_T [8] all_fc_tac);
a(all_var_elim_asm_tac1 THEN rewrite_tac[enum_set_clauses,
	pc_rule1"sets_ext1" prove_rule[]��a v��(a � v) = �a � �v�]);
a(�_tac �B � A� THEN REPEAT strip_tac);
(* *** Goal "1.3.1" *** *)
a(bc_thm_tac �_open_thm THEN REPEAT strip_tac);
(* *** Goal "1.3.2" *** *)
a(swap_nth_asm_concl_tac 1 THEN LIST_DROP_NTH_ASM_T [3, 4] (MAP_EVERY ante_tac));
a(rewrite_tac[�_def] THEN prove_tac[]);
(* *** Goal "1.3.3" *** *)
a(LEMMA_T �(x, y) � �V� asm_tac THEN1
	(LIST_DROP_NTH_ASM_T [5, 4] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext" prove_tac[]));
a(LIST_DROP_NTH_ASM_T [13] all_fc_tac);
a(contr_tac THEN all_asm_fc_tac[] THEN all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(POP_ASM_T bc_thm_tac THEN REPEAT strip_tac);
pop_thm()
));


val product_compact_thm = save_thm ( "product_compact_thm", (
set_goal([], ��X : 'a SET; Y : 'b SET; � � �
	X � � Compact
�	Y � � Compact
�	� � Topology
�	� � Topology
�	(X � Y) � (� ��T �) Compact�);
a(REPEAT strip_tac THEN bc_thm_tac compact_basis_product_topology_thm);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ALL_FC_T rewrite_tac[product_topology_space_t_thm]);
a(all_asm_ante_tac THEN rewrite_tac[compact_def] THEN REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T [4, 6] (MAP_EVERY ante_tac) THEN
	MERGE_PCS_T1 ["'bin_rel", "sets_ext1"] prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac ��W��x� x � X �
	W x � V � W x � Finite � (�y�y � Y � (x, y) � �(W x)) �
	�D� D � W x � (� B C� x � B � B � � � C � � � D = (B � C))�
	THEN1 prove_�_tac THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(cases_tac �x' � X� THEN asm_rewrite_tac[]);
a(lemma_tac �x' � Space�T Ӯ THEN1
	(LIST_DROP_NTH_ASM_T [1, 8] (MAP_EVERY ante_tac) THEN
	rewrite_tac[compact_def] THEN PC_T1 "sets_ext1" prove_tac[]));
a(strip_asm_tac (list_�_elim[�Ӯ, �Ԯ, �x'�] right_product_inj_continuous_thm));
a(lemma_tac �(� ��T �) � Topology� THEN1 basic_topology_tac[]);
a(ante_tac (list_�_elim[��y:'b�(x', y)�, �Y�, �Ԯ, �� ��T Ԯ] image_compact_thm));
a(asm_rewrite_tac[compact_def] THEN REPEAT strip_tac);
a(lemma_tac�x' � X � {y|� x� x � Y � Fst y = x' � Snd y = x} � (X � Y)�
	THEN1 (MERGE_PCS_T1 ["'bin_rel", "sets_ext" ] prove_tac[]
		THEN all_var_elim_asm_tac1));
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��a b c�a � b � b � c � a � c�]);
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(POP_ASM_T (PC_T1 "sets_ext1" strip_asm_tac));
a(�_tac �{A | A � W � �y�(x', y) � A}� THEN PC_T1 "basic_hol" REPEAT strip_tac);
(* *** Goal "2.1.1" *** *)
a(DROP_NTH_ASM_T 3 ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.1.2" *** *)
a(bc_thm_tac �_finite_thm THEN �_tac �W� THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.1.3" *** *)
a(lemma_tac�(x', y) � �W�);
(* *** Goal "2.1.3.1" *** *)
a(DROP_NTH_ASM_T 2 bc_thm_tac THEN REPEAT strip_tac);
a(�_tac�y� THEN asm_rewrite_tac[]);
(* *** Goal "2.1.3.2" *** *)
a(REPEAT strip_tac);
a(�_tac�s� THEN asm_rewrite_tac[]);
a(�_tac�y� THEN asm_rewrite_tac[]);
(* *** Goal "2.1.4" *** *)
a(lemma_tac�D � V� THEN1 (
	LIST_DROP_NTH_ASM_T [1, 4] (MAP_EVERY ante_tac)
		THEN PC_T1 "sets_ext" prove_tac[]));
a(LIST_DROP_NTH_ASM_T [14] all_fc_tac);
a(�_tac�B� THEN �_tac�C� THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 5 ante_tac THEN all_var_elim_asm_tac1);
a(prove_tac[�_def]);
(* *** Goal "2.2" *** *)
a(lemma_tac�X � �{A | A � � ��x�x � X �  x � A � �t y�t � A � y � Y � (t, y) � �(W x)}�
	THEN1 PC_T1 "sets_ext" REPEAT strip_tac);
(* *** Goal "2.2.1" *** *)
a(lemma_tac �x � Space�T Ӯ THEN1
	(LIST_DROP_NTH_ASM_T [1, 9] (MAP_EVERY ante_tac) THEN
	rewrite_tac[compact_def] THEN PC_T1 "sets_ext1" prove_tac[]));
a(DROP_NTH_ASM_T 3 (strip_asm_tac o �_elim�x�));
a(all_fc_tac[compact_product_lemma]);
a(�_tac�A� THEN REPEAT strip_tac);
a(�_tac�x� THEN PC_T1 "basic_hol" REPEAT strip_tac);
a(PC_T1 "basic_hol" (LIST_DROP_NTH_ASM_T [7])  all_fc_tac);
a(PC_T1 "basic_hol" (LIST_DROP_NTH_ASM_T [4])  all_fc_tac);
(* *** Goal "2.2.2" *** *)
a(lemma_tac�{A | A � � ��x�x � X �  x � A � �t y�t � A � y � Y � (t, y) � �(W x)} � Ӯ
	THEN1 PC_T1 "sets_ext" prove_tac[]);
a(GET_NTH_ASM_T 10 (fn th => all_fc_tac[rewrite_rule[compact_def] th]));
a(LIST_DROP_NTH_ASM_T [4, 5, 7, 8] discard_tac);
a(lemma_tac��U��A�A � W' � (� t y� t � A � y � Y � (t, y) � � (U A)) � U A � V � U A � Finite�
	THEN1 prove_�_tac);
(* *** Goal "2.2.2.1" *** *)
a(REPEAT strip_tac);
a(cases_tac�A' � W'� THEN asm_rewrite_tac[]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��x a b�x � a � a � b � x � b�]);
a(�_tac�W x� THEN  POP_ASM_T ante_tac THEN ALL_ASM_FC_T rewrite_tac[] THEN taut_tac);
(* *** Goal "2.2.2.2" *** *)
a(�_tac��{y|� x� x � W' � y = U x}� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac THEN all_var_elim_asm_tac1);
a(LIST_DROP_NTH_ASM_T [3] all_asm_fc_tac);
a(LIST_DROP_NTH_ASM_T [2, 4] (MAP_EVERY ante_tac) THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2.2.2.2" *** *)
a(ante_tac (list_�_elim[�U�, �W'�] finite_image_thm) THEN asm_rewrite_tac[] THEN strip_tac);
a(bc_thm_tac �_finite_thm THEN REPEAT strip_tac);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac THEN all_var_elim_asm_tac1);
a(all_asm_fc_tac[]);
(* *** Goal "2.2.2.2.3" *** *)
a(MERGE_PCS_T1 ["'bin_rel", "sets_ext1"] REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [4] (PC_T1"sets_ext1" all_fc_tac));
a(LIST_DROP_NTH_ASM_T [5] all_fc_tac);
a(�_tac�s'� THEN REPEAT strip_tac);
a(�_tac�U s� THEN REPEAT strip_tac);
a(�_tac�s� THEN REPEAT strip_tac);
pop_thm()
));


val compact_sequentially_compact_lemma = (* not saved *) snd ( "compact_sequentially_compact_lemma", (
set_goal([], ��W s�
	W � Finite
�	(�m:�s m � �W)
�	�A�A � W � �m��n�m � n � s n � A
�);
a(REPEAT strip_tac);
a(lemma_tac ��V s�
	V � Finite
�	(�m:�s m � �V)
�	V � W
�	�A�A � W � �m��n�m � n � s n � A
�);
(* *** Goal "1" *** *)
a(REPEAT strip_tac THEN POP_ASM_T ante_tac THEN POP_ASM_T ante_tac);
a(intro_�_tac(�s'�, �s'�));
a(finite_induction_tac�V� THEN
	rewrite_tac[�_enum_set_clauses,
		pc_rule1"sets_ext1" prove_rule[]��u v��(u � v) = �u � �v�]);
a(REPEAT strip_tac);
a(cases_tac�� m� � n� m � n � s' n � x�);
(* *** Goal "1.1" *** *)
a(�_tac�x� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 2 ante_tac THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(POP_ASM_T bc_thm_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "1.2" *** *)
a(DROP_NTH_ASM_T 5 (ante_tac o �_elim��n�s'(m + n)�));
a(ALL_FC_T rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��a b c�a � b � c � b � c�]);
a(LEMMA_T �� m'� s' (m + m') � � V� rewrite_thm_tac THEN1 �_tac);
(* *** Goal "1.2.1" *** *)
a(bc_thm_tac (pc_rule1"sets_ext1" prove_rule[]��a b y��y � a � y � a � b � y � b�));
a(�_tac�x� THEN asm_rewrite_tac[]);
a(spec_nth_asm_tac 1 �m + m'�);
(* *** Goal "1.2.2" *** *)
a(REPEAT strip_tac THEN �_tac�A� THEN REPEAT strip_tac);
a(spec_nth_asm_tac 1 �m'�);
a(�_tac�m + n� THEN asm_rewrite_tac[]);
a(PC_T1 "lin_arith" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(DROP_NTH_ASM_T 1 (ante_tac o �_elim�W�) THEN rewrite_tac[] THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
a(�_tac�A� THEN asm_rewrite_tac[]);
pop_thm()
));


val compact_sequentially_compact_thm = save_thm ( "compact_sequentially_compact_thm", (
set_goal([], ��� X s�
	� � Topology
�	X � � Compact
�	(�m:�s m � X)
�	�x�x � X � (�A�A � � � x � A � �m��n�m � n � s n � A)
�);
a(rewrite_tac[compact_def] THEN contr_tac);
a(lemma_tac�X � �{A | A � � � �x�x � A � x � X � �m��n�m � n � �s n � A}�);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac);
a(spec_nth_asm_tac 2 �x�);
a(�_tac�A� THEN asm_rewrite_tac[]);
a(�_tac�x� THEN asm_rewrite_tac[]);
a(�_tac�m� THEN REPEAT strip_tac);
a(spec_nth_asm_tac 2 �n�);
(* *** Goal "2" *** *)
a(lemma_tac�{A | A � � � �x�x � A � x � X � �m��n�m � n � �s n � A} � Ԯ
	THEN1 PC_T1 "sets_ext1" prove_tac[]);
a(LIST_DROP_NTH_ASM_T [5] all_fc_tac);
a(lemma_tac��m�s m � �W� THEN1
	all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��a b�a � b � (� m� s m � a) � (� m� s m � b)�]);
a(all_fc_tac[compact_sequentially_compact_lemma]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��y a b�y � a � a � b � y � b�]);
a(spec_nth_asm_tac 5 �m�);
a(LIST_DROP_NTH_ASM_T [3] all_asm_fc_tac);
pop_thm()
));


val connected_topological_thm = save_thm ( "connected_topological_thm", (
set_goal([], ��� X�
	� � Topology
�	(X � � Connected � X � (X �T �) Connected)�);
a(rewrite_tac[connected_def] THEN PC_T1 "sets_ext1" REPEAT �_tac THEN �_tac);
a(ALL_FC_T1 fc_�_canon rewrite_tac[subspace_topology_space_t_thm]);
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��a b�a � a � b � a � b�]);
a(rewrite_tac[subspace_topology_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_var_elim_asm_tac1);
a(lemma_tac�X � B'  � B''� THEN1
	(GET_NTH_ASM_T 3 ante_tac THEN  PC_T1 "sets_ext" prove_tac[]));
a(DROP_NTH_ASM_T 3 ante_tac THEN
	rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��a b c�a � (b � a) � c � a = a � b � c�]);
a(REPEAT strip_tac);
a(lemma_tac��X � B' � THEN1
	(GET_NTH_ASM_T 3 ante_tac THEN  PC_T1 "sets_ext" prove_tac[]));
a(all_asm_fc_tac[]);
a(POP_ASM_T ante_tac THEN PC_T1 "sets_ext" prove_tac[]);
(* *** Goal "2" *** *)
a(list_spec_nth_asm_tac 6 [�B � X�, �C � X�]);
(* *** Goal "2.1" *** *)
a(list_spec_nth_asm_tac 1 [�B�]);
(* *** Goal "2.2" *** *)
a(list_spec_nth_asm_tac 1 [�C�]);
(* *** Goal "2.3" *** *)
a(i_contr_tac THEN LIST_DROP_NTH_ASM_T [1, 4] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.4" *** *)
a(i_contr_tac THEN LIST_DROP_NTH_ASM_T [1, 3] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.5" *** *)
a(i_contr_tac THEN LIST_DROP_NTH_ASM_T [1, 2] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.6" *** *)
a(LIST_DROP_NTH_ASM_T [1] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val connected_closed_thm = save_thm ( "connected_closed_thm", (
set_goal([], ��� X�
	� Connected =
	{A |A � Space�T � � � B C � B � � Closed � C � � Closed � A � B � C � A � B � C = {} � A � B � A � C}�);
a(REPEAT strip_tac THEN rewrite_tac[connected_def, closed_def]);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_var_elim_asm_tac1 THEN rename_tac[(�B'�, "c"), (�B''�, "b")]);
a(DROP_NTH_ASM_T 2 ante_tac);
a(rewrite_tac[pc_rule1 "sets_ext1" prove_rule [] ��A B C� (A \ B) � (A \ C) = A \ (B � C)�]
	THEN strip_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule [] ��S U X� X � S � X � (S \ U) = {} � X � U�]);
a(DROP_NTH_ASM_T 4 ante_tac);
a(rewrite_tac[pc_rule1 "sets_ext1" prove_rule [] ��A B C� (A \ B) � (A \ C) = A \ (B � C)�]
	THEN strip_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule [] ��S I X� X � S \ I  � X � I = {}�]);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule [] ��S X� X � S \ (c � b) � �X � S \ c � �X � b�]);
a(list_spec_nth_asm_tac 9 [�c�, �b�]);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule [] ��S X� X � S \ (c � b) � X �  c � X � S \ b�]);
(* *** Goal "2" *** *)
a(LEMMA_T�x � Space�T � \ (B � C)� ante_tac THEN1
	(LIST_GET_NTH_ASM_T [2, 7] (MAP_EVERY ante_tac)
		THEN PC_T1 "sets_ext1" prove_tac[]));
a(rewrite_tac[pc_rule1 "sets_ext1" prove_rule [] ��A B C�A \ (B � C) =  (A \ B) � (A \ C) �]
	THEN strip_tac);
a(LEMMA_T�x � (Space�T � \ (B � C)) = {}� ante_tac THEN1
	(LIST_GET_NTH_ASM_T [4, 8] (MAP_EVERY ante_tac)
		THEN PC_T1 "sets_ext1" prove_tac[]));
a(rewrite_tac[pc_rule1 "sets_ext1" prove_rule [] ��A B C�A \ (B � C) =  (A \ B) � (A \ C) �]
	THEN strip_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule []
	��S� x � S � �x � B � x � B � C � �x � S \ C�]);
a(contr_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule []
	��S� x � S � �x � C � x � B � C � �x � S \ B�]);
a(lemma_tac�x � Space�T � \ B � x � Space�T � \ C�);
a(DROP_NTH_ASM_T 16 bc_thm_tac);
a(asm_rewrite_tac[]);
a(strip_tac THEN_LIST[�_tac�B�, �_tac�C�] THEN REPEAT strip_tac);
pop_thm()
));


val connected_pointwise_thm = save_thm ( "connected_pointwise_thm", (
set_goal([], ��� X�
	� � Topology
�	(	X � � Connected
	 � 	�x y� x � X � y � X � �Y� Y � X � x � Y � y � Y � Y � � Connected)�);
a(REPEAT strip_tac THEN1 (�_tac�X� THEN PC_T1 "sets_ext1" asm_prove_tac[]));
a(POP_ASM_T ante_tac THEN rewrite_tac[connected_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN all_asm_fc_tac[]);
a(LIST_GET_NTH_ASM_T [2, 3, 4] (MAP_EVERY ante_tac) THEN PC_T1 "sets_ext" prove_tac[]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN PC_T "sets_ext1" contr_tac);
a(list_spec_nth_asm_tac 9 [�x�, �x'�]);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a b c�a � b � b � c � a � c�]);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a b c�a � b � b � c = {} � a � c = {}�]);
a(list_spec_nth_asm_tac 3 [�B�, �C�]);
(* *** Goal "2.1" *** *)
a(LIST_GET_NTH_ASM_T [1, 7, 11] (MAP_EVERY ante_tac) THEN PC_T1 "sets_ext" prove_tac[]);
(* *** Goal "2.2" *** *)
a(LIST_GET_NTH_ASM_T [1, 6, 9] (MAP_EVERY ante_tac) THEN PC_T1 "sets_ext" prove_tac[]);
pop_thm()
));


val connected_pointwise_bc_thm = save_thm ( "connected_pointwise_bc_thm", (
set_goal([], ��� X�
	� � Topology
� 	(�x y� x � X � y � X � �Y� Y � X � x � Y � y � Y � Y � � Connected)
�	X � � Connected�);
a(REPEAT strip_tac THEN ALL_FC_T1 fc_�_canon once_rewrite_tac[connected_pointwise_thm]);
a(POP_ASM_T ante_tac THEN taut_tac);
pop_thm()
));


val empty_connected_thm = save_thm ( "empty_connected_thm", (
set_goal([], ��Է � � Topology � {} � � Connected�);
a(REPEAT strip_tac THEN bc_thm_tac connected_pointwise_bc_thm);
a(asm_rewrite_tac[]);
pop_thm()
));


val singleton_connected_thm = save_thm ( "singleton_connected_thm", (
set_goal([], ��� x� � � Topology � x � Space�T � � {x} � � Connected�);
a(REPEAT strip_tac THEN rewrite_tac[connected_def, enum_set_clauses]);
a(PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val image_connected_thm = save_thm ( "image_connected_thm", (
set_goal([], ��f X � Է
	f � (�, �) Continuous
�	X � � Connected
�	� � Topology
�	� � Topology
�	{y | �x� x � X � y = f x} � � Connected
�);
a(rewrite_tac[connected_def, continuous_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac );
a(all_var_elim_asm_tac1 THEN PC_T1 "sets_ext1" all_asm_fc_tac[] THEN all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(contr_tac);
a(LIST_DROP_NTH_ASM_T [11] all_fc_tac);
a(GET_NTH_ASM_T 12 (PC_T1 "sets_ext1" strip_asm_tac));
a(lemma_tac�
	X � {x|x � Space�T � � f x � B} � {x|x � Space�T � � f x � C}
� THEN1 (PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac
		THEN_TRY SOLVED_T (all_asm_fc_tac[])));
(* *** Goal "2.1" *** *)
a(swap_nth_asm_concl_tac 9 THEN PC_T "sets_ext1" strip_tac);
a(REPEAT strip_tac THEN �_tac�f x� THEN REPEAT strip_tac);
a(�_tac�x� THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(lemma_tac�
	X � {x|x � Space�T � � f x � B} � {x|x � Space�T � � f x � C} = {}
� THEN1 (PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac));
(* *** Goal "2.2.1" *** *)
a(swap_nth_asm_concl_tac 11 THEN PC_T "sets_ext1" strip_tac);
a(REPEAT strip_tac THEN �_tac�f x�);
a(rewrite_tac[] THEN REPEAT strip_tac);
a(�_tac�x� THEN REPEAT strip_tac);
(* *** Goal "2.2.2" *** *)
a(LEMMA_T �X � {x|x � Space�T � � f x � B} � X � {x|x � Space�T � � f x � C}� ante_tac);
(* *** Goal "2.2.2.1" *** *)
a(DROP_NTH_ASM_T 14 bc_thm_tac THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2.2" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "2.2.2.2.1" *** *)
a(swap_nth_asm_concl_tac 8);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
(* *** Goal "2.2.2.2.2" *** *)
a(swap_nth_asm_concl_tac 7);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
pop_thm()
));


val �_connected_thm = save_thm ( "�_connected_thm", (
set_goal([], ��C D ӷ
	� � Topology
�	C � � Connected
�	D � � Connected
�	�C � D = {}
�	C � D � � Connected
�);
a(rewrite_tac[connected_def] THEN REPEAT strip_tac
	THEN1 all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a b c�a � c � b � c � a � b � c�]);
a(DROP_NTH_ASM_T 6 (PC_T1 "sets_ext1" strip_asm_tac) THEN contr_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a b c�a � b � c � a � c � b � c�]);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a b c�(a � b) � c = {} � a � c = {} � b � c = {}�]);
a(list_spec_nth_asm_tac 15 [�B�, �C'�] THEN list_spec_nth_asm_tac 14 [�B�, �C'�]);
(* *** Goal "1" *** *)
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a b c�a � c � b � c � a � b � c�]);
(* *** Goal "2" *** *)
a(ante_tac(pc_rule1 "sets_ext1" prove_rule[]
	�x � C � x � D  � C � B � D � C' � x � C � B � C'�));
a(asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(ante_tac(pc_rule1 "sets_ext1" prove_rule[]
	�x � C � x � D  � C � C' � D � B � x � C � B � C'�));
a(asm_rewrite_tac[]);
(* *** Goal "4" *** *)
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a b c�a � c � b � c � a � b � c�]);
pop_thm()
));


val product_connected_thm = save_thm ( "product_connected_thm", (
set_goal([], ��X : 'a SET; Y : 'b SET; � � �
	X � � Connected
�	Y � � Connected
�	� � Topology
�	� � Topology
�	(X � Y) � (� ��T �) Connected�);
a(REPEAT strip_tac);
a(lemma_tac �(� ��T �) � Topology� THEN1 basic_topology_tac[]);
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[connected_pointwise_thm]);
a(REPEAT strip_tac);
a(lemma_tac�
	(�H� H � (� ��T �) Connected � x � H � (Fst y, Snd x) � H � H � (X � Y))
�	(�V� V � (� ��T �) Connected � y � V � (Fst y, Snd x) � V � V � (X � Y))�
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(�_tac�{ab | �a� a � X � ab = (�a�(a, Snd x)) a}� THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(bc_thm_tac image_connected_thm);
a(�_tac�Ӯ THEN REPEAT strip_tac);
a(bc_thm_tac left_product_inj_continuous_thm THEN REPEAT strip_tac);
a(POP_ASM_T discard_tac THEN POP_ASM_T (ante_tac o rewrite_rule[�_def]));
a(DROP_NTH_ASM_T 4 (strip_asm_tac o rewrite_rule[connected_def]));
a(POP_ASM_T discard_tac THEN POP_ASM_T ante_tac
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "1.2" *** *)
a(�_tac �Fst x� THEN rewrite_tac[]);
a(POP_ASM_T discard_tac THEN POP_ASM_T (strip_asm_tac o rewrite_rule[�_def]));
(* *** Goal "1.3" *** *)
a(�_tac �Fst y� THEN rewrite_tac[]);
a(POP_ASM_T (strip_asm_tac o rewrite_rule[�_def]));
(* *** Goal "1.4" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN rewrite_tac[�_def] THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 3 (strip_asm_tac o rewrite_rule[�_def]) THEN taut_tac);
(* *** Goal "2" *** *)
a(�_tac�{ab | �b� b � Y � ab = (�b�(Fst y, b)) b}� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(bc_thm_tac image_connected_thm);
a(�_tac�Ԯ THEN REPEAT strip_tac);
a(bc_thm_tac right_product_inj_continuous_thm THEN REPEAT strip_tac);
a(POP_ASM_T (ante_tac o rewrite_rule[�_def]));
a(DROP_NTH_ASM_T 6 (strip_asm_tac o rewrite_rule[connected_def]));
a(POP_ASM_T discard_tac THEN POP_ASM_T ante_tac
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2" *** *)
a(�_tac �Snd y� THEN rewrite_tac[]);
a(POP_ASM_T (strip_asm_tac o rewrite_rule[�_def]));
(* *** Goal "2.3" *** *)
a(�_tac �Snd x� THEN rewrite_tac[]);
a(POP_ASM_T discard_tac THEN POP_ASM_T (strip_asm_tac o rewrite_rule[�_def]));
(* *** Goal "2.4" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN rewrite_tac[�_def] THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 2 (strip_asm_tac o rewrite_rule[�_def]) THEN taut_tac);
(* *** Goal "3" *** *)
a(lemma_tac �H � V � (X � Y)� THEN1
	all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a b c�a � c � b � c � a � b � c�]);
a(�_tac�H � V� THEN REPEAT strip_tac);
a(bc_thm_tac �_connected_thm);
a(REPEAT strip_tac THEN PC_T "sets_ext1" contr_tac THEN all_asm_fc_tac[]);
pop_thm()
));


val �_open_connected_thm = save_thm ( "�_open_connected_thm", (
set_goal([], ��A B ӷ
	A � �
�	�A = {}
�	B � �
�	�B = {}
�	A � B � � Connected
�	�A � B = {}
�);
a(rewrite_tac[connected_def] THEN contr_tac);
a(DROP_NTH_ASM_T 2 (ante_tac o list_�_elim[�A�, �B�]));
a(asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T [2, 4, 6] discard_tac THEN PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val �_closed_connected_thm = save_thm ( "�_closed_connected_thm", (
set_goal([], ��A B ӷ
	A � � Closed
�	�A = {}
�	B � � Closed
�	�B = {}
�	A � B � � Connected
�	�A � B = {}
�);
a(rewrite_tac[connected_closed_thm] THEN contr_tac);
a(DROP_NTH_ASM_T 2 (ante_tac o list_�_elim[�A�, �B�]));
a(asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T [2, 4, 6] discard_tac THEN PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val �_�_connected_thm = save_thm ( "�_�_connected_thm", (
set_goal([], ��C D E ӷ
	� � Topology
�	C � � Connected
�	D � � Connected
�	E � � Connected
�	�C � D = {}
�	�D � E = {}
�	C � D � E � � Connected
�);
a(REPEAT strip_tac THEN REPEAT (bc_thm_tac �_connected_thm THEN REPEAT strip_tac));
a(PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val cover_connected_thm = save_thm ( "cover_connected_thm", (
set_goal([], ��C U ӷ
	� � Topology
�	C � � Connected
�	U � � Connected
�	C � �U
�	�{D | D � U � �C � D = {}} � � Connected
�);
a(REPEAT strip_tac THEN bc_thm_tac connected_pointwise_bc_thm THEN REPEAT strip_tac);
a(GET_NTH_ASM_T 7 (PC_T1 "sets_ext1" strip_asm_tac));
a(GET_NTH_ASM_T 9 (PC_T1 "sets_ext1" strip_asm_tac));
a(�_tac�s � C � s'� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(�_tac�s� THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(LIST_GET_NTH_ASM_T [3] all_fc_tac);
a(�_tac�s''� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(�_tac�x'� THEN REPEAT strip_tac);
(* *** Goal "3" *** *)
a(�_tac�s'� THEN REPEAT strip_tac);
(* *** Goal "4" *** *)
a(bc_thm_tac �_�_connected_thm THEN REPEAT strip_tac
	THEN_TRY (SOLVED_T (all_asm_fc_tac[])));
a(GET_NTH_ASM_T 6 ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val separation_thm = save_thm ( "separation_thm", (
set_goal([], ��� C D�
	� � Topology
�	C � � Connected
�	D � � Connected
�	�C � D � � Connected
�	�A B�	A � � � B � � � (C � D) � A � B = {}
	�	C � A
	�	D � B
�);
a(rewrite_tac[connected_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(i_contr_tac THEN
	LIST_GET_NTH_ASM_T[1, 3, 5] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�C � B � C' � C � B � C' = {}� THEN1
	(LIST_GET_NTH_ASM_T[3, 4] (MAP_EVERY ante_tac)
		THEN PC_T1 "sets_ext1" prove_tac[]));
a(lemma_tac�D � B � C' � D � B � C' = {}� THEN1
	(LIST_GET_NTH_ASM_T[5, 6] (MAP_EVERY ante_tac)
		THEN PC_T1 "sets_ext1" prove_tac[]));
a(LEMMA_T �C � B � C � C'� ante_tac THEN1
	(DROP_NTH_ASM_T 13 bc_thm_tac THEN REPEAT strip_tac));
a(LEMMA_T �D � B � D � C'� ante_tac THEN1
	(DROP_NTH_ASM_T 11 bc_thm_tac THEN REPEAT strip_tac));
a(REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(i_contr_tac THEN
	LIST_GET_NTH_ASM_T[1, 2, 8] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2" *** *)
a(�_tac�C'� THEN �_tac�B� THEN REPEAT strip_tac);
a(GET_NTH_ASM_T 9 ante_tac THEN PC_T1"sets_ext1" prove_tac[]);
(* *** Goal "2.3" *** *)
a(�_tac�B� THEN �_tac�C'� THEN REPEAT strip_tac);
(* *** Goal "2.4" *** *)
a(i_contr_tac THEN
	LIST_GET_NTH_ASM_T[1, 2, 7] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val finite_separation_thm = save_thm ( "finite_separation_thm", (
set_goal([], ��� U A�
	� � Topology
�	U � Finite
�	�{} � U
�	U � � Connected
�	A � U
�	(�B�B � U � �A = B � �A � B � � Connected)
�	�C D�	C � � � D � � 
	�	A � C � �(U \ {A}) � D
	�	�U � C � D = {}
�);
a(REPEAT strip_tac);
a(cases_tac��b�b � U � A = b�);
(* *** Goal "1" *** *)
a(�_tac�Space�T Ԯ THEN �_tac�{}�);
a(ALL_FC_T rewrite_tac[space_t_open_thm, empty_open_thm]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��x u t�x � u � u � t � x � t�]);
a(REPEAT strip_tac THEN1
	(POP_ASM_T ante_tac THEN rewrite_tac[connected_def]
	THEN PC_T1 "sets_ext1" prove_tac[]));
a(PC_T1"sets_ext1" REPEAT strip_tac
	THEN all_asm_fc_tac[] THEN all_var_elim_asm_tac1);
(* *** Goal "2" *** *)
a(lemma_tac��f��b�b � U � �A = b �
	Fst (f b) � � � Snd (f b) � � �
	A � Fst (f b) � b � Snd (f b) �
	(A � b) � Fst (f b) � Snd (f b) = {}�);
(* *** Goal "2.1" *** *)
a(prove_�_tac THEN REPEAT strip_tac);
a(cases_tac�b' � U � � A = b'� THEN asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T[3, 4, 5] all_fc_tac);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��x u t�x � u � u � t � x � t�]);
a(all_fc_tac[separation_thm]);
a(�_tac�(A', B)� THEN asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(�_tac��{X | �b�b � U � �A = b � X = Fst(f b)}�);
a(�_tac��{Y | �b�b � U � �A = b � Y = Snd(f b)}�);
a(REPEAT strip_tac);
(* *** Goal "2.2.1" *** *)
a(bc_thm_tac finite_�_open_thm THEN REPEAT strip_tac);
(* *** Goal "2.2.1.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
(* *** Goal "2.2.1.2" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN rewrite_tac[]);
a(�_tac�Fst(f b)� THEN �_tac�b� THEN REPEAT strip_tac);
(* *** Goal "2.2.1.3" *** *)
a(GET_NTH_ASM_T 8 ante_tac THEN DROP_ASMS_T discard_tac
	THEN REPEAT strip_tac THEN finite_induction_tac�U�);
(* *** Goal "2.2.1.3.1" *** *)
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]�{a|F} = {}�,
	empty_finite_thm]);
(* *** Goal "2.2.1.3.2" *** *)
a(cases_tac�A = x� THEN1 all_var_elim_asm_tac);
(* *** Goal "2.2.1.3.2.1" *** *)
a(LEMMA_T�{X|� b� b � {x} � U � � x = b � X = Fst (f b)}
            = {X|� b� b � U � � x = b � X = Fst (f b)}�
	asm_rewrite_thm_tac);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac
	THEN all_var_elim_asm_tac1);
(* *** Goal "2.2.1.3.2.1.1" *** *)
a(�_tac�b� THEN REPEAT strip_tac);
(* *** Goal "2.2.1.3.2.1.2" *** *)
a(�_tac�b� THEN REPEAT strip_tac);
(* *** Goal "2.2.1.3.2.2" *** *)
a(LEMMA_T�{X|� b� b � {x} � U � � A = b � X = Fst (f b)}
            = {Fst(f x)} � {X|� b� b � U � � A = b � X = Fst (f b)}�
	asm_rewrite_thm_tac THEN_LIST
	[id_tac,
	bc_thm_tac singleton_�_finite_thm
		THEN REPEAT strip_tac]);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac
	THEN all_var_elim_asm_tac1);
(* *** Goal "2.2.1.3.2.2.1" *** *)
a(�_tac�b� THEN REPEAT strip_tac);
(* *** Goal "2.2.1.3.2.2.2" *** *)
a(�_tac�x� THEN REPEAT strip_tac);
(* *** Goal "2.2.1.3.2.2.1" *** *)
a(�_tac�b� THEN REPEAT strip_tac);
(* *** Goal "2.2.2" *** *)
a(bc_thm_tac �_open_thm THEN REPEAT strip_tac);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
(* *** Goal "2.2.3" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
a(LIST_GET_NTH_ASM_T[10, 15] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2.4" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(POP_ASM_T (strip_asm_tac o conv_rule(RAND_C eq_sym_conv)));
a(all_asm_fc_tac[]);
a(�_tac�Snd(f s)� THEN REPEAT strip_tac);
(* *** Goal "2.2.4.1" *** *)
a(LIST_GET_NTH_ASM_T[9, 15] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2.4.2" *** *)
a(�_tac�s� THEN REPEAT strip_tac);
(* *** Goal "2.2.5" *** *)
a(PC_T "sets_ext1"  strip_tac THEN REPEAT strip_tac
	THEN all_var_elim_asm_tac1);
a(cases_tac�A = s� THEN1 (POP_ASM_T (asm_tac o eq_sym_rule) THEN all_var_elim_asm_tac1));
(* *** Goal "2.2.5.1" *** *)
a(LIST_DROP_NTH_ASM_T [6, 7, 8] all_asm_fc_tac);
a(LIST_GET_NTH_ASM_T[1, 3, 9, 11] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2.5.2" *** *)
a(DROP_NTH_ASM_T 5 (ante_tac o �_elim�Fst (f s)�));
a(asm_rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "2.2.5.2.1" *** *)
a(�_tac�s� THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2, 3, 7, 8, 9] all_asm_fc_tac);
a(LIST_GET_NTH_ASM_T[1, 2,  10] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val connected_extension_thm = save_thm ( "connected_extension_thm", (
set_goal([], ��� U B�
	� � Topology
�	U � Finite
�	�{} � U
�	U � � Connected
�	B � � Connected
�	�U � B � � Connected
�	��U � B
�	�A� A � U � A � B � � Connected � �A � B
�);
a(REPEAT strip_tac);
a(cases_tac�B = {}�);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 2 ante_tac THEN
	asm_rewrite_tac[] THEN PC_T "sets_ext1" strip_tac);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��x u t�x � u � u � t � x � t�]);
a(cases_tac�s = {}� THEN1 all_var_elim_asm_tac1);
a(�_tac�s� THEN REPEAT strip_tac);
a(POP_ASM_T ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2" *** *)
a(contr_tac);
a(PC_T1 "predicates" lemma_tac�
	{B} � ({C | C � U � �C � B}) � Finite
�	�{} � {B} � ({C | C � U � �C � B})
�	{B} � ({C | C � U � �C � B}) � � Connected
�	B � {B} � ({C | C � U � �C � B})
�	(� C� C � {B} � ({C | C � U � �C � B})
		� � B = C � � B � C � � Connected)�
	THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(bc_thm_tac singleton_�_finite_thm);
a(bc_thm_tac �_finite_thm THEN �_tac�U� THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(swap_nth_asm_concl_tac 2 THEN asm_rewrite_tac[]);
(* *** Goal "2.3" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac
	THEN1 asm_rewrite_tac[]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��x u t�x � u � u � t � x � t�]);
(* *** Goal "2.4" *** *)
a(all_var_elim_asm_tac1);
(* *** Goal "2.5" *** *)
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]
	��A�A � C = C � A�]);
a(contr_tac THEN spec_nth_asm_tac 5 �C�);
(* *** Goal "2.6" *** *)
a(all_fc_tac[finite_separation_thm]);
a(swap_nth_asm_concl_tac 14 THEN rewrite_tac[connected_def]
	THEN REPEAT strip_tac);
a(i_contr_tac THEN POP_ASM_T ante_tac);
a(rewrite_tac[] THEN strip_tac THEN
	�_tac�C� THEN asm_rewrite_tac[]);
a(strip_tac THEN �_tac�D� THEN asm_rewrite_tac[]);
a(lemma_tac �� ({B} �  {C|C � U � �C � B}) = �U � B�);
(* *** Goal "2.6.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
(* *** Goal "2.6.1.1" *** *)
a(all_var_elim_asm_tac);
(* *** Goal "2.6.1.2" *** *)
a(all_asm_fc_tac[]);
(* *** Goal "2.6.1.3" *** *)
a(cases_tac�x � B�  THEN1 (�_tac�B� THEN REPEAT strip_tac));
a(�_tac�s� THEN REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T[2, 4] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.6.1.4" *** *)
a(�_tac�B� THEN REPEAT strip_tac);
(* *** Goal "2.6.2" *** *)
a(DROP_NTH_ASM_T 2 ante_tac THEN asm_rewrite_tac[] THEN strip_tac);
a(asm_rewrite_tac[]);
a(LEMMA_T �� U � B � C � D� rewrite_thm_tac);
(* *** Goal "2.6.2.1" *** *)
a(LEMMA_T �� U � B = � (({B} � {C|C � U � � C � B}) \ {B}) � B� rewrite_thm_tac);
(* *** Goal "2.6.2.1.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
(* *** Goal "2.6.2.1.1.1" *** *)
a(swap_nth_asm_concl_tac 1 THEN REPEAT strip_tac);
a(�_tac�s� THEN REPEAT strip_tac);
(* *** Goal "2.6.2.1.1.1.1" *** *)
a(LIST_GET_NTH_ASM_T[2, 4] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.6.2.1.1.1.2" *** *)
a(contr_tac THEN all_var_elim_asm_tac1);
(* *** Goal "2.6.2.1.1.2" *** *)
a(all_asm_fc_tac[]);
(* *** Goal "2.6.2.1.2" *** *)
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��s v c d� v � c � s � d � s � v � c � d�]);
(* *** Goal "2.6.2.2" *** *)
a(contr_tac);
(* *** Goal "2.6.2.2.1" *** *)
a(LIST_DROP_NTH_ASM_T [1, 2, 3, 4, 15] (MAP_EVERY (PC_T1 "sets_ext1" strip_asm_tac)));
a(spec_nth_asm_tac 4 �x�);
(* *** Goal "2.6.2.2.1.1" *** *)
a(spec_nth_asm_tac 1 �s�);
(* *** Goal "2.6.2.2.1.1.1" *** *)
a(LIST_GET_NTH_ASM_T[1, 4, 6] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.6.2.2.1.1.2" *** *)
a(LIST_GET_NTH_ASM_T[1, 3, 5] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.6.2.2.1.2" *** *)
a(lemma_tac�x � C� THEN1 GET_NTH_ASM_T 8 bc_thm_tac THEN REPEAT strip_tac);
(* *** Goal "2.6.2.2.1.2.1" *** *)
a(spec_nth_asm_tac 1 �s�);
(* *** Goal "2.6.2.2.1.2.2" *** *)
a(spec_nth_asm_tac 8 �x�);
(* *** Goal "2.6.2.2.1.2.2.1" *** *)
a(spec_nth_asm_tac 1 �s�);
(* *** Goal "2.6.2.2.1.2.2.2" *** *)
a(spec_nth_asm_tac 3 �s'�);
(* *** Goal "2.6.2.2.2" *** *)
a(LIST_DROP_NTH_ASM_T [1, 2, 3, 4, 5, 14] (MAP_EVERY (PC_T1 "sets_ext1" strip_asm_tac)));
a(spec_nth_asm_tac 6 �x�);
a(spec_nth_asm_tac 3 �x�);
a(spec_nth_asm_tac 7 �x�);
pop_thm()
));


set_goal([], ��V A B�V � {A} � {B} � V = {} � V = {A} � V = {B} � V = {A} � {B}�);
a(PC_T1"sets_ext1"  rewrite_tac[]);
a(contr_tac THEN_TRY all_var_elim_asm_tac1
	THEN  asm_fc_tac[] THEN_TRY all_var_elim_asm_tac1);
val �_doubleton_lemma = pop_thm();

set_goal([], ��L B� B � Elems L � B � �(Elems L)�);
a(�_tac);
a(list_induction_tac�L� THEN asm_rewrite_tac[elems_def,
	enum_set_clauses,
	pc_rule1"sets_ext1" prove_rule[]
		��u v� �(u � v) = �u � � v�]);
a(REPEAT strip_tac THEN1 all_var_elim_asm_tac);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2" *** *)
a(all_asm_fc_tac[] THEN PC_T1 "sets_ext1" asm_prove_tac[]);
val �_�_elems_lemma = pop_thm();


set_goal([], � �� U A�
	� � Topology
�	U � Finite
�	�{} � U
�	U � � Connected
�	�U � � Connected
�	A � U
�	�L�	L 0 = [A]
�	(�m� 	Elems (L m) � U)
�	(�m� 	�(Elems (L m)) � � Connected)
�	(�m� 	if	��U � �(Elems (L m))
		then	�B�	B � U
			�	B � �(Elems (L m)) � � Connected
			�	�B � �(Elems (L m))
			�	L(m + 1) = Cons B (L m)
		else	L (m + 1) = L m)
�	(�m� 	L m � Distinct)
�);
a(REPEAT strip_tac);
a(once_rewrite_tac[taut_rule��p1 p2 p3 p4 p5�
	p1 � p2 � p3 � p4 � p5 �
	p1 � p2 � p3 � p4 � (p4 � p5)�]);
a(lemma_tac ��f�
	�V�
	if	V � � Connected
	�	V � �U
 	�	� � U � V
	then	f V � U
	�	f V � V � � Connected
	�	� f V � V
	else	f V = {}�
	THEN1 prove_�_tac);
(* *** Goal "1" *** *)
a(REPEAT strip_tac THEN
	cases_tac�V' � � Connected � V' � �U � � �U � V'�
	THEN asm_rewrite_tac[] THEN_TRY prove_�_tac);
a(bc_thm_tac connected_extension_thm THEN REPEAT strip_tac);
a(ALL_FC_T asm_rewrite_tac[pc_rule1"sets_ext1" prove_rule[]
	��u v� v � u � u � v = u�]);
(* *** Goal "2" *** *)
a(lemma_tac ��L�
	L 0  = [A]
�	�m� L (m + 1) =
		if 	�f(�(Elems(L m))) = {}
		then	Cons (f(�(Elems(L m)))) (L m)
		else	L m�
	THEN1 prove_�_tac);
a(lemma_tac�� m� Elems (L m) � U�);
(* *** Goal "2.1" *** *)
a(REPEAT strip_tac THEN induction_tac�m:�
	THEN asm_rewrite_tac[elems_def]);
(* *** Goal "2.1.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac
	THEN all_var_elim_asm_tac);
(* *** Goal "2.1.2" *** *)
a(cases_tac�f (� (Elems (L m))) = {}� THEN
	asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 5 (ante_tac o �_elim�� (Elems (L m))�));
a(cases_tac�� (Elems (L m)) � � Connected
	� � (Elems (L m)) � � U
	� � � U � � (Elems (L m))� THEN asm_rewrite_tac[]);
a(REPEAT strip_tac THEN asm_rewrite_tac[elems_def]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��x b c�x � c � b � c � {x} � b � c�]);
(* *** Goal "2.2" *** *)
a(lemma_tac�� m� � (Elems (L m)) � � Connected�);
(* *** Goal "2.2.1" *** *)
a(REPEAT strip_tac THEN induction_tac�m:�
	THEN asm_rewrite_tac[elems_def, enum_set_clauses]);
(* *** Goal "2.2.1.1" *** *)
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]
	��x b c�x � b � b � c � x � c�]);
(* *** Goal "2.2.1.2" *** *)
a(cases_tac�f (� (Elems (L m))) = {}� THEN
	asm_rewrite_tac[]);
a(rewrite_tac[elems_def,
	enum_set_clauses,
	pc_rule1"sets_ext1" prove_rule[]
		��u v� �(u � v) = �u � � v�]);
a(DROP_NTH_ASM_T 6 (ante_tac o �_elim�� (Elems (L m))�));
a(cases_tac�� (Elems (L m)) � � Connected
	� � (Elems (L m)) � � U
	� � � U � � (Elems (L m))� THEN asm_rewrite_tac[]);
a(taut_tac);
(* *** Goal "2.2.2" *** *)
a(�_tac�L� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.1" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "2.2.2.2" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "2.2.2.3" *** *)
a(DROP_NTH_ASM_T 6 (ante_tac o �_elim�� (Elems (L m))�));
a(lemma_tac�Elems(L m) � U� THEN asm_rewrite_tac[]);
a(ALL_FC_T asm_rewrite_tac[pc_rule1"sets_ext1" prove_rule[]
	��u v� v � u � �v � �u �]);
a(REPEAT strip_tac THEN �_tac�f (� (Elems (L m)))�
	THEN REPEAT strip_tac);
a(cases_tac�f (� (Elems (L m))) = {}� THEN
	asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 4 ante_tac THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2.4" *** *)
a(DROP_NTH_ASM_T 6 (ante_tac o �_elim�� (Elems (L m))�));
a(asm_rewrite_tac[]);
a(REPEAT strip_tac THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2.5" *** *)
a(induction_tac�m� THEN1
	asm_rewrite_tac[distinct_def, elems_def]);
a(DROP_NTH_ASM_T 2 (ante_tac o �_elim�m�));
a(cases_tac��U � �(Elems (L m))� THEN asm_rewrite_tac[]
	THEN REPEAT strip_tac THEN asm_rewrite_tac[]);
a(asm_rewrite_tac[distinct_def]);
a(swap_nth_asm_concl_tac 2);
a(all_fc_tac[�_�_elems_lemma]);
val connected_chain_lemma1 = pop_thm();

set_goal([], ��list x� �list = Cons x list�);
a(�_tac THEN conv_tac(ONCE_MAP_C eq_sym_conv));
a(list_induction_tac �list� THEN REPEAT strip_tac
	THEN asm_rewrite_tac[nil_cons_def]);
val cons_lemma = pop_thm();


val connected_chain_thm = save_thm ( "connected_chain_thm", (
set_goal([], � �� U A�
	� � Topology
�	U � Finite
�	�{} � U
�	U � � Connected
�	�U � � Connected
�	A � U
�	�L n�	L 0 = [A]
�	(�m� 	�(Elems (L m)) � � Connected)
�	(�m� 	Elems (L m) � U)
�	(�m� 	m < n
	�	�B�	B � U
		�	�B � �(Elems (L m))
		�	L(m + 1) = Cons B (L m))
�	�U = �(Elems (L n))
�	(�m� 	L m � Distinct)
�);
a(REPEAT strip_tac THEN all_fc_tac[connected_chain_lemma1]);
a(lemma_tac��N� L (N + 1) = L N� THEN1 contr_tac);
(* *** Goal "1" *** *)
a(lemma_tac��m�#(L m) = m + 1� THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(induction_tac�m� THEN1 asm_rewrite_tac[length_def]);
a(DROP_NTH_ASM_T 4 (ante_tac o �_elim�m�));
a(cases_tac �� U � � (Elems (L m))� THEN asm_rewrite_tac[]);
a(REPEAT strip_tac THEN asm_rewrite_tac[length_def]);
(* *** Goal "1.2" *** *)
a(LEMMA_T�#(Elems(L (#U))) = #(L (#U))� ante_tac THEN1
	(bc_thm_tac distinct_size_length_thm
		THEN asm_rewrite_tac[]));
a(asm_rewrite_tac[]);
a(LEMMA_T�#(Elems(L (#U))) � #U� ante_tac THEN1
	(bc_thm_tac �_size_thm THEN asm_rewrite_tac[]));
a(PC_T1 "lin_arith" prove_tac[]);
(* *** Goal "2" *** *)
a(�_tac�L� THEN �_tac�Min{n | L(n+1) = L n}�);
a(asm_rewrite_tac[]);
a(REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(DROP_NTH_ASM_T 4 (ante_tac o �_elim�m�));
a(cases_tac�� � U � � (Elems (L m))� THEN asm_rewrite_tac[]
	THEN1 prove_tac[]);
a(strip_tac THEN i_contr_tac);
a(lemma_tac �Min {n|L (n + 1) = L n} � m� THEN_LIST
	[bc_thm_tac min_�_thm, PC_T1 "lin_arith" asm_prove_tac[]]);
a(REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(lemma_tac��m��(Elems(L m)) � �U� THEN1
	(strip_tac THEN bc_thm_tac
	(pc_rule1 "sets_ext1" prove_rule[]
		��v u�v � u � �v � �u�) THEN
			asm_rewrite_tac[]));
a(asm_rewrite_tac[pc_rule1 "sets_ext1" prove_rule[]
		��a b� a = b � a � b � b � a�]);
a(contr_tac);
a(lemma_tac�Min {n|L(n + 1) = L n} � {n|L(n + 1) = L n}� THEN1
	(bc_thm_tac min_�_thm THEN
		�_tac�N� THEN REPEAT strip_tac));
a(DROP_NTH_ASM_T 6 (ante_tac o �_elim�Min {n|L (n + 1) = L n}�)
	THEN asm_rewrite_tac[cons_lemma]);
pop_thm()
));


val connected_triad_thm = save_thm ( "connected_triad_thm", (
set_goal([],��� A B C�
	� � Topology
�	A � � Connected
�	B � � Connected
�	C � � Connected
�	A � B � C � � Connected
�	A � C � � Connected � B � C � � Connected�);
a(contr_tac);
a(swap_nth_asm_concl_tac 3 THEN rewrite_tac[connected_def] THEN strip_tac);
a(�_right_tac THEN conv_tac (TOP_MAP_C �_�_conv));
a(all_fc_tac[separation_thm]);
a(�_tac�A'' � A'� THEN �_tac�B'' � B'�);
a(ALL_FC_T rewrite_tac[�_open_thm, �_open_thm]);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LIST_GET_NTH_ASM_T [1, 2, 6, 7] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2" *** *)
a(LIST_GET_NTH_ASM_T [1, 2, 3, 6, 7, 8] (MAP_EVERY ante_tac)
	THEN DROP_ASMS_T discard_tac
	THEN PC_T1 "sets_ext1" prove_tac[]
	THEN REPEAT (contr_tac THEN all_asm_fc_tac[]));
(* *** Goal "3" *** *)
a(contr_tac THEN lemma_tac�C � A'' � A'� THEN1
	(POP_ASM_T ante_tac THEN  PC_T1 "sets_ext1" prove_tac[]));
a(cases_tac �C = {}� THEN1 all_var_elim_asm_tac1);
(* *** Goal "3.1" *** *)
a(swap_nth_asm_concl_tac 10 THEN1 asm_rewrite_tac[]);
(* *** Goal "3.2" *** *)
a((LIST_GET_NTH_ASM_T [1, 2, 4, 6, 9, 11] (MAP_EVERY ante_tac)
		THEN DROP_ASMS_T  discard_tac
		THEN PC_T "sets_ext1" contr_tac));
a(LIST_DROP_NTH_ASM_T [2, 3, 4, 5, 6] (MAP_EVERY (strip_asm_tac o �_elim�x�)));
(* *** Goal "4" *** *)
a(contr_tac THEN lemma_tac�A � B''� THEN1
	(POP_ASM_T ante_tac THEN  PC_T1 "sets_ext1" prove_tac[]));
a(cases_tac �A = {}� THEN1 all_var_elim_asm_tac1);
(* *** Goal "4.1" *** *)
a(swap_nth_asm_concl_tac 12 THEN1 asm_rewrite_tac[]);
(* *** Goal "4.2" *** *)
a((LIST_GET_NTH_ASM_T [1, 2, 5, 6] (MAP_EVERY ante_tac)
		THEN DROP_ASMS_T  discard_tac
		THEN PC_T "sets_ext1" contr_tac));
a(LIST_DROP_NTH_ASM_T [2, 3, 4] (MAP_EVERY (strip_asm_tac o �_elim�x�)));
pop_thm()
));



val connected_step_thm = save_thm ( "connected_step_thm", (
set_goal([], � �� U; A: 'a SET�
	� � Topology
�	U � Finite
�	U � � Connected
�	�U � � Connected
�	A � U
�	A = �U
�	�B V�
	B  � U
�	�B = A
�	V � U
�	�V � � Connected
�	�B � �V
�	�U = B � �V
�);
a(REPEAT strip_tac THEN
	PC_T1 "predicates" lemma_tac�
	U \  {{}:'a SET}� Finite
�	�{} � U \  {{}}
�	U  \  {{}} � � Connected
�	�(U \ {{}}) = �U� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac �_finite_thm THEN �_tac�U� THEN REPEAT strip_tac);
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��a b�a \ b � a�]);
(* *** Goal "2" *** *)
a(bc_tac[pc_rule1"sets_ext1" prove_rule[]��a b c�a � b � b � c � a � c�]
	 THEN �_tac�U� THEN REPEAT strip_tac);
a(rewrite_tac[pc_rule1"sets_ext1" prove_rule[]��a b�a \ b � a�]);
(* *** Goal "3" *** *)
a(PC_T "sets_ext1" strip_tac THEN prove_tac[]);
a(�_tac�s� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(�_tac�x� THEN REPEAT strip_tac);
(* *** Goal "4" *** *)
a(lemma_tac��(U \ {{}}) � � Connected� THEN1 asm_rewrite_tac[]);
a(cases_tac�A = {}�  THEN1 all_var_elim_asm_tac1);
(* *** Goal "4.1" *** *)
a(DROP_NTH_ASM_T 6 (PC_T1 "sets_ext1" strip_asm_tac));
a(PC_T1 "predicates" all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��x�x � s � s � U � s � U \ {{}}�]);
a(all_fc_tac[connected_chain_thm]);
a(strip_asm_tac(�_elim�n� �_cases_thm)
	THEN all_var_elim_asm_tac1);
(* *** Goal "4.1.1" *** *)
a(�_tac�s� THEN �_tac�{}� THEN
	ALL_FC_T asm_rewrite_tac[enum_set_clauses,
			empty_connected_thm]);
a(DROP_NTH_ASM_T 2 ante_tac THEN asm_rewrite_tac[elems_def,
		enum_set_clauses]);
a(REPEAT strip_tac THEN
	GET_ASM_T �x � s� ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "4.1.2" *** *)
a(DROP_NTH_ASM_T 3 (strip_asm_tac o �_elim�i�));
a(�_tac�B� THEN �_tac�Elems(L i)� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 6 ante_tac THEN asm_rewrite_tac[
	pc_rule1"sets_ext1" prove_rule[]
		��u v��(u � v) = �u � � v�,
	elems_def, enum_set_clauses]);
a(REPEAT strip_tac);
a(bc_tac[pc_rule1"sets_ext1" prove_rule[]��a b c�a � b � b � c � a � c�]
	 THEN �_tac�U \ {{}}� THEN asm_rewrite_tac[]);
a(PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "4.2" *** *)
a(PC_T1 "predicates" lemma_tac�A � U \ {{}}� THEN1
	REPEAT strip_tac);
a(all_fc_tac[connected_chain_thm]);
a(strip_asm_tac(�_elim�n� �_cases_thm)
	THEN all_var_elim_asm_tac1);
(* *** Goal "4.2.1" *** *)
a(i_contr_tac THEN DROP_NTH_ASM_T 2 ante_tac);
a(asm_rewrite_tac[elems_def, enum_set_clauses]);
a(contr_tac THEN all_var_elim_asm_tac1);
(* *** Goal "4.2.2" *** *)
a(GET_NTH_ASM_T 3 (strip_asm_tac o �_elim�i�));
a(�_tac�B� THEN �_tac�Elems(L i)� THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 6 ante_tac THEN asm_rewrite_tac[
	pc_rule1"sets_ext1" prove_rule[]
		��u v��(u � v) = �u � � v�,
	elems_def, enum_set_clauses]);
a(REPEAT strip_tac);
(* *** Goal "4.2.2.1" *** *)
a(contr_tac THEN all_var_elim_asm_tac);
a(GET_NTH_ASM_T 4 (ante_tac o �_elim�i + 1�));
a(GET_NTH_ASM_T 2 rewrite_thm_tac);
a(asm_rewrite_tac[distinct_def]);
a(LIST_DROP_NTH_ASM_T [5, 8] (MAP_EVERY ante_tac));
a(DROP_ASMS_T discard_tac THEN induction_tac�i�
	THEN REPEAT strip_tac
	THEN_TRY asm_rewrite_tac[elems_def]);
(* *** Goal "4.2.2.1.1" *** *)
a(i_contr_tac THEN SPEC_NTH_ASM_T 1 �m'� ante_tac);
a(LEMMA_T �m' < (i + 1) + 1� rewrite_thm_tac THEN1
	PC_T1 "lin_arith" asm_prove_tac[]);
a(conv_tac �_�_conv THEN asm_rewrite_tac[]);
(* *** Goal "4.2.2.1.2" *** *)
a(SPEC_NTH_ASM_T 1 �i� ante_tac);
a(LEMMA_T �i < (i + 1) + 1� rewrite_thm_tac THEN1
	PC_T1 "lin_arith" prove_tac[]);
a(REPEAT strip_tac THEN asm_rewrite_tac[elems_def]
	THEN REPEAT strip_tac);
(* *** Goal "4.2.2.2" *** *)
a(bc_tac[pc_rule1"sets_ext1" prove_rule[]��a b c�a � b � b � c � a � c�]
	 THEN �_tac�U \ {{}}� THEN asm_rewrite_tac[]);
a(PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val id_homomorphism_thm = save_thm ( "id_homomorphism_thm", (
set_goal([], ��Է
	� � Topology
�	(�x� x) � (�, �) Homeomorphism�);
a(rewrite_tac [homeomorphism_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ALL_FC_T rewrite_tac[id_continuous_thm]);
(* *** Goal "2" *** *)
a(�_tac��y� y�);
a(ALL_FC_T rewrite_tac[id_continuous_thm]);
pop_thm()
));


val comp_homeomorphism_thm = save_thm ( "comp_homeomorphism_thm", (
set_goal([], ��f g � � Է
	f � (�, �) Homeomorphism
�	g � (�, �) Homeomorphism
�	� � Topology
�	� � Topology
�	� � Topology
�	(�x� g(f x)) � (�, �) Homeomorphism
�);
a(rewrite_tac [homeomorphism_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ALL_FC_T rewrite_tac [comp_continuous_thm]);
(* *** Goal "2" *** *)
a(�_tac��y� g'(g'' y)�);
a(ALL_FC_T rewrite_tac [comp_continuous_thm]);
a(all_asm_ante_tac THEN rewrite_tac[continuous_def] THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(all_asm_fc_tac[] THEN ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(all_asm_fc_tac[] THEN ALL_ASM_FC_T rewrite_tac[]);
pop_thm()
));


val product_homeomorphism_thm = save_thm ( "product_homeomorphism_thm", (
set_goal([], �� f : 'a � 'b; g : 'c � 'd; � : 'a SET SET; � : 'b SET SET; � : 'c SET SET; � : 'd SET SET�
	f � (�, �) Homeomorphism
�	g � (�, �) Homeomorphism
�	� � Topology
�	� � Topology
�	� � Topology
�	� � Topology
�	(�(x, y)�(f x, g y)) � ((� ��T �), (� ��T �)) Homeomorphism
�);
a(rewrite_tac [homeomorphism_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LEMMA_T �
	(� (x, y)� (f x, g y)) = (�z�( (�z�f((�(x, y)� x) z)) z, (�z�g((�(x, y)� y) z)) z))�
	pure_rewrite_thm_tac THEN1 rewrite_tac[]);
a(bc_thm_tac product_continuous_thm);
a(ALL_FC_T pure_asm_rewrite_tac[product_topology_thm]);
a(REPEAT strip_tac THEN bc_thm_tac comp_continuous_thm);
(* *** Goal "1.1" *** *)
a(�_tac�Ү THEN REPEAT strip_tac
	THEN ALL_FC_T rewrite_tac[left_proj_continuous_thm, right_proj_continuous_thm,
		product_topology_thm]);
(* *** Goal "1.2" *** *)
a(�_tac�Ԯ THEN REPEAT strip_tac
	THEN ALL_FC_T rewrite_tac [left_proj_continuous_thm, right_proj_continuous_thm,
		product_topology_thm]);
(* *** Goal "2" *** *)
a(�_tac��(x, y)� (g' x, g'' y)�);
a(ALL_FC_T pure_rewrite_tac[product_topology_space_t_thm] THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(LEMMA_T �
	(� (x, y)� (g' x, g'' y)) = (�z�( (�z�g'((�(x, y)� x) z)) z, (�z�g''((�(x, y)� y) z)) z))�
	pure_rewrite_thm_tac THEN1 rewrite_tac[]);
a(bc_thm_tac product_continuous_thm);
a(ALL_FC_T pure_asm_rewrite_tac[product_topology_thm]);
a(REPEAT strip_tac THEN bc_thm_tac comp_continuous_thm);
(* *** Goal "2.1.1" *** *)
a(�_tac�Ӯ THEN REPEAT strip_tac
	THEN ALL_FC_T rewrite_tac [left_proj_continuous_thm, right_proj_continuous_thm,
		product_topology_thm]);
(* *** Goal "2.1.2" *** *)
a(�_tac�ծ THEN REPEAT strip_tac
	THEN ALL_FC_T rewrite_tac[left_proj_continuous_thm, right_proj_continuous_thm,
		product_topology_thm]);
(* *** Goal "2.2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[�_def]);
a(REPEAT strip_tac THEN ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "2.3" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[�_def]);
a(REPEAT strip_tac THEN ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "2.4" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[�_def]);
a(REPEAT strip_tac THEN ALL_ASM_FC_T rewrite_tac[]);
pop_thm()
));



val product_unit_homeomorphism_thm = save_thm ( "product_unit_homeomorphism_thm", (
set_goal([], ��Է
	� � Topology
�	(�x�(x, One)) � (�, � ��T 1�T) Homeomorphism
�);
a(rewrite_tac [homeomorphism_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(basic_continuity_tac[unit_topology_thm,
	range_unit_topology_continuous_thm,
	space_t_unit_topology_thm]);
(* *** Goal "2" *** *)
a(�_tac�Fst� THEN rewrite_tac[one_def]);
a(basic_continuity_tac[unit_topology_thm]);
pop_thm()
));


val swap_homeomorphism_thm = save_thm ("swap_homeomorphism_thm", (
set_goal([], ��� Է
	� � Topology
�	� � Topology
�	(�(x, y)�(y, x)) � (� ��T �, � ��T �) Homeomorphism
�);
a(rewrite_tac [homeomorphism_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(basic_continuity_tac[]);
(* *** Goal "2" *** *)
a(�_tac�(�(y, x)�(x, y))� THEN rewrite_tac[]);
a(basic_continuity_tac[]);
pop_thm()
));


val homeomorphism_open_mapping_thm = save_thm ( "homeomorphism_open_mapping_thm", (
set_goal([], ��f � � A�
	f � (�, �) Homeomorphism
�	A � �
�	� � Topology
�	� � Topology
�	{y | �x� x � A � y = f x} � �
�);
a(rewrite_tac [homeomorphism_def, continuous_def] THEN REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T [6] all_fc_tac);
a(LEMMA_T � {y|� x� x � A � y = f x} = {x|x � Space�T � � g x � A}� asm_rewrite_thm_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_var_elim_asm_tac1);
a(GET_NTH_ASM_T 11 bc_thm_tac);
a(ALL_FC_T rewrite_tac[�_space_t_thm]);
(* *** Goal "2" *** *)
a(all_var_elim_asm_tac1);
a(all_fc_tac[�_space_t_thm]);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(�_tac�g x� THEN REPEAT strip_tac);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
pop_thm()
));



val homeomorphism_closed_mapping_thm = save_thm ( "homeomorphism_closed_mapping_thm", (
set_goal([], ��f � � A�
	f � (�, �) Homeomorphism
�	A � � Closed
�	� � Topology
�	� � Topology
�	{y | �x� x � A � y = f x} � � Closed
�);
a(rewrite_tac [homeomorphism_def, continuous_closed_thm] THEN REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T [6] all_fc_tac);
a(LEMMA_T � {y|� x� x � A � y = f x} = {x|x � Space�T � � g x � A}� asm_rewrite_thm_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_var_elim_asm_tac1);
a(GET_NTH_ASM_T 11 bc_thm_tac);
a(ALL_FC_T rewrite_tac[�_closed_�_space_t_thm]);
(* *** Goal "2" *** *)
a(all_var_elim_asm_tac1);
a(all_fc_tac[�_closed_�_space_t_thm]);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(�_tac�g x� THEN REPEAT strip_tac);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
pop_thm()
));


val homeomorphism_one_one_thm = save_thm ( "homeomorphism_one_one_thm", (
set_goal([], ��f � � x y�
	f � (�, �) Homeomorphism
�	� � Topology
�	� � Topology
�	x � Space�T � � y � Space�T �
�	f x = f y
�	x = y
�);
a(rewrite_tac [homeomorphism_def] THEN REPEAT strip_tac);
a(LEMMA_T �g(f x) = g(f y)� ante_tac THEN1 asm_rewrite_tac[]);
a(ALL_ASM_FC_T rewrite_tac[]);
pop_thm()
));


val homeomorphism_onto_thm = save_thm ( "homeomorphism_onto_thm", (
set_goal([], ��f � � y�
	f � (�, �) Homeomorphism
�	� � Topology
�	� � Topology
�	y � Space�T �
�	�x�x � Space�T � � y = f x
�);
a(rewrite_tac [homeomorphism_def, continuous_def] THEN REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T[7] all_fc_tac);
a(�_tac�g y� THEN REPEAT strip_tac);
a(ALL_ASM_FC_T rewrite_tac[]);
pop_thm()
));


val homeomorphism_one_one_open_mapping_thm = save_thm ( "homeomorphism_one_one_open_mapping_thm", (
set_goal([], ��f � Է
	� � Topology
�	� � Topology
�	(	f � (�, �) Homeomorphism
	�	(�x y� x � Space�T � � y � Space�T � � f x = f y � x = y)
	�	(�y� y � Space�T � � �x�x � Space�T � � y = f x)
	�	f � (�, �) Continuous
	�	(�A�A � � � {y | �x� x � A � y = f x} � �))
�);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_fc_tac[homeomorphism_one_one_thm]);
(* *** Goal "2" *** *)
a(bc_thm_tac homeomorphism_onto_thm);
a(�_tac�Ԯ THEN REPEAT strip_tac);
(* *** Goal "3" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac [homeomorphism_def] THEN REPEAT strip_tac);
(* *** Goal "4" *** *)
a(all_fc_tac[homeomorphism_open_mapping_thm]);
(* *** Goal "5" *** *)
a(rewrite_tac[homeomorphism_def] THEN REPEAT strip_tac);
a(lemma_tac��g��y�y � Space�T � � g y � Space�T � � y = f(g y)� THEN1 prove_�_tac);
(* *** Goal "5.1" *** *)
a(REPEAT strip_tac THEN cases_tac �y' � Space�T Ԯ THEN asm_rewrite_tac[]);
a(GET_NTH_ASM_T 4 bc_thm_tac THEN REPEAT strip_tac);
(* *** Goal "5.2" *** *)
a(�_tac�g� THEN rewrite_tac[continuous_def] THEN REPEAT strip_tac);
(* *** Goal "5.2.1" *** *)
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "5.2.2" *** *)
a(LIST_GET_NTH_ASM_T [3] all_fc_tac);
a(LEMMA_T�{x|x � Space�T � � g x � A} = {y|� x� x � A � y = f x}� asm_rewrite_thm_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "5.2.2.1" *** *)
a(�_tac�g x� THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
(* *** Goal "5.2.2.2" *** *)
a(all_var_elim_asm_tac1);
a(all_fc_tac[�_space_t_thm]);
a(GET_NTH_ASM_T 9 ante_tac THEN rewrite_tac[continuous_def] THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
(* *** Goal "5.2.2.3" *** *)
a(all_var_elim_asm_tac1);
a(all_fc_tac[�_space_t_thm]);
a(LEMMA_T�g(f x') = x'� asm_rewrite_thm_tac);
a(GET_NTH_ASM_T 9 ante_tac THEN rewrite_tac[continuous_def] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [9] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [14] all_fc_tac);
a(conv_tac eq_sym_conv THEN REPEAT strip_tac);
(* *** Goal "5.2.3" *** *)
a(GET_NTH_ASM_T 4 ante_tac THEN rewrite_tac[continuous_def] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [9] all_fc_tac);
a(conv_tac eq_sym_conv THEN REPEAT strip_tac);
(* *** Goal "5.2.4" *** *)
a(LIST_DROP_NTH_ASM_T [5] all_fc_tac);
a(all_var_elim_asm_tac1);
a(LEMMA_T�g(f x) = x� asm_rewrite_thm_tac);
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [7] all_fc_tac);
a(conv_tac eq_sym_conv THEN REPEAT strip_tac);
pop_thm()
));



val homeomorphism_one_one_closed_mapping_thm = save_thm ( "homeomorphism_one_one_closed_mapping_thm", (
set_goal([], ��f � Է
	� � Topology
�	� � Topology
�	(	f � (�, �) Homeomorphism
	�	(�x y� x � Space�T � � y � Space�T � � f x = f y � x = y)
	�	(�y� y � Space�T � � �x�x � Space�T � � y = f x)
	�	f � (�, �) Continuous
	�	(�A�A � � Closed � {y | �x� x � A � y = f x} � � Closed))
�);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_fc_tac[homeomorphism_one_one_thm]);
(* *** Goal "2" *** *)
a(bc_thm_tac homeomorphism_onto_thm);
a(�_tac�Ԯ THEN REPEAT strip_tac);
(* *** Goal "3" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac [homeomorphism_def] THEN REPEAT strip_tac);
(* *** Goal "4" *** *)
a(all_fc_tac[homeomorphism_closed_mapping_thm]);
(* *** Goal "5" *** *)
a(rewrite_tac[homeomorphism_def] THEN REPEAT strip_tac);
a(lemma_tac��g��y�y � Space�T � � g y � Space�T � � y = f(g y)� THEN1 prove_�_tac);
(* *** Goal "5.1" *** *)
a(REPEAT strip_tac THEN cases_tac �y' � Space�T Ԯ THEN asm_rewrite_tac[]);
a(GET_NTH_ASM_T 4 bc_thm_tac THEN REPEAT strip_tac);
(* *** Goal "5.2" *** *)
a(�_tac�g� THEN rewrite_tac[continuous_closed_thm] THEN REPEAT strip_tac);
(* *** Goal "5.2.1" *** *)
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "5.2.2" *** *)
a(LIST_GET_NTH_ASM_T [3] all_fc_tac);
a(LEMMA_T�{x|x � Space�T � � g x � A} = {y|� x� x � A � y = f x}� asm_rewrite_thm_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "5.2.2.1" *** *)
a(�_tac�g x� THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
(* *** Goal "5.2.2.2" *** *)
a(all_var_elim_asm_tac1);
a(all_fc_tac[�_closed_�_space_t_thm]);
a(GET_NTH_ASM_T 7 ante_tac THEN rewrite_tac[continuous_def] THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
(* *** Goal "5.2.2.3" *** *)
a(all_var_elim_asm_tac1);
a(all_fc_tac[�_closed_�_space_t_thm]);
a(LEMMA_T�g(f x') = x'� asm_rewrite_thm_tac);
a(GET_NTH_ASM_T 7 ante_tac THEN rewrite_tac[continuous_def] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [7] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [12] all_fc_tac);
a(conv_tac eq_sym_conv THEN REPEAT strip_tac);
(* *** Goal "5.2.3" *** *)
a(GET_NTH_ASM_T 4 ante_tac THEN rewrite_tac[continuous_def] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [9] all_fc_tac);
a(conv_tac eq_sym_conv THEN REPEAT strip_tac);
(* *** Goal "5.2.4" *** *)
a(LIST_DROP_NTH_ASM_T [5] all_fc_tac);
a(all_var_elim_asm_tac1);
a(LEMMA_T�g(f x) = x� asm_rewrite_thm_tac);
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [7] all_fc_tac);
a(conv_tac eq_sym_conv THEN REPEAT strip_tac);
pop_thm()
));


val �_compact_homeomorphism_thm = save_thm ( "�_compact_homeomorphism_thm", (
set_goal([], ��f � � B C�
	� � Topology
�	� � Hausdorff
�	� � Topology
�	� � Hausdorff
�	C � � Compact
�	B � C
�	f � (�, �) Continuous
�	(�x y� x � B � y � C � f x = f y � x = y)
�	f � (B �T �, {y | �x� x � B � y = f x} �T �) Homeomorphism
�);
a(REPEAT strip_tac);
a(lemma_tac�B �T � � Topology � {y | �x� x � B � y = f x} �T � � Topology�
	THEN1 (REPEAT strip_tac THEN basic_topology_tac[]));
a(ALL_FC_T1 fc_�_canon rewrite_tac[homeomorphism_one_one_closed_mapping_thm]);
a(all_fc_tac[compact_closed_thm]);
a(lemma_tac�C � Space�T Ӯ THEN1 all_fc_tac[closed_open_neighbourhood_thm]);
a(all_fc_tac[pc_rule1"sets_ext1" prove_rule[]��b c s�b � c � c � s � b � s�]);
a(lemma_tac�{y|� x� x � B � y = f x} � Space�T Ԯ);
(* *** Goal "1" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN all_var_elim_asm_tac1);
a(DROP_NTH_ASM_T 8 (bc_thm_tac o �_left_elim o rewrite_rule[continuous_def]));
a(LIST_DROP_NTH_ASM_T [2] (PC_T1"sets_ext1" all_fc_tac));
(* *** Goal "2" *** *)
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm1]);
a(REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(DROP_NTH_ASM_T 10 bc_thm_tac THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [11] (PC_T1"sets_ext1" all_fc_tac));
(* *** Goal "2.2" *** *)
a(bc_thm_tac subspace_continuous_thm THEN asm_rewrite_tac[]);
a(prove_tac[]);
(* *** Goal "2.3" *** *)
a(POP_ASM_T ante_tac);
a(ALL_FC_T rewrite_tac[subspace_topology_closed_thm] THEN strip_tac);
a(rename_tac[(�B'�, "D")] THEN all_var_elim_asm_tac1);
a(lemma_tac�D � C � � Closed� THEN1 all_fc_tac[�_closed_thm]);
a(lemma_tac�D � C � C� THEN1 PC_T1 "sets_ext1" prove_tac[]);
a(all_fc_tac[closed_�_compact_thm]);
a(DROP_NTH_ASM_T 14 discard_tac THEN all_fc_tac[image_compact_thm]);
a(DROP_NTH_ASM_T 2 discard_tac THEN all_fc_tac[compact_closed_thm]);
a(�_tac�{y|� x� x � D � C � y = f x}� THEN REPEAT strip_tac);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac
	THEN all_var_elim_asm_tac1);
(* *** Goal "2.3.1" *** *)
a(�_tac�x'� THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [1, 16] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.3.2" *** *)
a(�_tac�x'� THEN REPEAT strip_tac);
(* *** Goal "2.3.3" *** *)
a(POP_ASM_T (strip_asm_tac o eq_sym_rule));
a(LIST_DROP_NTH_ASM_T [16] all_fc_tac THEN all_var_elim_asm_tac);
a(�_tac�x'� THEN REPEAT strip_tac);
pop_thm()
));




val interior_boundary_�_space_t_thm = save_thm ( "interior_boundary_�_space_t_thm", (
set_goal([], ��� A�
	� Interior A � Space�T �
�	� Boundary A � Space�T �
�);
a(rewrite_tac [interior_def, boundary_def] THEN REPEAT strip_tac THEN_LIST
	[PC_T1 "sets_ext1" prove_tac[space_t_def],
	 PC_T1 "sets_ext1" prove_tac[]]);
pop_thm()
));


val interior_�_thm = save_thm ( "interior_�_thm", (
set_goal([], ��� A�
	� Interior A � A
�);
a(rewrite_tac [interior_def] THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val boundary_interior_thm = save_thm ( "boundary_interior_thm", (
set_goal([], ��� A�
	� � Topology
�	� Boundary A = Space�T � \ (� Interior A � � Interior (Space�T � \ A))
�);
a(rewrite_tac [interior_def, boundary_def] THEN PC_T "sets_ext1" contr_tac);
(* *** Goal "1" *** *)
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(DROP_NTH_ASM_T 4 (strip_asm_tac o �_elim�B�));
a(swap_nth_asm_concl_tac 1 THEN PC_T1 "sets_ext1" REPEAT strip_tac
	THEN all_asm_fc_tac[�_space_t_thm]);
(* *** Goal "4" *** *)
a(DROP_NTH_ASM_T 5 (strip_asm_tac o �_elim�B�));
a(PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val interior_�_thm = save_thm ( "interior_�_thm", (
set_goal([], ��� � A B �
	(� ��T �) Interior (A � B) = (� Interior A � � Interior B)
�);
a(REPEAT strip_tac THEN PC_T "sets_ext1" strip_tac);
a(rewrite_tac[product_topology_def, interior_def, �_def]
	THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LIST_DROP_NTH_ASM_T [3] (PC_T1 "sets_ext1" all_fc_tac));
a(�_tac�A'� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [3] (PC_T1 "sets_ext1" all_fc_tac));
a(�_tac�B''� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(all_asm_fc_tac[]);
(* *** Goal "3" *** *)
a(�_tac �B' � B''� THEN rewrite_tac[�_def] THEN
	PC_T1 "sets_ext1" REPEAT strip_tac
	THEN_TRY (SOLVED_T (all_asm_fc_tac[])));
a(�_tac�B'� THEN �_tac�B''� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
pop_thm()
));


val open_�_disjoint_boundary_thm = save_thm ( "open_�_disjoint_boundary_thm", (
set_goal([], ��� A �
	� � Topology
�	(A � � � A � Space�T � � A � � Boundary A = {})
�);
a(REPEAT �_tac THEN �_tac);
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]);
a(rewrite_tac[boundary_def] THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(all_fc_tac[�_space_t_thm]);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(LIST_GET_NTH_ASM_T [3] all_fc_tac);
a(DROP_NTH_ASM_T 3 (strip_asm_tac o �_elim�x�)
	THEN_TRY SOLVED_T (PC_T1 "sets_ext1" asm_prove_tac[]));
a(�_tac�B� THEN PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val closed_�_boundary_�_thm = save_thm ( "closed_�_boundary_�_thm", (
set_goal([], ��� A �
	� � Topology
�	(A � � Closed � A � Space�T � � � Boundary A � A)
�);
a(REPEAT �_tac THEN �_tac);
a(ALL_FC_T1 fc_�_canon rewrite_tac[boundary_interior_thm,
	closed_open_complement_thm,
	open_�_disjoint_boundary_thm]);
a(rewrite_tac[taut_rule��p q r� (p � q � p � r) � (p � (q � r))�]);
a(�_tac THEN LEMMA_T �Space�T � \ A � Space�T � �
		Space�T � \ (Space�T � \ A) = A� rewrite_thm_tac
	THEN1 PC_T1 "sets_ext1" asm_prove_tac[]);
a(lemma_tac�� Interior (Space�T � \ A) � Space�T � \ A � � Interior A � A�
	THEN1 rewrite_tac[interior_�_thm]);
a(all_asm_ante_tac THEN PC_T1 "sets_ext1" rewrite_tac[]
	THEN contr_tac
	THEN(asm_fc_tac[] THEN asm_fc_tac[]));
pop_thm()
));


val interior_�_thm = save_thm ( "interior_�_thm", (
set_goal([], ��� A �
	� � Topology
�	� Interior A = �{B | B � � � B � A}
�);
a(REPEAT strip_tac THEN rewrite_tac[interior_def]);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
pop_thm()
));


val closure_interior_complement_thm = save_thm ( "closure_interior_complement_thm", (
set_goal([], ��� A �
	� � Topology
�	� Closure A = Space�T � \ � Interior (Space�T � \ A)
�);
a(REPEAT strip_tac);
a(rewrite_tac[closure_def]);
a(ALL_FC_T1 fc_�_canon rewrite_tac[closed_open_complement_thm, interior_�_thm]);
a(PC_T1 "sets_ext1" rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_fc_tac[empty_open_thm]);
a(DROP_NTH_ASM_T 2 bc_thm_tac THEN prove_tac[]);
(* *** Goal "2" *** *)
a(bc_thm_tac (pc_rule1 "sets_ext1" prove_rule[] �x � Space�T � \ s � �x � s�));
a(�_tac�Ԯ THEN DROP_NTH_ASM_T 3 bc_thm_tac);
a(asm_prove_tac[]);
a(LEMMA_T �Space�T � \ (Space�T � \ s) = s� asm_rewrite_thm_tac);
a(PC_T1 "sets_ext1" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(spec_nth_asm_tac 4 �Space�T � \ s�);
a(spec_nth_asm_tac 4 �x'�);
pop_thm()
));



val unique_lifting_lemma1 = (* not saved *) snd ( "unique_lifting_lemma1", (
set_goal([], ��� � �; p:'b � 'c; f g : 'a � 'b �
	� � Topology
�	� � Topology
�	� � Topology
�	p � (�, �) CoveringProjection
�	f � (�, �) Continuous
�	g � (�, �) Continuous
�	(�x� x � Space�T � � p(f x) = p(g x))
�	{x | x � Space�T � � g x = f x} � �
�);
a(rewrite_tac[covering_projection_def] THEN REPEAT strip_tac);
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]);
a(REPEAT strip_tac);
a(lemma_tac�f x � Space�T Ӯ THEN1 all_fc_tac[continuous_�_space_t_thm]);
a(lemma_tac�p(f x) � Space�T Ԯ THEN1 all_fc_tac[continuous_�_space_t_thm]);
a(LIST_DROP_NTH_ASM_T [8] all_fc_tac);
a(spec_nth_asm_tac 3 �f x�);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a u s�a � u � u � s � a � s�]);
a(all_fc_tac[continuous_open_thm]);
a(lemma_tac�g x � A� THEN1 asm_rewrite_tac[]);
a(�_tac�{y|y � Space�T � � f y � A} � {y|y � Space�T � � g y � A}�
	THEN ALL_FC_T asm_rewrite_tac[�_open_thm]
	THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [11] all_fc_tac);
a(lemma_tac�f x' � Space�T Ӯ THEN1 all_fc_tac[continuous_�_space_t_thm]);
a(lemma_tac�g x' � Space�T Ӯ THEN1 all_fc_tac[continuous_�_space_t_thm]);
a(bc_thm_tac (�_elim�p� homeomorphism_one_one_thm));
a(MAP_EVERY �_tac [�C �T Ԯ, �A �T Ӯ, �p�]
	THEN ALL_FC_T asm_rewrite_tac[subspace_topology_thm,
		subspace_topology_space_t_thm2]);
a(LIST_GET_NTH_ASM_T [23] (ALL_FC_T rewrite_tac));
pop_thm()
));


val unique_lifting_lemma2 = (* not saved *) snd ( "unique_lifting_lemma2", (
set_goal([], ��� � �; p:'b � 'c; f g : 'a � 'b �
	� � Topology
�	� � Topology
�	� � Topology
�	p � (�, �) CoveringProjection
�	f � (�, �) Continuous
�	g � (�, �) Continuous
�	(�x� x � Space�T � � p(f x) = p(g x))
�	{x | x � Space�T � � �g x = f x} � �
�);
a(rewrite_tac[covering_projection_def] THEN REPEAT strip_tac);
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]);
a(REPEAT strip_tac);
a(all_fc_tac[continuous_�_space_t_thm]);
a(lemma_tac�p(f x) � Space�T Ԯ THEN1 all_fc_tac[continuous_�_space_t_thm]);
a(LIST_DROP_NTH_ASM_T [9] all_fc_tac);
a(LIST_GET_NTH_ASM_T [12] all_fc_tac);
a(POP_ASM_T (strip_asm_tac o eq_sym_rule));
a(lemma_tac�p(g x) � C�
	THEN1 asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T [5] all_fc_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a u s�a � u � u � s � a � s�]);
a(all_fc_tac[continuous_open_thm]);
a(�_tac�{y|y � Space�T � � f y � A'} � {y|y � Space�T � � g y � A}�
	THEN ALL_FC_T asm_rewrite_tac[�_open_thm]
	THEN REPEAT strip_tac);
a(PC_T "sets_ext1" contr_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]� �a b x y�x � a � y � b � y = x � �a � b  = {}�]);
a(LIST_DROP_NTH_ASM_T [22] all_fc_tac THEN all_var_elim_asm_tac1);
a(LIST_DROP_NTH_ASM_T [17] all_fc_tac);
a(swap_nth_asm_concl_tac 24);
a(lemma_tac�f x' � Space�T Ӯ THEN1 all_fc_tac[continuous_�_space_t_thm]);
a(lemma_tac�g x' � Space�T Ӯ THEN1 all_fc_tac[continuous_�_space_t_thm]);
a(bc_thm_tac (�_elim�p� homeomorphism_one_one_thm));
a(MAP_EVERY �_tac [�C �T Ԯ, �A �T Ӯ, �p�]
	THEN ALL_FC_T asm_rewrite_tac[subspace_topology_thm,
		subspace_topology_space_t_thm2]);
pop_thm()
));


val unique_lifting_thm = save_thm ( "unique_lifting_thm", (
set_goal([], ��� � �; p:'b � 'c; f g : 'a � 'b; a : 'a �
	� � Topology
�	� � Topology
�	� � Topology
�	Space�T � � � Connected
�	p � (�, �) CoveringProjection
�	f � (�, �) Continuous
�	g � (�, �) Continuous
�	(�x� x � Space�T � � p(f x) = p(g x))
�	a � Space�T �
�	g a = f a
�	�x� x � Space�T � � g x = f x
�);
a(REPEAT strip_tac);
a(swap_nth_asm_concl_tac 8 THEN rewrite_tac[connected_def]
	THEN REPEAT strip_tac);
a(all_fc_tac[unique_lifting_lemma1, unique_lifting_lemma2]);
a(�_tac�{x | x � Space�T � � g x = f x}� THEN REPEAT strip_tac);
a(�_tac�{x | x � Space�T � � �g x = f x}� THEN asm_rewrite_tac[]);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(�_tac�x� THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(�_tac�a� THEN asm_rewrite_tac[]);
pop_thm()
));

open_theory"metric_spaces";
set_merge_pcs["basic_hol1", "'sets_alg", "'�", "'�"];
val metric_def = get_spec�Metric�;
val metric_topology_def = get_spec�$MetricTopology�;
val list_metric_def = get_spec�ListMetric�;

val metric_topology_thm = save_thm ( "metric_topology_thm", (
set_goal([], ��D�D � Metric � D MetricTopology � Topology�);
a(rewrite_tac[topology_def, metric_def, metric_topology_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��x b c�x � b � b � c � x �  c�]);
a(LIST_DROP_NTH_ASM_T [1] all_fc_tac);
a(�_tac�e� THEN REPEAT strip_tac);
a(�_tac�s� THEN ALL_ASM_FC_T asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [3, 4] all_fc_tac);
a(cases_tac�e � e'�);
(* *** Goal "2.1" *** *)
a(�_tac�e� THEN PC_T1 "predicates" REPEAT strip_tac);
a(lemma_tac�D(x, y) < e'� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(LIST_DROP_NTH_ASM_T [4, 6] all_fc_tac THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(�_tac�e'� THEN PC_T1 "predicates" REPEAT strip_tac);
a(lemma_tac�D(x, y) < e� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(LIST_DROP_NTH_ASM_T [4, 6] all_fc_tac THEN REPEAT strip_tac);
pop_thm()
));



val space_t_metric_topology_thm = save_thm ( "space_t_metric_topology_thm", (
set_goal([], ��D�
	D � Metric
�	Space�T (D MetricTopology) = Universe
�);
a(PC_T1 "sets_ext1" rewrite_tac[metric_def, metric_topology_def, space_t_def]
	THEN REPEAT strip_tac);
a(�_tac�Universe� THEN rewrite_tac[]);
a(�_tac�1/2� THEN REPEAT strip_tac);
pop_thm()
));


val open_ball_open_thm = save_thm ( "open_ball_open_thm", (
set_goal([], ��D e x�� 0 <  e � D � Metric � {y | D (x, y) < e} � D MetricTopology�);
a(rewrite_tac[metric_topology_def, metric_def] THEN REPEAT strip_tac);
a(�_tac�e - D(x, x')� THEN REPEAT strip_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(lemma_tac�D(x, y) � D(x, x') + D(x', y)� THEN1 asm_rewrite_tac[]);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val open_ball_neighbourhood_thm = save_thm ( "open_ball_neighbourhood_thm", (
set_goal([], ��D e x�� 0 <  e � D � Metric � x � {y | D(x, y) < e}�);
a(rewrite_tac[metric_def] THEN REPEAT strip_tac);
a(lemma_tac�D(x, x) = � 0� THEN asm_rewrite_tac[]);
pop_thm()
));




val metric_topology_hausdorff_thm = save_thm ( "metric_topology_hausdorff_thm", (
set_goal([], ��D�
	D � Metric
�	D MetricTopology � Hausdorff
�);
a(REPEAT strip_tac THEN TOP_ASM_T ante_tac);
a(rewrite_tac[metric_def, hausdorff_def, space_t_metric_topology_thm]
	THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 5 ante_tac);
a(lemma_tac�0. � D(x, y) � �D(x, y) = 0.�
	THEN1 asm_rewrite_tac[]);
a(lemma_tac�0. < 1/2 * D(x, y)�
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]
	THEN strip_tac);
a(�_tac�{z | D(x, z) < 1/2 * D(x, y)}�
	THEN �_tac�{z | D(y, z) < 1/2 * D(x, y)}�
	THEN ALL_FC_T rewrite_tac[open_ball_open_thm]);
a(POP_ASM_T ante_tac
	THEN LEMMA_T��z� D(z, z) = 0.� asm_rewrite_thm_tac
	THEN1 asm_rewrite_tac[]);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
a(LEMMA_T�D(x, y) � D(x, x') + D(x', y)� ante_tac
	THEN1 DROP_NTH_ASM_T 10 rewrite_thm_tac);
a(rewrite_tac[]);
a(LEMMA_T �D(x', y) = D(y, x')� rewrite_thm_tac
	THEN1 (DROP_NTH_ASM_T 3
		(fn th => conv_tac(LEFT_C(once_rewrite_conv[th])))
		THEN REPEAT strip_tac));
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val product_metric_thm = save_thm ( "product_metric_thm", (
set_goal([], ��D1 D2�
	D1 � Metric � D2 � Metric
�	(�((x1, x2), (y1, y2))� D1(x1, y1) + D2(x2, y2)) � Metric
�);
a(rewrite_tac[metric_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]
	��x y�� 0 � x � � 0 � y � � 0 � x + y�) THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac �� 0 � D1(Fst x, Fst y) � � 0 � D2(Snd x, Snd y)�
	THEN1 asm_rewrite_tac[]);
a(lemma_tac �D1(Fst x, Fst y) = � 0 � D2(Snd x, Snd y) = � 0�
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(all_asm_fc_tac[]);
a(pure_once_rewrite_tac[prove_rule[]��p�p = (Fst p, Snd p)�]);
a(pure_asm_rewrite_tac[] THEN rewrite_tac[]);
(* *** Goal "3" *** *)
a(LEMMA_T�x = y � (�x� D1(x, x) = � 0) � (�y�D2(y, y) = � 0)� rewrite_thm_tac
	THEN LIST_GET_NTH_ASM_T [1, 4, 8] rewrite_tac);
(* *** Goal "4" *** *)
a(GET_NTH_ASM_T 6 (rewrite_thm_tac o �_elim�Fst y�));
a(GET_NTH_ASM_T 2 (rewrite_thm_tac o �_elim�Snd y�));
(* *** Goal "5" *** *)
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]��a b c d e f:��a � c + e � b � d + f � a + b � (c + d) + e + f�));
a(asm_rewrite_tac[]);
pop_thm()
));


val product_metric_topology_thm = save_thm ( "product_metric_topology_thm", (
set_goal([], ��D1 D2�
	D1 � Metric � D2 � Metric
�	(�((x1, x2), (y1, y2))� D1(x1, y1) + D2(x2, y2)) MetricTopology   =
	(D1 MetricTopology ��T D2 MetricTopology)
�);
a(rewrite_tac[metric_def, metric_topology_def, product_topology_def] THEN
	PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(lemma_tac�� 0 < (1/2)*e� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(�_tac�{x1 | D1(x', x1)  < (1/2)*e}� THEN �_tac�{x2 | D2(y, x2)  < (1/2)*e}� THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(�_tac�(1/2)*e - D1(x' , x'')� THEN REPEAT strip_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(lemma_tac�D1(x', y') � D1(x', x'') + D1(x'', y')� THEN1 GET_NTH_ASM_T 11 rewrite_thm_tac);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.2" *** *)
a(�_tac�(1/2)*e - D2(y , x'')� THEN REPEAT strip_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(lemma_tac�D2(y, y') � D2(y, x'') + D2(x'', y')� THEN1 GET_NTH_ASM_T 7 rewrite_thm_tac);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.3" *** *)
a(LEMMA_T ��x� D1(x, x) = � 0� asm_rewrite_thm_tac
	THEN1 LIST_GET_NTH_ASM_T [1, 11] rewrite_tac);
(* *** Goal "1.4" *** *)
a(LEMMA_T ��x� D2(x, x) = � 0� asm_rewrite_thm_tac
	THEN LIST_GET_NTH_ASM_T [1, 7] rewrite_tac);
(* *** Goal "1.5" *** *)
a(rewrite_tac[�_def] THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(DROP_NTH_ASM_T 4 (bc_thm_tac o rewrite_rule[]));
a(rewrite_tac[] THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(DROP_NTH_ASM_T 2 (ante_tac o list_�_elim[�Fst x'�, �Snd x'�]));
a(rewrite_tac[] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [4, 5] all_fc_tac);
a(cases_tac�e < e'�);
(* *** Goal "2.1" *** *)
a(�_tac�e� THEN REPEAT strip_tac);
a(bc_thm_tac (pc_rule1 "sets_ext1" prove_rule[]��a x y� a � x � y � a � y � x�));
a(�_tac�A � B� THEN REPEAT strip_tac);
a(lemma_tac �� 0 � D1 (Fst x', Fst y) � � 0 �  D2 (Snd x', Snd y)�
	THEN1 LIST_GET_NTH_ASM_T [14, 18] rewrite_tac);
a(lemma_tac �D1 (Fst x', Fst y) < e' � D2 (Snd x', Snd y) < e�
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(LIST_DROP_NTH_ASM_T[7, 9] all_fc_tac);
a(rewrite_tac[�_def] THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(�_tac�e'� THEN REPEAT strip_tac);
a(bc_thm_tac (pc_rule1 "sets_ext1" prove_rule[]��a x y� a � x � y � a � y � x�));
a(�_tac�A � B� THEN REPEAT strip_tac);
a(lemma_tac �� 0 � D1 (Fst x', Fst y) � � 0 �  D2 (Snd x', Snd y)�
	THEN1 LIST_GET_NTH_ASM_T [14, 18] rewrite_tac);
a(lemma_tac �D1 (Fst x', Fst y) < e' � D2 (Snd x', Snd y) < e�
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(LIST_DROP_NTH_ASM_T[7, 9] all_fc_tac);
a(rewrite_tac[�_def] THEN REPEAT strip_tac);
pop_thm()
));


val lebesgue_number_thm = save_thm ( "lebesgue_number_thm", (
set_goal([], ��D X U�
	D � Metric
�	X � (D MetricTopology) Compact
�	U � D MetricTopology
�	X � �U
�	�e� � 0 < e
�	�x� x � X � �A� x �  A � A � U � �y� D(x, y) < e � y � A
�);
a(contr_tac);
a(all_fc_tac [metric_topology_thm]);
a(lemma_tac��s�(�m:� s m � X) � (�A; m:�A � U � �y� D(s m, y) < � (m + 1) �-�1 � �y � A)�
	THEN1 (prove_�_tac THEN REPEAT strip_tac));
(* *** Goal "1" *** *)
a(lemma_tac�� 0 < � (m' + 1)�-�1� THEN1
	(bc_thm_tac  �_0_less_0_less_recip_thm THEN
		rewrite_tac [�_less_thm] THEN PC_T1 "lin_arith" prove_tac[]));
a(spec_nth_asm_tac 3 �� (m' + 1)�-�1�);
a(�_tac�x� THEN REPEAT strip_tac);
a(spec_nth_asm_tac 2 �A�);
(* *** Goal "1.1" *** *)
a(�_tac�x� THEN REPEAT strip_tac);
a(LEMMA_T �D(x, x) = � 0� asm_rewrite_thm_tac);
a(DROP_NTH_ASM_T 11 (rewrite_thm_tac o rewrite_rule[metric_def]));
(* *** Goal "1.2" *** *)
a(�_tac�y� THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(all_fc_tac[compact_sequentially_compact_thm]);
a(DROP_NTH_ASM_T 7 (PC_T1 "sets_ext1" strip_asm_tac));
a(LIST_DROP_NTH_ASM_T [1] all_fc_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��a�s' � U � U � a � s' � a�]);
a(spec_nth_asm_tac 4 �s'�);
a(GET_NTH_ASM_T 2 (strip_asm_tac o rewrite_rule[metric_topology_def]));
a(LIST_DROP_NTH_ASM_T [1] all_fc_tac);
a(lemma_tac�� 0  < (1/2)*e � THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(DROP_NTH_ASM_T 3 discard_tac);
a(lemma_tac�{y | D(x, y) < (1/2)*e} � D MetricTopology�
	THEN1 (bc_thm_tac open_ball_open_thm THEN REPEAT strip_tac));
a(LEMMA_T�x � {y | D(x, y) < (1/2)*e}� asm_tac
	THEN1 (bc_thm_tac open_ball_neighbourhood_thm THEN REPEAT strip_tac));
a(PC_T1 "predicates" (spec_nth_asm_tac 9) �{y | D(x, y) < (1/2)*e}�);
a(all_fc_tac[�_archimedean_recip_thm]);
a(spec_nth_asm_tac 2 �m+1�);
a(lemma_tac�� 0 < �(m+1) � � 0 < �(n+1) � �(m+1) < �(n+1)�
	THEN1 (rewrite_tac [�_less_thm] THEN PC_T1 "lin_arith" asm_prove_tac[]));
a(lemma_tac��(n+1)�-�1  < �(m+1)�-�1�
	THEN1 (bc_thm_tac �_less_recip_less_thm THEN REPEAT strip_tac));
a(lemma_tac�� 0 < �(m+1)�-�1 � � 0 < �(n+1)�-�1�
	THEN1 (ALL_FC_T rewrite_tac [�_0_less_0_less_recip_thm]));
a(list_spec_nth_asm_tac 21 [�s'�, �n�]);
a(swap_nth_asm_concl_tac 1 THEN DROP_NTH_ASM_T 15 bc_thm_tac);
a(lemma_tac�D(x, y) � D(x, s n) + D(s n, y)�
	THEN1 DROP_NTH_ASM_T 27 (rewrite_thm_tac o rewrite_rule[metric_def]));
a(lemma_tac�D(s n, y) < (1/2)*e�
	THEN1 REPEAT (all_fc_tac[�_less_trans_thm]));
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val collar_thm = save_thm ( "collar_thm", (
set_goal([], ��D X U�
	D � Metric
�	X � (D MetricTopology) Compact
�	A � D MetricTopology
�	X � A
�	�e� � 0 < e
�	�x y� x � X � y � Space�T � � D(x, y) < e � y � A
�);
a(REPEAT strip_tac);
a(lemma_tac �X � �{A} � {A} � D MetricTopology�  THEN1 asm_rewrite_tac[enum_set_clauses]);
a(strip_asm_tac (list_�_elim[�D�, �X�, �{A}�] lebesgue_number_thm));
a(�_tac�e� THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
a(all_var_elim_asm_tac1 THEN all_asm_fc_tac[]);
pop_thm()
));



val list_pseudo_metric_lemma1 = (* not saved *) snd ( "list_pseudo_metric_lemma1", (
set_goal([], ��P�
	(�D x v y w�
	P D ([], []) = 0.
�	P D (Cons x v, []) = D(x, Arbitrary) + P D (v, [])
�	P D ([], Cons y w) = D(Arbitrary, y) + P D ([], w)
�	P D (Cons x v, Cons y w) = D (x, y) + P D (v, w))
�	�D v w�
	ListMetric D (v, w) =
	Abs(�(#v) - � (#w)) + P D (v, w)
�);
a(strip_asm_tac (prove_�_rule
 ��P�
	�D: 'a � 'a � �; x v y w�
	P D ([], []) = 0.
�	P D (Cons x v, []) = D(x, Arbitrary) + P D (v, [])
�	P D ([], Cons y w) = D(Arbitrary, y) + P D ([], w)
�	P D (Cons x v, Cons y w) = D (x, y) + P D (v, w)
�));
a(�_tac�P� THEN asm_rewrite_tac[] THEN REPEAT_N 2 strip_tac);
a(list_induction_tac�v� THEN REPEAT strip_tac
	THEN list_induction_tac�w:'a LIST�
	THEN REPEAT strip_tac
	THEN asm_rewrite_tac[list_metric_def, length_def,
		�_plus_homomorphism_thm]);
(* *** Goal "1" *** *)
a(lemma_tac�0. � �(#w)� THEN1 rewrite_tac[�_�_thm]);
a(LEMMA_T��x�0. � x � �0. � ~x + ~1.�
	(fn th => all_fc_tac[th])
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(asm_rewrite_tac[�_abs_def] THEN1 PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�0. � �(#v)� THEN1 rewrite_tac[�_�_thm]);
a(LEMMA_T��x�0. � x � 0. � x + 1.�
	(fn th => all_fc_tac[th])
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(asm_rewrite_tac[�_abs_def] THEN1 PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "3" *** *)
a(conv_tac(ONCE_MAP_C �_anf_conv));
a(cases_tac�0. � � (# v) + ~ (� (# w))�
	THEN asm_rewrite_tac[�_abs_def]
	THEN PC_T1 "�_lin_arith" prove_tac[]);
pop_thm()
));


val list_pseudo_metric_lemma2 = (* not saved *) snd ( "list_pseudo_metric_lemma2", (
set_goal([], ��P; D : 'a � 'a � ��
	(�x v y w�
	P D ([], []) = 0.
�	P D (Cons x v, []) = D(x, Arbitrary) + P D (v, [])
�	P D ([], Cons y w) = D(Arbitrary, y) + P D ([], w)
�	P D (Cons x v, Cons y w) = D (x, y) + P D (v, w))
�	(�x� D (x, x) = 0.)
�	(�x y z� D (x, z) � D (x, y) + D(y, z))
�	P D (u, w) � P D (u, v) + P D (v, w)
�);
a(REPEAT strip_tac);
a(lemma_tac�
	(�v w� P D (v @ [Arbitrary], w) = P D (v, w))
�	(�w v� P D (v, w @ [Arbitrary]) = P D (v, w))�
	THEN1 �_tac);
(* *** Goal "1" *** *)
a(�_tac THEN list_induction_tac �v:'a LIST� THEN asm_rewrite_tac[append_def]
	THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(list_induction_tac �w� THEN asm_rewrite_tac[]);
(* *** Goal "1.2" *** *)
a(list_induction_tac �w� THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(�_tac THEN list_induction_tac �w:'a LIST� THEN asm_rewrite_tac[append_def]
	THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(list_induction_tac �v� THEN asm_rewrite_tac[]);
(* *** Goal "1.2" *** *)
a(list_induction_tac �v� THEN asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(lemma_tac��pad��j v� pad v 0 = v � pad v (j+1) = pad v j @ [Arbitrary]�
	THEN1 prove_�_tac);
a(lemma_tac��j v�#(pad v j) = #v + j�
	THEN1 (�_tac THEN induction_tac�j:�
	THEN asm_rewrite_tac[length_append_thm, length_def, plus_assoc_thm]));
a(lemma_tac��j v w�P D (pad v j, w) = P D (v, w)�
	THEN1 (�_tac THEN induction_tac�j:�
	THEN asm_rewrite_tac[]));
a(lemma_tac��j v w�P D (v, pad w j) = P D (v, w)�
	THEN1 (�_tac THEN induction_tac�j:�
	THEN asm_rewrite_tac[]));
a(lemma_tac��i j k� #u + i = #v + j � #v + j = #w + k�
	THEN1 (MAP_EVERY �_tac [�#v + #w�, �#u + #w�, �#u + #v�]
		THEN1 PC_T1 "lin_arith" prove_tac[]));
a(lemma_tac�#(pad u i) = #(pad v j) � #(pad v j) = #(pad w k)�
	THEN1 asm_rewrite_tac[]);
a(LEMMA_T�
	P D (u, w) = P D (pad u i, pad w k)
�	P D (u, v) = P D (pad u i, pad v j)
�	P D (v, w) = P D (pad v j, pad w k)� rewrite_thm_tac
	THEN1 asm_rewrite_tac[]);
a(LEMMA_T��u v w�#u = #v � #v =#w � P D (u, w) � P D (u, v) + P D (v, w)�
	(fn th => bc_thm_tac th THEN REPEAT strip_tac));
a(LIST_DROP_NTH_ASM_T [1, 2, 3, 4] discard_tac THEN REPEAT strip_tac);
a(lemma_tac��m� #u = m� THEN1 prove_�_tac);
a(LIST_DROP_NTH_ASM_T [2, 3, 1] (MAP_EVERY ante_tac));
a(MAP_EVERY intro_�_tac1 [�w�, �v�, �u�]);
a(induction_tac�m�);
(* *** Goal "3.1" *** *)
a(REPEAT �_tac THEN strip_tac THEN asm_rewrite_tac[]);
a(STRIP_T (strip_asm_tac o eq_sym_rule) THEN asm_rewrite_tac[]);
a(STRIP_T (ante_tac o eq_sym_rule)
	THEN POP_ASM_T ante_tac THEN POP_ASM_T ante_tac);
a(rewrite_tac[length_0_thm]);
a(REPEAT strip_tac THEN asm_rewrite_tac[]);
(* *** Goal "3.2" *** *)
a(REPEAT �_tac THEN strip_tac THEN asm_rewrite_tac[]);
a(STRIP_T (strip_asm_tac o eq_sym_rule) THEN asm_rewrite_tac[]);
a(STRIP_T (strip_asm_tac o eq_sym_rule));
a(MAP_EVERY (fn t => strip_asm_tac(�_elim t list_cases_thm)
	THEN all_var_elim_asm_tac1 THEN1
		(all_asm_ante_tac THEN rewrite_tac[length_def]))
	[�u�, �v�, �w�]);
a(LIST_DROP_NTH_ASM_T [1, 2, 3] (MAP_EVERY (strip_asm_tac o rewrite_rule[length_def])));
a(asm_rewrite_tac[�_plus_assoc_thm]);
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]
	��a b c x y z:��a � b + c � x � y + z �
		a + x � b + y + c + z�)
	THEN asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 4 (bc_thm_tac o rewrite_rule[taut_rule�
	�p q r�p � q � r � p � q � r�])
	THEN PC_T1 "lin_arith" asm_prove_tac[]);
pop_thm()
));


val list_metric_nonneg_thm = save_thm ( "list_metric_nonneg_thm", (
set_goal([], ��D x�
	D � Metric
�	0. � ListMetric D (x, y)
�);
a(rewrite_tac[metric_def] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [1, 2, 3] discard_tac);
a(intro_�_tac1�y� THEN list_induction_tac�x� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(list_induction_tac �y� THEN asm_rewrite_tac[list_metric_def] THEN REPEAT strip_tac);
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]��x y�0. � x � 0. � y � 0. � 1. + x + y�)
	THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(list_induction_tac �y� THEN rewrite_tac[list_metric_def] THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]��x y�0. � x � 0. � y � 0. � 1. + x + y�)
	THEN asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]��x y�0. � x � 0. � y � 0. � x + y�)
	THEN asm_rewrite_tac[]);
pop_thm()
));



val list_metric_sym_thm = save_thm ( "list_metric_sym_thm", (
set_goal([], ��D x y�
	D � Metric
�	ListMetric D (x, y) = ListMetric D (y, x)
�);
a(rewrite_tac[metric_def] THEN REPEAT strip_tac);
a(intro_�_tac1�y� THEN list_induction_tac�x� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(list_induction_tac�y� THEN REPEAT strip_tac
	THEN rewrite_tac[list_metric_def]);
a(DROP_NTH_ASM_T 3 (once_asm_rewrite_thm_tac o �_elim�x�)
	THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(strip_asm_tac(�_elim�y� list_cases_thm)
	THEN all_var_elim_asm_tac1 THEN rewrite_tac[list_metric_def]);
(* *** Goal "2.1" *** *)
a(POP_ASM_T rewrite_thm_tac);
a(DROP_NTH_ASM_T 2 (once_asm_rewrite_thm_tac o �_elim�x'�)
	THEN REPEAT strip_tac);
(* *** Goal "2.2" *** *)
a(DROP_NTH_ASM_T 3 (once_asm_rewrite_thm_tac o �_elim�x'�)
	THEN strip_tac);
pop_thm()
));



val list_metric_metric_thm = save_thm ( "list_metric_metric_thm", (
set_goal([], ��D�
	D � Metric
�	ListMetric D � Metric
�);
a(REPEAT strip_tac THEN TOP_ASM_T ante_tac);
a(rewrite_tac[metric_def] THEN �_tac);
a(all_fc_tac[list_metric_nonneg_thm] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(DROP_NTH_ASM_T 4 discard_tac);
a(POP_ASM_T ante_tac THEN lemma_tac��m� Length x = m� THEN1 prove_�_tac);
a(POP_ASM_T ante_tac THEN intro_�_tac1�y� THEN intro_�_tac1�x�);
a(induction_tac�m� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(POP_ASM_T ante_tac THEN POP_ASM_T ante_tac
	THEN rewrite_tac[length_0_thm]
	THEN REPEAT strip_tac THEN all_var_elim_asm_tac1);
a(POP_ASM_T ante_tac THEN strip_asm_tac(�_elim�y� list_cases_thm)
	THEN asm_rewrite_tac[list_metric_def]);
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]��x y�0. � x � 0. � y � �1. + x + y = 0.�)
	THEN asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(lemma_tac��x = []� THEN1 (contr_tac THEN all_var_elim_asm_tac1
	THEN all_asm_ante_tac THEN rewrite_tac[length_def]));
a(DROP_NTH_ASM_T 2 ante_tac THEN strip_asm_tac(�_elim�x� list_cases_thm));
a(strip_asm_tac(�_elim�y� list_cases_thm)
	THEN all_var_elim_asm_tac1 THEN1 asm_rewrite_tac[list_metric_def]);
(* *** Goal "2.2.1" *** *)
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]��x y�0. � x � 0. � y � �1. + x + y = 0.�)
	THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2" *** *)
a(DROP_NTH_ASM_T 2 ante_tac THEN rewrite_tac[list_metric_def, length_def]);
a(REPEAT_UNTIL is_� strip_tac);
a(FC_T (MAP_EVERY ante_tac) [pc_rule1 "�_lin_arith" prove_rule[]
	��x y� x + y = 0. � 0. � x � 0. � y � x = 0. � y = 0.�]);
a(asm_rewrite_tac[] THEN REPEAT strip_tac);
a(all_asm_fc_tac[]);
(* *** Goal "3" *** *)
a(all_var_elim_asm_tac);
a(list_induction_tac�y� THEN asm_rewrite_tac[list_metric_def]);
(* *** Goal "4" *** *)
a(bc_thm_tac list_metric_sym_thm THEN REPEAT strip_tac);
(* *** Goal "5" *** *)
a(strip_asm_tac list_pseudo_metric_lemma1 THEN asm_rewrite_tac[�_plus_assoc_thm]);
a(bc_thm_tac (pc_rule1 "�_lin_arith" prove_rule[]
	��a b c x y z:��a � b + c � x � y + z �
		a + x � b + y + c + z�)
	THEN REPEAT strip_tac);
(* *** Goal "5.1" *** *)
a(rewrite_tac[pc_rule1 "�_lin_arith" prove_rule[]
	�� (# x) + ~ (� (# z)) =
	(� (# x) + ~ (� (# y))) + (� (# y) + ~ (� (# z)))�, �_abs_plus_thm]);
(* *** Goal "5.1" *** *)
a(bc_thm_tac list_pseudo_metric_lemma2);
a(DROP_NTH_ASM_T 5 discard_tac THEN asm_rewrite_tac[]);
pop_thm()
));


open_theory"topology_�";
set_merge_pcs["basic_hol1", "'sets_alg", "'�", "'�"];
val d_�_def = get_spec�D�R�;
val d_�_2_def = get_spec�D�R2�;
val d_�_2_def1 = save_thm ( "d_�_2_def1", (
set_goal([], ��xy1 xy2� D�R2 (xy1, xy2) = Abs(Fst xy2 - Fst xy1)  + Abs(Snd xy2 - Snd  xy1)�);
a(REPEAT strip_tac);
a(pure_once_rewrite_tac[prove_rule[]��p:� � ��p = (Fst p, Snd p)�]);
a(pure_rewrite_tac[d_�_2_def]);
a(rewrite_tac[]);
pop_thm()
));


val open_�_topology_thm = save_thm ( "open_�_topology_thm", (
set_goal([], �O�R � Topology�);
a(rewrite_tac[topology_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_fc_tac[�_open_�_thm]);
(* *** Goal "2" *** *)
a(all_fc_tac[�_open_�_thm]);
pop_thm()
));


val space_t_�_thm = save_thm ( "space_t_�_thm", (
set_goal([], �Space�T O�R = Universe�);
a(PC_T1 "sets_ext" REPEAT strip_tac);
a(bc_thm_tac �_space_t_thm);
a(�_tac�Universe� THEN rewrite_tac[open_�_topology_thm, empty_universe_open_closed_thm]);
pop_thm()
));


val closed_closed_�_thm = save_thm ( "closed_closed_�_thm", (
set_goal([], �O�R Closed = Closed�R�);
a(rewrite_tac[closed_def, closed_�_def, space_t_�_thm] THEN REPEAT strip_tac);
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[pc_rule1"sets_ext1" prove_rule[complement_clauses]��a:'a SET�~(~a) = a�]);
(* *** Goal "2" *** *)
a(�_tac�~x� THEN
	asm_rewrite_tac[pc_rule1"sets_ext1" prove_rule[complement_clauses]��a:'a SET�~(~a) = a�]);
pop_thm()
));


val compact_compact_�_thm = save_thm ( "compact_compact_�_thm", (
set_goal([], �O�R Compact = Compact�R�);
a(rewrite_tac[compact_def, compact_�_def, space_t_�_thm] THEN REPEAT strip_tac);
pop_thm()
));


val open_�_const_continuous_thm = save_thm("open_�_const_continuous_thm",
	all_�_intro(
	rewrite_rule[open_�_topology_thm, space_t_�_thm]
	(list_�_elim[�� : 'a SET SET�, �O�R�] const_continuous_thm)));


val open_�_id_continuous_thm = save_thm("open_�_id_continuous_thm",
	rewrite_rule[open_�_topology_thm]
	(�_elim�O�R� id_continuous_thm));



val continuous_cts_at_�_thm = save_thm ( "continuous_cts_at_�_thm", (
set_goal([], ��f� f � (O�R, O�R) Continuous � �x�f Cts x�);
a(rewrite_tac[continuous_def, cts_open_�_thm, space_t_�_thm] THEN REPEAT strip_tac);
pop_thm()
));

val cts_at_�_continuous_thm = save_thm( "cts_at_�_continuous_thm",
	conv_rule(BINDER_C eq_sym_conv) continuous_cts_at_�_thm);


val universe_�_connected_thm = save_thm ( "universe_�_connected_thm", (
set_goal([], �Universe � O�R Connected�);
a(rewrite_tac[connected_def, space_t_�_thm] THEN PC_T1 "sets_ext1" rewrite_tac[]);
a(strip_asm_tac open_�_topology_thm THEN contr_tac);
a(lemma_tac��f��t� f t = if t � B then � 0 else � 1� THEN1 prove_�_tac);
a(lemma_tac��t�f Cts t�);
(* *** Goal "1" *** *)
a(rewrite_tac[cts_open_�_thm] THEN REPEAT strip_tac);
a(cases_tac�� 0 � A� THEN cases_tac�� 1 � A�);
(* *** Goal "1.1" *** *)
a(LEMMA_T �{x | f x � A} = Space�T O�R� rewrite_thm_tac THEN_LIST
	[rewrite_tac[space_t_�_thm], ALL_FC_T rewrite_tac[space_t_open_thm]]);
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN asm_rewrite_tac[]);
a(cases_tac �x'' � B� THEN asm_rewrite_tac[]);
(* *** Goal "1.2" *** *)
a(LEMMA_T �{x | f x � A} = B�  asm_rewrite_thm_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN_TRY asm_rewrite_tac[]);
a(swap_nth_asm_concl_tac 1 THEN asm_rewrite_tac[]);
(* *** Goal "1.3" *** *)
a(LEMMA_T �{z | f z � A} = C�  asm_rewrite_thm_tac);
a(LEMMA_T��t�t � B � �t � C� asm_rewrite_thm_tac THEN1 asm_prove_tac[]);
a(PC_T1 "sets_ext1" REPEAT strip_tac THEN_TRY asm_rewrite_tac[]);
a(swap_nth_asm_concl_tac 1 THEN asm_rewrite_tac[]);
(* *** Goal "1.4" *** *)
a(LEMMA_T �{x | f x � A} = {}� rewrite_thm_tac THEN_LIST
	[PC_T "sets_ext1" contr_tac, ALL_FC_T rewrite_tac[empty_open_thm]]);
a(POP_ASM_T ante_tac THEN spec_nth_asm_tac 8 �x''� THEN asm_rewrite_tac[]);
a(LEMMA_T��t�t � B � �t � C� asm_rewrite_thm_tac THEN1 asm_prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac��t��f t = 1/2� THEN1 (strip_tac THEN cases_tac�t � B� THEN asm_rewrite_tac[]));
a(lemma_tac�f x = � 1� THEN1 asm_rewrite_tac[]);
a(lemma_tac�f x' = � 0� THEN1
	(cases_tac �x' � B� THEN asm_rewrite_tac[] THEN asm_prove_tac[]));
a(DROP_NTH_ASM_T 5 discard_tac);
a(lemma_tac��x = x'� THEN1  (contr_tac THEN all_var_elim_asm_tac THEN asm_prove_tac[]));
a(strip_asm_tac (list_�_elim[�x�, �x'�] �_less_cases_thm));
(* *** Goal "2.1" *** *)
a(ante_tac(list_�_elim[�f�, �x�, �x'�] intermediate_value_thm)
	THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
a(�_tac�1/2�  THEN asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(ante_tac(list_�_elim[�f�, �x'�, �x�] intermediate_value_thm)
	THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
a(�_tac�1/2�  THEN asm_rewrite_tac[]);
pop_thm()
));


val closed_interval_connected_thm = save_thm ( "closed_interval_connected_thm", (
set_goal([], ��x y� x < y � ClosedInterval x y � O�R Connected�);
a(REPEAT strip_tac);
a(ante_tac(list_�_elim[�x�, �y�,  ��t:��t�] cts_extension_thm1));
a(asm_rewrite_tac[id_cts_thm,
	conv_rule(ONCE_MAP_C eq_sym_conv) continuous_cts_at_�_thm] THEN strip_tac);
a(strip_asm_tac universe_�_connected_thm THEN strip_asm_tac open_�_topology_thm);
a(all_fc_tac[image_connected_thm]);
a(POP_ASM_T ante_tac THEN rewrite_tac[]);
a(bc_thm_tac(prove_rule[]��x y a�x = y � x � a � y � a�));
a(rewrite_tac[closed_interval_def] THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_var_elim_asm_tac1);
a(cases_tac�x'' < x� THEN1 ALL_ASM_FC_T rewrite_tac[]);
a(cases_tac�y < x''� THEN1
	(ALL_ASM_FC_T rewrite_tac[] THEN PC_T1 "�_lin_arith" asm_prove_tac[]));
a(lemma_tac�x � x'' � x'' � y� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(all_var_elim_asm_tac1);
a(cases_tac�y < x''� THEN1 ALL_ASM_FC_T rewrite_tac[]);
a(cases_tac�x'' < x� THEN1
	(ALL_ASM_FC_T rewrite_tac[] THEN PC_T1 "�_lin_arith" asm_prove_tac[]));
a(lemma_tac�x � x'' � x'' � y� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(�_tac�x'� THEN ALL_ASM_FC_T asm_rewrite_tac[]);
pop_thm()
));


val connected_�_thm = save_thm ( "connected_�_thm", (
set_goal([], ��X�
		X � O�R Connected
	�	�x y z�x � X � y � X � x � z � z � y � z � X�
);
a(REPEAT_N 3 strip_tac);
(* *** Goal "1" *** *)
a(rewrite_tac[connected_def, space_t_�_thm, �_�_def] THEN REPEAT strip_tac
	THEN_TRY all_var_elim_asm_tac THEN contr_tac);
a(strip_asm_tac (�_elim�z� half_infinite_intervals_open_thm));
a(lemma_tac�X � {t|t < z} � {t | z < t}� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a((cases_tac�x' = z� THEN1 all_var_elim_asm_tac) THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.2" *** *)
a(lemma_tac�X � {t|t < z} � {t | z < t} = {}� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1.2.1" *** *)
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.2.2" *** *)
a(lemma_tac��X � {t|t < z}� THEN PC_T "sets_ext1" contr_tac);
(* *** Goal "1.2.2.1" *** *)
a(spec_nth_asm_tac 1 �y� THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.2.2.2" *** *)
a(lemma_tac��X � {t|z < t}� THEN PC_T "sets_ext1" contr_tac);
(* *** Goal "1.2.2.2.1" *** *)
a(spec_nth_asm_tac 1 �x� THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.2.2.2.2" *** *)
a(all_asm_fc_tac[]);
(* *** Goal "2" *** *)
a(REPEAT strip_tac THEN strip_asm_tac open_�_topology_thm);
a(bc_thm_tac connected_pointwise_bc_thm);
a(REPEAT strip_tac);
a(strip_asm_tac (list_�_elim[�x�, �y�] �_less_cases_thm));
(* *** Goal "2.1" *** *)
a(�_tac�ClosedInterval x y�);
a(ALL_FC_T rewrite_tac[closed_interval_connected_thm]);
a(PC_T1 "sets_ext1" rewrite_tac[closed_interval_def]);
a(REPEAT strip_tac THEN all_asm_fc_tac[] THEN asm_rewrite_tac[�_�_def]);
(* *** Goal "2.2" *** *)
a(�_tac�{x}� THEN asm_rewrite_tac[enum_set_clauses]);
a(lemma_tac�y � Space�T O�R� THEN1 rewrite_tac[space_t_�_thm]);
a(ALL_FC_T rewrite_tac[singleton_connected_thm]);
(* *** Goal "2.3" *** *)
a(�_tac�ClosedInterval y x�);
a(ALL_FC_T rewrite_tac[closed_interval_connected_thm]);
a(PC_T1 "sets_ext1" rewrite_tac[closed_interval_def]);
a(REPEAT strip_tac THEN rename_tac[] THEN all_asm_fc_tac[] THEN asm_rewrite_tac[�_�_def]);
pop_thm()
));



val continuous_�_�_�_�_thm = save_thm ( "continuous_�_�_�_�_thm", (
set_goal([], ��X f�
	X � (O�R ��T O�R)
�	(f � (X �T (O�R ��T O�R), O�R) Continuous
	�	�x y u v� f(u, v) � OpenInterval x y � (u, v) � X �
		�a b c d�u � OpenInterval a b � v � OpenInterval c d �
			�s t�	s � OpenInterval a b � t � OpenInterval c d � (s, t) � X
			�	f(s, t) � OpenInterval x y)�);
a(rewrite_tac[continuous_def]);
a(strip_asm_tac open_�_topology_thm);
a(all_fc_tac[product_topology_thm]);
a(ALL_FC_T rewrite_tac [subspace_topology_space_t_thm, product_topology_space_t_thm]);
a(rewrite_tac[space_t_�_thm]);
a(rewrite_tac [open_�_def, product_topology_def, subspace_topology_def,
	merge_pcs_rule1 ["'bin_rel", "sets_ext"] prove_rule[]�(Universe � Universe) = Universe�]);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 4 discard_tac);
a(DROP_NTH_ASM_T 3 (strip_asm_tac o �_elim�OpenInterval x y�));
(* *** Goal "1.1" *** *)
a(swap_nth_asm_concl_tac 1 THEN REPEAT strip_tac);
a(�_tac�x� THEN REPEAT strip_tac);
a(�_tac�y� THEN REPEAT strip_tac);
(* *** Goal "1.2" *** *)
a(lemma_tac�(u, v) � B � X� THEN1
	(POP_ASM_T (rewrite_thm_tac o eq_sym_rule) THEN asm_rewrite_tac[]));
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [4, 5] all_fc_tac);
a(MAP_EVERY �_tac [�x''�, �y''�, �x'�, �y'�] THEN REPEAT strip_tac);
a(LEMMA_T�(s, t) � B � X� ante_tac THEN1 REPEAT strip_tac);
(* *** Goal "1.2.1" *** *)
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��x a b�x � a � a � b � x � b�]);
a(lemma_tac�(s, t) � (A � B')� THEN1 asm_rewrite_tac[�_def]);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��x a b�x � a � a � b � x � b�]);
(* *** Goal "1.2.2" *** *)
a(DROP_NTH_ASM_T 12 (rewrite_thm_tac o eq_sym_rule) THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2" *** *)
a(�_tac�{(s, t) | (s, t) � X �  f(s, t) � A }� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [6] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [4, 5, 10] all_fc_tac);
a(MAP_EVERY �_tac [�OpenInterval a b � OpenInterval x''' y'''�,
	�OpenInterval c d � OpenInterval x''  y''�] THEN REPEAT strip_tac);
(* *** Goal "2.1.1" *** *)
a(strip_asm_tac (list_�_elim[�a�, �b�, �x'''�, �y'''�] �_open_interval_thm));
a(MAP_EVERY �_tac [�x''''�,	�y''''�]);
a(POP_ASM_T (rewrite_thm_tac o eq_sym_rule) THEN REPEAT strip_tac);
(* *** Goal "2.1.2" *** *)
a(strip_asm_tac (list_�_elim[�c�, �d�, �x''�, �y''�] �_open_interval_thm));
a(MAP_EVERY �_tac [�x''''�,	�y''''�]);
a(POP_ASM_T (rewrite_thm_tac o eq_sym_rule) THEN REPEAT strip_tac);
(* *** Goal "2.1.3" *** *)
a(rewrite_tac[�_def] THEN PC_T1 "sets_ext1" rewrite_tac[]);
a(REPEAT �_tac THEN �_tac);
a(once_rewrite_tac[taut_rule��a b�a � b � a � (a � b)�] THEN REPEAT strip_tac);
(* *** Goal "2.1.3.1" *** *)
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��x a b�x � a � a � b � x � b�]);
a(lemma_tac�(x1, x2) � (A' � B)� THEN1 asm_rewrite_tac[�_def]);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]��x a b�x � a � a � b � x � b�]);
(* *** Goal "2.1.3.2" *** *)
a(all_asm_fc_tac[] THEN PC_T1 "sets_ext1" all_asm_fc_tac[]);
(* *** Goal "2.2" *** *)
a(PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val continuous_�_�_�_�_thm1 = save_thm ( "continuous_�_�_�_�_thm1", (
set_goal([], ��f�
	f � ((O�R ��T O�R), O�R) Continuous
	�	�x y u v� f(u, v) � OpenInterval x y �
		�a b c d�u � OpenInterval a b � v � OpenInterval c d �
			�s t�	s � OpenInterval a b � t � OpenInterval c d
			�	f(s, t) � OpenInterval x y�);
a(ante_tac(�_elim�Space�T (O�R ��T O�R)� continuous_�_�_�_�_thm));
a(strip_asm_tac open_�_topology_thm);
a(all_fc_tac[product_topology_thm]);
a(ALL_FC_T rewrite_tac [trivial_subspace_topology_thm, space_t_open_thm]);
a(ALL_FC_T rewrite_tac [product_topology_space_t_thm]);
a(rewrite_tac[space_t_�_thm,
	merge_pcs_rule1 ["'bin_rel", "sets_ext"] prove_rule[]�(Universe � Universe) = Universe�]);
pop_thm()
));


set_goal([], ��X�
	(�x y u v� f(u, v) � OpenInterval x y � (u, v) � X �
		�a b c d�u � OpenInterval a b � v � OpenInterval c d �
			�s t�	s � OpenInterval a b � t � OpenInterval c d � (s, t) � X
			�	f(s, t) � OpenInterval x y)
�	(�e u v� � 0 < e � (u, v) � X �
		�d1 d2 � � 0 < d1 � � 0 < d2 �
			�s t�	Abs(s - u) < d1 � Abs(t - v) < d2 � (s, t) � X
			�	Abs(f(s, t) - f(u, v)) < e)
�);
a(rewrite_tac[open_interval_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(list_spec_nth_asm_tac 3 [�f(u, v) + ~e�, �f(u, v) + e�, �u�, �v�]
	THEN_TRY SOLVED_T(PC_T1"�_lin_arith" asm_prove_tac[]));
a(lemma_tac�� 0 < u + ~a �  � 0 < b + ~u � � 0 < v + ~c � � 0 < d + ~v�
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(cases_tac�u + ~a < b + ~u� THEN cases_tac�v + ~c < d + ~v�);
(* *** Goal "1.1" *** *)
a(�_tac�u + ~a� THEN �_tac�v + ~c� THEN  asm_rewrite_tac[]);
a(ALL_FC_T1 fc_�_canon rewrite_tac[�_abs_diff_bounded_thm] THEN REPEAT �_tac THEN �_tac);
a(DROP_NTH_ASM_T 12 bc_thm_tac);
a(PC_T1"�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.2" *** *)
a(�_tac�u + ~a� THEN �_tac�d + ~v� THEN  asm_rewrite_tac[]);
a(ALL_FC_T1 fc_�_canon rewrite_tac[�_abs_diff_bounded_thm] THEN REPEAT �_tac THEN �_tac);
a(DROP_NTH_ASM_T 12 bc_thm_tac);
a(PC_T1"�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.3" *** *)
a(�_tac�b + ~u� THEN �_tac�v + ~c� THEN  asm_rewrite_tac[]);
a(ALL_FC_T1 fc_�_canon rewrite_tac[�_abs_diff_bounded_thm] THEN REPEAT �_tac THEN �_tac);
a(DROP_NTH_ASM_T 12 bc_thm_tac);
a(PC_T1"�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.4" *** *)
a(�_tac�b + ~u� THEN �_tac�d + ~v� THEN  asm_rewrite_tac[]);
a(ALL_FC_T1 fc_�_canon rewrite_tac[�_abs_diff_bounded_thm] THEN REPEAT �_tac THEN �_tac);
a(DROP_NTH_ASM_T 12 bc_thm_tac);
a(PC_T1"�_lin_arith" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac��e�� 0 < e � e � f(u, v) + ~x � e �  y + ~(f(u, v))� THEN1
	(cases_tac �f(u, v) + ~x � y + ~(f(u, v))�  THEN_LIST
	[�_tac�f(u, v) + ~x� THEN PC_T1 "�_lin_arith" asm_prove_tac[],
	 �_tac�y + ~(f(u, v))� THEN PC_T1 "�_lin_arith" asm_prove_tac[]]));
a(all_asm_fc_tac[]);
a(MAP_EVERY �_tac [�u + ~d1�, �u + d1�, �v + ~d2�, �v + d2�]);
a(strip_tac THEN_TRY SOLVED_T (PC_T1 "�_lin_arith" asm_prove_tac[]));
a(strip_tac THEN_TRY SOLVED_T (PC_T1 "�_lin_arith" asm_prove_tac[]));
a(REPEAT �_tac THEN �_tac);
a(LIST_SPEC_NTH_ASM_T 6 [�s�, �t�] ante_tac);
a(ALL_FC_T1 fc_�_canon rewrite_tac[�_abs_diff_bounded_thm]);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
val continuous_�_�_�_�_lemma = pop_thm ();
val continuous_�_�_�_�_thm3 = save_thm(
	"continuous_�_�_�_�_thm3",
	rewrite_rule[continuous_�_�_�_�_lemma] continuous_�_�_�_�_thm);
val continuous_�_�_�_�_thm4 = save_thm(
	"continuous_�_�_�_�_thm4",
	rewrite_rule[
		rewrite_rule[](�_elim�Universe:(� � �) SET�
			continuous_�_�_�_�_lemma)] continuous_�_�_�_�_thm1);

val plus_continuous_�_�_�_thm = save_thm ( "plus_continuous_�_�_�_thm", (
set_goal([], � (Uncurry $+) � ((O�R ��T O�R), O�R) Continuous �);
a(rewrite_tac[continuous_�_�_�_�_thm1] THEN REPEAT strip_tac);
a(MAP_EVERY �_tac[ �u - (1/2)*(u + v - x)�, �u + (1/2)*(y - (u + v))�,
	�v - (1/2)*(u + v - x)�, �v + (1/2)*(y - (u + v))�]);
a(POP_ASM_T ante_tac THEN rewrite_tac[open_interval_def] THEN REPEAT strip_tac
	THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val times_continuous_�_�_�_thm = save_thm ( "times_continuous_�_�_�_thm", (
set_goal([], � (Uncurry $*) � ((O�R ��T O�R), O�R) Continuous �);
a(rewrite_tac[continuous_�_�_�_�_thm4] THEN REPEAT strip_tac);
a(lemma_tac��t�Abs u + � 1 < t � Abs v < t�);
(* *** Goal "1" *** *)
a(cases_tac �Abs u + � 1 <  Abs v� THEN_LIST [
	�_tac � Abs v + � 1�, �_tac�Abs u + � 2�]
	THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�� 0  < � 2 * t� THEN1
	(strip_asm_tac(�_elim�v��_0_�_abs_thm) THEN PC_T1 "�_lin_arith" asm_prove_tac[]));
a(lemma_tac�� 0 < e * (� 2 * t) �-�1� THEN1
	(all_fc_tac[�_0_less_0_less_recip_thm] THEN all_fc_tac[�_0_less_0_less_times_thm]));
a(lemma_tac��d�� 0 <  d � d < � 1 � d <  e * (� 2 * t) �-�1�);
(* *** Goal "2.1" *** *)
a(cases_tac �� 1 < e * (� 2 * t) �-�1�THEN_LIST [
	�_tac �1/2�, �_tac�(1/2)* e * (� 2 * t) �-�1�]
	THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "2.2" *** *)
a(�_tac�d� THEN �_tac�d� THEN REPEAT strip_tac);
a(bc_thm_tac (rewrite_rule[]times_lim_seq_lemma));
a(�_tac�t� THEN REPEAT strip_tac THEN_TRY PC_T1 "�_lin_arith" asm_prove_tac[]);
a(DROP_NTH_ASM_T 2 ante_tac THEN ALL_FC_T1 fc_�_canon rewrite_tac[�_abs_diff_bounded_thm]);
a(DROP_NTH_ASM_T 8 ante_tac);
a(cases_tac�� 0 � s� THEN cases_tac �� 0 � u�
	THEN asm_rewrite_tac[�_abs_def]
	THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val cond_continuous_�_thm = save_thm ( "cond_continuous_�_thm", (
set_goal([], ��b c f g � Է
	� �  Topology
�	� �  Topology
�	c � (�, O�R) Continuous
�	f � (�, �) Continuous
�	g � (�, �) Continuous
�	(�x�x � Space�T � � c x = b � f x = g x)
�	(�x�if c x � b then f x else g x) � (�, �) Continuous
�);
a(REPEAT strip_tac);
a(LEMMA_T ��x�c x � b � x � {t|c t � b}� pure_once_rewrite_thm_tac THEN1
	rewrite_tac[]);
a(bc_thm_tac cond_continuous_thm THEN REPEAT strip_tac);
a(POP_ASM_T ante_tac THEN rewrite_tac[�_�_�_less_thm] THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 3 bc_thm_tac);
a(strip_asm_tac (list_�_elim[�c x�, �b�] �_less_cases_thm) THEN
	REPEAT strip_tac THEN  i_contr_tac);
(* *** Goal "1" *** *)
a(lemma_tac�{t | t < b} � O�R� THEN1
	rewrite_tac[half_infinite_intervals_open_thm]);
a(DROP_NTH_ASM_T 7 (fn th => all_fc_tac[rewrite_rule[continuous_def] th]));
a(spec_nth_asm_tac 5 �{x|x � Space�T � � c x � {t|t < b}}�);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�{t | b < t} � O�R� THEN1
	rewrite_tac[half_infinite_intervals_open_thm]);
a(DROP_NTH_ASM_T 7 (fn th => all_fc_tac[rewrite_rule[continuous_def] th]));
a(spec_nth_asm_tac 5 �{x|x � Space�T � � c x � {t|b < t}}�);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val d_�_metric_thm = save_thm ( "d_�_metric_thm", (
set_goal([], �
	D�R � Metric
�);
a(rewrite_tac[metric_def, d_�_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(rewrite_tac[�_0_�_abs_thm]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN rewrite_tac[�_abs_eq_0_thm] THEN PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[�_abs_0_thm]);
(* *** Goal "4" *** *)
a(pure_rewrite_tac[pc_rule1 "�_lin_arith" prove_rule[] �y + ~x = ~(x + ~y)�, �_abs_minus_thm]);
a(rewrite_tac[]);
(* *** Goal "5" *** *)
a(rewrite_tac[pc_rule1 "�_lin_arith" prove_rule[] �z + ~x = (y + ~x) + (z + ~y)�, �_abs_plus_thm]);
pop_thm()
));


val d_�_open_�_thm = save_thm ( "d_�_open_�_thm", (
set_goal([], �
	D�R MetricTopology = O�R
�);
a(PC_T1 "sets_ext1" rewrite_tac[metric_topology_def, open_�_delta_thm, d_�_def] THEN REPEAT strip_tac);
pop_thm()
));


val d_�_2_metric_thm = save_thm ( "d_�_2_metric_thm", (
set_goal([], �
	D�R2 � Metric
�);
a(LEMMA_T �D�R2 = (� ((x1, x2), y1, y2)� D�R (x1, y1) + D�R (x2, y2))� rewrite_thm_tac);
(* *** Goal "1" *** *)
a(rewrite_tac[d_�_def] THEN REPEAT strip_tac);
a(pure_once_rewrite_tac[prove_rule[]�x = (Fst x, Snd x)�]);
a(pure_rewrite_tac[d_�_2_def1]);
a(rewrite_tac[]);
(* *** Goal "2" *** *)
a(bc_thm_tac product_metric_thm THEN rewrite_tac[d_�_metric_thm]);
pop_thm()
));


val d_�_2_open_�_�_open_�_thm = save_thm ( "d_�_2_open_�_�_open_�_thm", (
set_goal([], �
	D�R2 MetricTopology = (O�R ��T O�R)
�);
a(LEMMA_T �D�R2 = (� ((x1, x2), y1, y2)� D�R (x1, y1) + D�R (x2, y2))� rewrite_thm_tac);
(* *** Goal "1" *** *)
a(rewrite_tac[d_�_def] THEN REPEAT strip_tac);
a(pure_once_rewrite_tac[prove_rule[]�x = (Fst x, Snd x)�]);
a(pure_rewrite_tac[d_�_2_def1]);
a(rewrite_tac[]);
(* *** Goal "2" *** *)
a(strip_asm_tac d_�_metric_thm);
a(ALL_FC_T rewrite_tac[product_metric_topology_thm]);
a(rewrite_tac[d_�_open_�_thm]);
pop_thm()
));


val open_�_hausdorff_thm = save_thm ( "open_�_hausdorff_thm", (
set_goal([], �
	O�R � Hausdorff
�);
a(rewrite_tac[eq_sym_rule d_�_open_�_thm]
	THEN bc_thm_tac metric_topology_hausdorff_thm
	THEN rewrite_tac[d_�_metric_thm]);
pop_thm()
));



val open_�_�_open_�_hausdorff_thm = save_thm ( "open_�_�_open_�_hausdorff_thm", (
set_goal([], �
	(O�R ��T O�R) � Hausdorff
�);
a(rewrite_tac[eq_sym_rule d_�_2_open_�_�_open_�_thm]
	THEN bc_thm_tac metric_topology_hausdorff_thm
	THEN rewrite_tac[d_�_2_metric_thm]);
pop_thm()
));


val �_lebesgue_number_thm = save_thm (
	"�_lebesgue_number_thm",
	pc_rule1 "predicates"
	rewrite_rule[d_�_def, d_�_metric_thm, d_�_open_�_thm, compact_compact_�_thm]
	(�_elim�D�R�lebesgue_number_thm));

val closed_interval_lebesgue_number_thm = save_thm (
	"closed_interval_lebesgue_number_thm",
	all_�_intro(
	pc_rule1 "predicates"
	rewrite_rule[closed_interval_compact_thm]
	(�_elim�ClosedInterval y z� �_lebesgue_number_thm)));

val dissect_unit_interval_thm = save_thm ( "dissect_unit_interval_thm", (
set_goal([], ��x�
	0. < x
�	�n t� 0 < n � t 0 = 0. � t n = 1.
�	(�i j� i < j � t i < t j)
�	(�i�t (i + 1) - t i < x)
�);
a(REPEAT strip_tac);
a(lemma_tac��n t� t 0 = 0. � t n = 1.
�	(�i�t i < t (i + 1) � t (i + 1) < t i + x)�);
(* *** Goal "1" *** *)
a(lemma_tac��n y� 0. < y � y < x � � n * y = 1.�);
(* *** Goal "1.1" *** *)
a(strip_asm_tac (�_elim�x� �_archimedean_recip_thm));
a(lemma_tac�0. < �(m + 1)� THEN1 rewrite_tac[�_less_thm]);
a(lemma_tac���(m + 1) = 0.� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(�_tac�m+1� THEN �_tac��(m+1) �-�1� THEN
	ALL_FC_T asm_rewrite_tac[�_0_less_0_less_recip_thm,
		�_recip_clauses]);
(* *** Goal "1.2" *** *)
a(�_tac�n� THEN �_tac��i� � i * y� THEN asm_rewrite_tac[
		�_plus_homomorphism_thm,
		�_times_plus_distrib_thm]);
(* *** Goal "2" *** *)
a(�_tac�n� THEN �_tac�t� THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(swap_nth_asm_concl_tac 2 THEN LEMMA_T�n = 0� asm_rewrite_thm_tac);
a(PC_T1 "lin_arith" asm_prove_tac[]);
(* *** Goal "2.2" *** *)
a(LEMMA_T �i + 1 � j� (strip_asm_tac o rewrite_rule[�_def])
	THEN1 PC_T1 "lin_arith" asm_prove_tac[]);
a(all_var_elim_asm_tac1);
a(POP_ASM_T discard_tac THEN induction_tac�i'� THEN asm_rewrite_tac[plus_assoc_thm1]);
a(bc_thm_tac �_less_trans_thm THEN �_tac�t ((i + 1) + i')� THEN
	asm_rewrite_tac[]);
(* *** Goal "2.3" *** *)
a(lemma_tac�t (i + 1) < t i + x� THEN1 asm_rewrite_tac[]);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val product_interval_cover_thm1 = save_thm ( "product_interval_cover_thm1", (
set_goal([], ��� U x�
	� � Topology
�	U � (� ��T O�R)
�	x � Space�T �
�	(�s� s � ClosedInterval 0. 1. � �B� (x, s) � B � B � U) 
�	�n t A� t 0 = 0. � t n = 1. � (�i�t i < t (i + 1))
	�	x � A
	�	A � �
	�	�i� i < n � �B� B � U � (A � ClosedInterval (t i) (t (i+1))) � B
�);
a(strip_asm_tac open_�_topology_thm);
a(REPEAT strip_tac);
a(lemma_tac�(� ��T O�R) � Topology� THEN1 basic_topology_tac[]);
a(lemma_tac�
	{I | I � O�R �
	�X B� x � X � X � � � B � U � (X � I) � B} � O�R�
	THEN1 PC_T1 "sets_ext1" prove_tac[]);
a(lemma_tac�
	ClosedInterval 0. 1. �
	� {I | I � O�R � �X B� x � X � X � � � B � U � (X � I) � B}
�);
(* *** Goal "1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]
	��b u t� b � u � u � t � b � t�]
	THEN swap_nth_asm_concl_tac 1);
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]);
a(rewrite_tac[product_topology_def] THEN swap_nth_asm_concl_tac 1
	THEN strip_tac THEN rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T [1] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(�_tac�B''� THEN REPEAT strip_tac);
a(�_tac�A� THEN �_tac�B� THEN REPEAT strip_tac);
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]
	��a b c� a � b � b � c � a � c�]);
(* *** Goal "2" *** *)
a(all_fc_tac[closed_interval_lebesgue_number_thm]);
a(all_fc_tac[dissect_unit_interval_thm]);
a(�_tac�n� THEN �_tac �t� THEN asm_rewrite_tac[]);
a(lemma_tac��Q��i� i < n �
	x � Q i � Q i � � �
	�B�B � U � (Q i � ClosedInterval (t i) (t(i + 1))) � B�
	THEN prove_�_tac THEN strip_tac);
(* *** Goal "2.1" *** *)
a(cases_tac�i' < n� THEN asm_rewrite_tac[]);
a(lemma_tac�t i' � ClosedInterval 0. 1.�);
(* *** Goal "2.1.1" *** *)
a(rewrite_tac[closed_interval_def]);
a(cases_tac�i' = 0� THEN1 asm_rewrite_tac[]);
a(lemma_tac�0 < i'� THEN1 PC_T1 "lin_arith" asm_prove_tac[]);
a(rewrite_tac[�_�_def] THEN LIST_DROP_NTH_ASM_T [5] (ALL_FC_T (MAP_EVERY ante_tac)));
a(asm_rewrite_tac[] THEN taut_tac);
(* *** Goal "2.1.2" *** *)
a(LIST_DROP_NTH_ASM_T [8] all_fc_tac);
a(�_tac�X� THEN REPEAT strip_tac THEN �_tac�B� THEN REPEAT strip_tac);
a(bc_thm_tac(pc_rule1 "sets_ext1" prove_rule[]
		��a b c� a � b � b � c � a � c�)
	THEN �_tac�X � A� THEN REPEAT strip_tac);
a(bc_thm_tac(pc_rule1 "sets_ext1" prove_rule[�_def]
		��x i a� i � a � (x � i) � (x � a)�));
a(rewrite_tac[closed_interval_def] THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(lemma_tac�Abs(x' - t i') < e�);
(* *** Goal "2.1.2.1" *** *)
a(rewrite_tac[�_abs_def]);
a(LEMMA_T �0. � x' + ~ (t i')� rewrite_thm_tac
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(lemma_tac�t(i' + 1) - t i' < e� THEN1 asm_rewrite_tac[]);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "2.1.2.2" *** *)
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
(* *** Goal "2.2" *** *)
a(strip_asm_tac(rewrite_rule[range_finite_size_thm]
	(list_�_elim[�Q�, �{i | i < n}�]finite_image_thm)));
a(�_tac��{y|� x� x < n � y = Q x}� THEN REPEAT strip_tac);
(* *** Goal "2.2.1" *** *)
a(all_var_elim_asm_tac1 THEN LIST_DROP_NTH_ASM_T [3] all_fc_tac);
(* *** Goal "2.2.2" *** *)
a(bc_thm_tac (�_open_thm) THEN asm_rewrite_tac[]);
a(strip_tac THEN1 PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "2.2.2.1" *** *)
a(�_tac�Q 0� THEN asm_rewrite_tac[]);
a(�_tac�0� THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac);
a(all_var_elim_asm_tac1 THEN LIST_DROP_NTH_ASM_T [3] all_fc_tac);
(* *** Goal "2.2.3" *** *)
a(DROP_NTH_ASM_T 3 (strip_asm_tac o �_elim�i�));
a(�_tac�B� THEN REPEAT strip_tac);
a(bc_thm_tac(pc_rule1 "sets_ext1" prove_rule[]
		��a b c� a � b � b � c � a � c�)
	THEN �_tac�Q i � ClosedInterval (t i) (t (i + 1))� THEN REPEAT strip_tac);
a(bc_thm_tac(pc_rule1 "sets_ext1" prove_rule[�_def]
		��x y i� x � y � (x � i) � (y � i)�));
a(DROP_NTH_ASM_T 5 ante_tac THEN DROP_ASMS_T discard_tac);
a(strip_tac THEN PC_T "sets_ext1" strip_tac);
a(rewrite_tac[�_def] THEN REPEAT strip_tac);
a(asm_prove_tac[]);
(* *** Goal "2.3" *** *)
a(strip_tac THEN DROP_NTH_ASM_T 3 bc_thm_tac THEN REPEAT strip_tac);
pop_thm()
));


val inc_seq_thm = save_thm ( "inc_seq_thm", (
set_goal([], ��t: � � �; i j�
	(�i� t i < t (i + 1))
�	(�i j� i < j � t i < t j)�);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(POP_ASM_T ante_tac THEN induction_tac�j� THEN strip_tac);
(* *** Goal "1.1" *** *)
a(lemma_tac�i = j� THEN1 PC_T1 "lin_arith" asm_prove_tac[]
	THEN asm_rewrite_tac[]);
(* *** Goal "1.2" *** *)
a(bc_thm_tac �_less_trans_thm THEN �_tac�t j�
	THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(POP_ASM_T bc_thm_tac THEN rewrite_tac[]);
(* *** Goal "2" *** *)
pop_thm()
));

val product_interval_cover_thm = save_thm ("product_interval_cover_thm",
	rewrite_rule[inc_seq_thm] product_interval_cover_thm1);
rewrite_rule[cts_at_�_continuous_thm] minus_cts_thm;


local
	
val �_continuity_fact_thms : THM list =
	map (rewrite_rule[cts_at_�_continuous_thm]) (
		�_�_exp_cts_thm::
		minus_cts_thm::
		exp_cts_thm::
		(map all_�_intro o strip_�_rule o all_�_elim)
			sin_cos_cts_thm) @ [
	plus_continuous_�_�_�_thm,
	times_continuous_�_�_�_thm,
	open_�_topology_thm,
	space_t_�_thm];


in
(*
*)
fun �_continuity_tac (thms : THM list): TACTIC = (
	basic_continuity_tac (thms @ �_continuity_fact_thms)
);
end (* local ... in ... end *);



open_theory "homotopy";
set_merge_pcs["basic_hol1", "'sets_alg", "'�", "'�"];
val paths_def = get_spec�$Paths�;
val path_connected_def = get_spec�$PathConnected�;
val locally_path_connected_def = get_spec�LocallyPathConnected�;
val homotopy_def = get_spec�$Homotopy�;
val homotopy_class_def = get_spec�$HomotopyClass�;
val path_plus_def = get_spec�$+�P�;
val path_0_def = get_spec�0�P�;
val path_minus_def = get_spec�~�P�;
val homotopy_lifting_property_def = get_spec�HomotopyLiftingProperty�;

val path_connected_connected_thm = save_thm ( "path_connected_connected_thm", (
set_goal([], ��� X�
	� � Topology
�	X � � PathConnected
�	X � � Connected
�);
a(rewrite_tac[path_connected_def, paths_def] THEN REPEAT strip_tac);
a(bc_thm_tac connected_pointwise_bc_thm THEN REPEAT strip_tac);
a(list_spec_nth_asm_tac 3 [�x�, �y�]);
a(ante_tac(list_�_elim[�f�, �Universe:� SET�, �O�R�, �Ԯ] image_connected_thm));
a(pure_asm_rewrite_tac[open_�_topology_thm, universe_�_connected_thm]);
a(rewrite_tac[] THEN REPEAT strip_tac);
a(�_tac�{y|� x� y = f x}� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(all_var_elim_asm_tac1 THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(�_tac�� 0� THEN asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(�_tac�� 1� THEN asm_rewrite_tac[]);
pop_thm()
));


val product_path_connected_thm = save_thm ( "product_path_connected_thm", (
set_goal([], ��� � X Y�
	� � Topology
�	� � Topology
�	X � � PathConnected
�	Y � � PathConnected
�	(X � Y) � (� ��T �) PathConnected
�);
a(rewrite_tac[path_connected_def, paths_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ALL_FC_T rewrite_tac[product_topology_space_t_thm]);
a(LIST_GET_NTH_ASM_T [2, 4] (MAP_EVERY ante_tac));
a(MERGE_PCS_T1 ["'bin_rel", "sets_ext1"] prove_tac[]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN POP_ASM_T ante_tac);
a(rewrite_tac[�_def] THEN REPEAT strip_tac);
a(list_spec_nth_asm_tac 7 [�Fst x�, �Fst y�]);
a(list_spec_nth_asm_tac 11 [�Snd x�, �Snd y�]);
(* *** Goal "2.1" *** *)
a(�_tac��t�(f t, f' t)� THEN asm_rewrite_tac[] THEN REPEAT strip_tac
	THEN_TRY SOLVED_T (ALL_ASM_FC_T asm_rewrite_tac[]));
a(bc_thm_tac product_continuous_thm THEN REPEAT strip_tac);
a(accept_tac open_�_topology_thm);
pop_thm()
));


val homotopy_class_refl_thm = save_thm ( "homotopy_class_refl_thm", (
set_goal([], ��� X � f�
	� � Topology
�	� � Topology
�	f � (�, �) Continuous
�	f � ((�, X, �) HomotopyClass) f
�);
a(rewrite_tac[ homotopy_def, homotopy_class_def ] THEN REPEAT strip_tac);
a(asm_tac open_�_topology_thm);
a(�_tac�� x� f (Fst x)� THEN asm_rewrite_tac[]);
a(�_continuity_tac[]);
pop_thm()
));

val �_un_�_rand_conv : CONV = (fn tm =>
	let	val (v, _) = dest_� tm;
	in	SIMPLE_�_C (RAND_C (un_�_conv v)) tm
	end
);



val homotopy_class_sym_thm = save_thm ( "homotopy_class_sym_thm", (
set_goal([], ��� : 'a SET SET; X � f g�
	� � Topology
�	� � Topology
�	g � ((�, X, �) HomotopyClass) f
�	f � ((�, X, �) HomotopyClass) g
�);
a(rewrite_tac[ homotopy_def, homotopy_class_def ] THEN REPEAT strip_tac);
a(�_tac�� xt� H(Fst xt, � 1 -  Snd xt)� THEN asm_rewrite_tac[]);
a(�_continuity_tac[]);
pop_thm()
));


val homotopy_class_trans_thm = save_thm ( "homotopy_class_trans_thm", (
set_goal([], ��� : 'a SET SET; X � f g h�
	� � Topology
�	� � Topology
�	g � ((�, X, �) HomotopyClass) f
�	h � ((�, X, �) HomotopyClass) g
�	h � ((�, X, �) HomotopyClass) f
�);
a(rewrite_tac[ homotopy_def, homotopy_class_def ] THEN REPEAT strip_tac);
a(�_tac�
	� xt�
	if	Snd xt � 1/2
	then	H(Fst xt, � 2 * Snd xt)
	else	H'(Fst xt, � 2 * (Snd xt + ~ (1/2)))� THEN asm_rewrite_tac[]);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(strip_asm_tac open_�_topology_thm THEN ALL_FC_T asm_rewrite_tac[product_topology_thm]);
a(REPEAT strip_tac THEN_TRY �_continuity_tac[]
	THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(LEMMA_T ��t� H(x, t) = g x � H'(x, t) = g x� rewrite_thm_tac THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(LIST_DROP_NTH_ASM_T [6] (rewrite_tac o map (conv_rule(ONCE_MAP_C eq_sym_conv))));
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(LIST_DROP_NTH_ASM_T [3] (rewrite_tac o map (conv_rule(ONCE_MAP_C eq_sym_conv))));
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "2.3" *** *)
a(cases_tac �s � 1/2� THEN cases_tac �t � 1/2� THEN  asm_rewrite_tac[]);
pop_thm()
));


val homotopy_�_thm = save_thm ( "homotopy_�_thm", (
set_goal([], ��� X Y � H�
	� � Topology
�	� � Topology
�	H � (�, X, �) Homotopy
�	Y � X
�	H � (�, Y, �) Homotopy
�);
a(rewrite_tac[ homotopy_def ] THEN REPEAT strip_tac);
a(PC_T1 "sets_ext1" all_asm_fc_tac[]);
a(ALL_ASM_FC_T rewrite_tac[]);
pop_thm()
));


val homotopy_class_�_thm = save_thm ( "homotopy_class_�_thm", (
set_goal([], ��� X Y � f g�
	� � Topology
�	� � Topology
�	g � ((�, X, �) HomotopyClass) f
�	Y � X
�	g � ((�, Y, �) HomotopyClass) f
�);
a(rewrite_tac[ homotopy_class_def ] THEN REPEAT strip_tac);
a(�_tac�H� THEN ALL_FC_T asm_rewrite_tac[homotopy_�_thm]);
pop_thm()
));


val homotopy_class_comp_left_thm = save_thm ( "homotopy_class_comp_left_thm", (
set_goal([], ��� � � X f g h�
	� � Topology
�	� � Topology
�	� � Topology
�	g � ((�, X, �) HomotopyClass) f
�	h � (�,�) Continuous
�	(�x�h(g x)) � ((�, X, �) HomotopyClass) (�x�h(f x))
�);
a(rewrite_tac[ homotopy_def, homotopy_class_def ] THEN REPEAT strip_tac);
a(�_tac��xt� h(H xt)� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac comp_continuous_thm);
a(�_tac�Ӯ THEN REPEAT strip_tac);
a(bc_thm_tac product_topology_thm THEN asm_rewrite_tac[open_�_topology_thm]);
(* *** Goal "2" *** *)
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "4" *** *)
a(asm_rewrite_tac[]);
pop_thm()
));


val homotopy_class_comp_right_thm = save_thm ( "homotopy_class_comp_right_thm", (
set_goal([], ��� � � X f g h�
	� � Topology
�	� � Topology
�	� � Topology
�	g � ((�, X, �) HomotopyClass) f
�	h � (�,�) Continuous
�	(�x�g(h x)) � ((�, {x | h x � X}, �) HomotopyClass) (�x�f(h x))
�);
a(rewrite_tac[ homotopy_def, homotopy_class_def ] THEN REPEAT strip_tac);
a(�_tac��xt� H ((�xt� (h(Fst xt), Snd xt)) xt)� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac comp_continuous_thm);
a(strip_asm_tac open_�_topology_thm);
a(�_tac�(� ��T O�R)� THEN ALL_FC_T asm_rewrite_tac[product_topology_thm]);
a(pure_once_rewrite_tac[prove_rule[]��x�h(Fst x) = (�x�h(Fst x))x�]);
a(bc_thm_tac product_continuous_thm);
a(ALL_FC_T asm_rewrite_tac[product_topology_thm] THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(bc_thm_tac comp_continuous_thm);
a(�_tac�Ү THEN ALL_FC_T asm_rewrite_tac[product_topology_thm]);
a(rewrite_tac[prove_rule[]�Fst = (�(x, y)� x)�]);
a(bc_thm_tac left_proj_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "1.2" *** *)
a(rewrite_tac[prove_rule[]�Snd = (�(x, y)� y)�]);
a(bc_thm_tac right_proj_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "4" *** *)
a(asm_rewrite_tac[]);
pop_thm()
));


val homotopy_class_�_thm = save_thm ( "homotopy_class_�_thm", (
set_goal([], ��� f g �
	� � Topology
�	f � (�,O�R) Continuous
�	g � (�,O�R) Continuous
�	g � ((�, {x | g x = f x}, O�R) HomotopyClass) f
�);
a(rewrite_tac[ homotopy_def, homotopy_class_def ] THEN REPEAT strip_tac);
a(�_tac��xt� (� 1 + ~(Snd xt))*f (Fst xt) + (Snd xt)*g(Fst xt) � THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(pure_once_rewrite_tac[prove_rule[]��x y:�� x + y = Uncurry $+ (x, y)�]);
a(conv_tac (LEFT_C �_un_�_rand_conv));
a(bc_thm_tac comp_continuous_thm);
a(�_tac�O�R ��T O�R� THEN asm_rewrite_tac[plus_continuous_�_�_�_thm]);
a(strip_asm_tac open_�_topology_thm);
a(ALL_FC_T asm_rewrite_tac[product_topology_thm]);
a(�_continuity_tac[]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[] THEN PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "4" *** *)
a(asm_rewrite_tac[]);
pop_thm()
));




val half_open_interval_retract_thm = save_thm ( "half_open_interval_retract_thm", (
set_goal([], ��b�
	(�s� if s � b then s else b) �
	(O�R, {s | s � b} �T O�R) Continuous
�);
a(REPEAT strip_tac THEN strip_asm_tac open_�_topology_thm);
a(lemma_tac�{s | s � b} � Space�T O�R�
	THEN1 rewrite_tac[space_t_�_thm]);
a(ALL_FC_T1 fc_�_canon rewrite_tac
	[subspace_range_continuous_�_thm]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(asm_rewrite_tac[space_t_�_thm]);
a(REPEAT strip_tac THEN �_continuity_tac[]);
(* *** Goal "2" *** *)
a(cases_tac�x � b� THEN asm_rewrite_tac[]);
pop_thm()
));


val closed_interval_retract_thm = save_thm ( "closed_interval_retract_thm", (
set_goal([], ��a b�
	a � b
�	(�s� if s � a then a else if s � b then s else b) �
	(O�R, ClosedInterval a b �T O�R) Continuous
�);
a(REPEAT strip_tac THEN strip_asm_tac open_�_topology_thm);
a(lemma_tac�ClosedInterval a b � Space�T O�R�
	THEN1 rewrite_tac[space_t_�_thm]);
a(ALL_FC_T1 fc_�_canon rewrite_tac
	[subspace_range_continuous_�_thm]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(asm_rewrite_tac[space_t_�_thm]);
a(REPEAT strip_tac THEN_TRY �_continuity_tac[] THEN_TRY asm_rewrite_tac[]);
a(ho_bc_thm_tac cond_continuous_�_thm);
a(asm_rewrite_tac[space_t_�_thm]);
a(REPEAT strip_tac THEN �_continuity_tac[]);
(* *** Goal "2" *** *)
a(rewrite_tac[closed_interval_def]);
a(cases_tac�x � a� THEN asm_rewrite_tac[]);
a(cases_tac�x � b� THEN asm_rewrite_tac[]);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val �_closed_interval_retract_thm = save_thm ( "�_closed_interval_retract_thm", (
set_goal([], ��� X a b�
	� � Topology
�	X � Space�T �
�	a � b
�	(�(x, s)� (x, if s � a then a else if s � b then s else b)) �
	((X � Universe) �T (� ��T O�R),
		(X � ClosedInterval a b) �T (� ��T O�R)) Continuous
�);
a(REPEAT strip_tac THEN strip_asm_tac open_�_topology_thm);
a(lemma_tac�� ��T O�R � Topology� THEN1 basic_topology_tac[]);
a(lemma_tac�(X � ClosedInterval a b) � Space�T (� ��T O�R)�);
(* *** Goal "1" *** *)
a(ALL_FC_T rewrite_tac[product_topology_space_t_thm]);
a(rewrite_tac[space_t_�_thm]);
a(DROP_NTH_ASM_T 4 ante_tac);
a(MERGE_PCS_T1 ["'pair", "sets_ext1"] prove_tac[�_def]);
(* *** Goal "2" *** *)
a(lemma_tac�(X � Universe) �T � ��T O�R � Topology�
	THEN1 (bc_tac[subspace_topology_thm, product_topology_thm] THEN REPEAT strip_tac));
a(ALL_FC_T1 fc_�_canon rewrite_tac
	[subspace_range_continuous_�_thm]
	THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(LEMMA_T �(� (x:'a, s)� (x, (if s � a then a else if s � b then s else b))) =
	(� xs� (Fst xs, (�xs�if Snd xs � a then a else if Snd xs � b then Snd xs else b) xs))�
	pure_rewrite_thm_tac
	THEN1 prove_tac[]);
a(bc_thm_tac product_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "2.1.1" *** *)
a(bc_tac[subspace_domain_continuous_thm, fst_continuous_thm]
	THEN REPEAT strip_tac);
(* *** Goal "2.1.2" *** *)
a(bc_thm_tac subspace_domain_continuous_thm THEN REPEAT strip_tac);
a(LEMMA_T �(� xs� if Snd xs � a then a else if Snd xs � b then Snd xs else b) =
	(�xs� (� s� if s � a then a else if s � b then s else b)(Snd xs))�
	pure_rewrite_thm_tac
	THEN1 prove_tac[]);
a(bc_thm_tac comp_continuous_thm);
a(�_tac�O�R� THEN REPEAT strip_tac);
(* *** Goal "2.1.2.1" *** *)
a(bc_thm_tac snd_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "2.1.2.2" *** *)
a(all_fc_tac[closed_interval_retract_thm]);
a(all_fc_tac[subspace_range_continuous_thm]);
(* *** Goal "2.2" *** *)
a(POP_ASM_T ante_tac);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm,
	product_topology_space_t_thm]);
a(rewrite_tac[�_def] THEN REPEAT strip_tac);
a(rewrite_tac[closed_interval_def]);
a(cases_tac�Snd x � a� THEN asm_rewrite_tac[]);
a(cases_tac �Snd x � b� THEN asm_rewrite_tac[]);
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val closed_interval_extension_thm = save_thm ( "closed_interval_extension_thm", (
set_goal([], ���; �; f : 'a � � � 'b; X a b�
	� � Topology
�	� � Topology
�	X � Space�T �
�	a � b
�	f � ((X � ClosedInterval a b) �T � ��T O�R, �) Continuous
�	�g : 'a � � � 'b�
	g � ((X � Universe) �T (� ��T O�R), �) Continuous
�	�x s�	x � X � s � ClosedInterval a b
	�	g(x, s) = f(x, s)
�);
a(REPEAT strip_tac THEN all_fc_tac[�_closed_interval_retract_thm]);
a(strip_asm_tac open_�_topology_thm);
a(�_tac��xs�f((� (x, s)� (x, (if s � a then a else if s � b then s else b))) xs)�
	THEN strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac comp_continuous_thm THEN REPEAT strip_tac);
a(�_tac�(X � ClosedInterval a b) �T � ��T O�R�);
a(asm_rewrite_tac[] THEN REPEAT strip_tac
	THEN bc_tac[subspace_topology_thm, product_topology_thm]
	THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(rewrite_tac[closed_interval_def] THEN REPEAT strip_tac);
a(cases_tac�s = a� THEN1 asm_rewrite_tac[]);
a(lemma_tac��s � a� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(asm_rewrite_tac[]);
pop_thm()
));



val �_interval_glueing_thm = save_thm ( "�_interval_glueing_thm", (
set_goal([], ���; �; f g : 'a � � � 'b; X a b�
	� � Topology
�	� � Topology
�	X � Space�T �
�	a � b � b � c
�	f � ((X � ClosedInterval a b) �T � ��T O�R, �) Continuous
�	g � ((X � ClosedInterval b c) �T � ��T O�R, �) Continuous
�	(�x� x � X � f(x, b) = g(x, b))
�	�h : 'a � � � 'b�
	h � ((X � ClosedInterval a c) �T � ��T O�R, �) Continuous
�	(�x s�	x � X � s � ClosedInterval a b
	�	h(x, s) = f(x, s))
�	(�x s�	x � X � s � ClosedInterval b c
	�	h(x, s) = g(x, s))
�);
a(REPEAT strip_tac);
a(all_fc_tac[closed_interval_extension_thm]);
a(strip_asm_tac open_�_topology_thm);
a(LIST_DROP_NTH_ASM_T [7, 8] discard_tac
	THEN rename_tac[(�g'�, "eg"), (�g''�, "ef")]);
a(�_tac��xs� if Snd xs � b then ef xs else eg xs�
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(lemma_tac�(X � ClosedInterval a c) � (X � Universe)�
	THEN1 MERGE_PCS_T1 ["'pair", "sets_ext1"] prove_tac[�_def]);
a(lemma_tac�� ��T O�R � Topology� THEN1 basic_topology_tac[]);
a(ALL_FC_T (once_rewrite_tac o map (conv_rule (ONCE_MAP_C eq_sym_conv)))
	 [�_subspace_topology_thm]);
a(bc_thm_tac subspace_domain_continuous_thm);
a(REPEAT strip_tac THEN1 (bc_thm_tac subspace_topology_thm THEN REPEAT strip_tac));
a(LEMMA_T ��xs�Snd xs � b � xs � {(x, s) | s � b}� pure_once_rewrite_thm_tac
	THEN1 rewrite_tac[]);
a(lemma_tac�(X � Universe) �T � ��T O�R � Topology�
	THEN1 (bc_thm_tac subspace_topology_thm THEN REPEAT strip_tac));
a(bc_thm_tac cond_continuous_thm THEN REPEAT strip_tac);
a(DROP_NTH_ASM_T 2 ante_tac);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]);
a(rewrite_tac[�_def] THEN strip_tac);
a(lemma_tac�Snd x = b�);
(* *** Goal "1.1" *** *)
a(lemma_tac�Snd x < b � Snd x = b � b < Snd x�
	THEN1 PC_T1 "�_lin_arith" prove_tac[] THEN i_contr_tac);
(* *** Goal "1.1.1" *** *)
a(swap_nth_asm_concl_tac 4 THEN strip_tac);
a(�_tac�X � OpenInterval (Snd x + ~1.) b� THEN REPEAT strip_tac);
(* *** Goal "1.1.1.1" *** *)
a(PC_T1 "sets_ext1" asm_rewrite_tac[�_def, open_interval_def]
	THEN PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "1.1.1.2" *** *)
a(rewrite_tac[subspace_topology_def]);
a(�_tac�Space�T � �  OpenInterval (Snd x + ~ 1.) b�
	THEN REPEAT strip_tac);
(* *** Goal "1.1.1.2.1" *** *)
a(rewrite_tac[product_topology_def, �_def] THEN REPEAT strip_tac);
a(�_tac�Space�T Ү THEN �_tac�OpenInterval (Snd x + ~ 1.) b�
	THEN asm_rewrite_tac[open_interval_open_thm]);
a(ALL_FC_T rewrite_tac[space_t_open_thm]);
(* *** Goal "1.1.1.2.2" *** *)
a(DROP_NTH_ASM_T 15 ante_tac
	THEN MERGE_PCS_T1 ["'pair", "sets_ext1"] prove_tac[�_def]);
(* *** Goal "1.1.1.3" *** *)
a(swap_nth_asm_concl_tac 1);
a(DROP_NTH_ASM_T 3 ante_tac);
a(rewrite_tac[�_def, open_interval_def]);
a(PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "1.1.2" *** *)
a(swap_nth_asm_concl_tac 4 THEN strip_tac);
a(�_tac�X � OpenInterval b (Snd x + 1.)� THEN REPEAT strip_tac);
(* *** Goal "1.1.2.1" *** *)
a(PC_T1 "sets_ext1" asm_rewrite_tac[�_def, open_interval_def]
	THEN PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "1.1.2.2" *** *)
a(rewrite_tac[subspace_topology_def]);
a(�_tac�Space�T � �  OpenInterval b (Snd x + 1.)�
	THEN REPEAT strip_tac);
(* *** Goal "1.1.2.2.1" *** *)
a(rewrite_tac[product_topology_def, �_def] THEN REPEAT strip_tac);
a(�_tac�Space�T Ү THEN �_tac�OpenInterval b (Snd x + 1.)�
	THEN asm_rewrite_tac[open_interval_open_thm]);
a(ALL_FC_T rewrite_tac[space_t_open_thm]);
(* *** Goal "1.1.2.2.2" *** *)
a(DROP_NTH_ASM_T 15 ante_tac
	THEN MERGE_PCS_T1 ["'pair", "sets_ext1"] prove_tac[�_def]);
(* *** Goal "1.1.2.3" *** *)
a(swap_nth_asm_concl_tac 2);
a(DROP_NTH_ASM_T 1 ante_tac);
a(rewrite_tac[�_def, open_interval_def]);
a(PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "1.2" *** *)
a(lemma_tac�Snd x � ClosedInterval a b � Snd x � ClosedInterval b c�
	THEN1 (rewrite_tac[closed_interval_def]
		THEN PC_T1 "�_lin_arith" asm_prove_tac[]));
a(LIST_DROP_NTH_ASM_T [11, 13] (ALL_FC_T (MAP_EVERY ante_tac)));
a(rewrite_tac[] THEN REPEAT (STRIP_T rewrite_thm_tac));
a(LEMMA_T�x = (Fst x, b)� once_rewrite_thm_tac THEN1 asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 13 bc_thm_tac THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(POP_ASM_T (strip_asm_tac o rewrite_rule[closed_interval_def]));
a(asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 5 bc_thm_tac THEN asm_rewrite_tac[closed_interval_def]);
(* *** Goal "3" *** *)
a(POP_ASM_T (strip_asm_tac o rewrite_rule[closed_interval_def]));
a(asm_rewrite_tac[]);
a(cases_tac�s = b� THEN1 all_var_elim_asm_tac1);
(* *** Goal "3.1" *** *)
a(LEMMA_T �g(x, b) = f(x, b)� rewrite_thm_tac
	THEN1 LIST_DROP_NTH_ASM_T [7] (ALL_FC_T rewrite_tac));
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN asm_rewrite_tac[closed_interval_def]);
(* *** Goal "3.2" *** *)
a(lemma_tac��s � b� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 9 bc_thm_tac THEN asm_rewrite_tac[closed_interval_def]);
pop_thm()
));



val paths_continuous_thm = save_thm ( "paths_continuous_thm", (
set_goal([], ��� f�
	� � Topology
�	f � Paths �
�	f � (O�R, �) Continuous
�);
a(prove_tac[paths_def]);
pop_thm()
));

val paths_representative_thm = save_thm ( "paths_representative_thm", (
set_goal([], ��� f�
	� � Topology
�	f � (O�R, �) Continuous
�	��1 g� g � Paths � � �s� s � ClosedInterval 0. 1. � g s = f s
�);
a(rewrite_tac[paths_def] THEN REPEAT strip_tac);
a(��1_tac ��t� if t � 0. then f 0. else if t � 1. then f t else f 1.�
	THEN rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(asm_rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY �_continuity_tac[] THEN_TRY asm_rewrite_tac[]);
(* *** Goal "1.1" *** *)
a(bc_thm_tac continuous_�_space_t_thm);
a(�_tac�O�R� THEN asm_rewrite_tac[space_t_�_thm]);
(* *** Goal "1.2" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(asm_rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY �_continuity_tac[] THEN_TRY asm_rewrite_tac[]);
a(bc_thm_tac continuous_�_space_t_thm);
a(�_tac�O�R� THEN asm_rewrite_tac[space_t_�_thm]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(LEMMA_T�� x � 0.� asm_rewrite_thm_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(cases_tac�x = 1.� THEN1 asm_rewrite_tac[]);
a(LEMMA_T�� x � 1.� rewrite_thm_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "4" *** *)
a(POP_ASM_T (strip_asm_tac o rewrite_rule[closed_interval_def]));
a(cases_tac�s = 0.� THEN asm_rewrite_tac[]);
a(LEMMA_T�� s � 0.� asm_rewrite_thm_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "5" *** *)
a(POP_ASM_T (strip_asm_tac o rewrite_rule[closed_interval_def]));
a(cases_tac �x � 0.� THEN ALL_ASM_FC_T asm_rewrite_tac[]);
(* *** Goal "5.1" *** *)
a(DROP_NTH_ASM_T 2 bc_thm_tac THEN REPEAT strip_tac);
(* *** Goal "5.2" *** *)
a(cases_tac�x � 1.� THEN asm_rewrite_tac[]);
(* *** Goal "5.2.1" *** *)
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "5.2.2" *** *)
a(lemma_tac�1. � x� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(LIST_DROP_NTH_ASM_T [5] (ALL_FC_T rewrite_tac));
a(DROP_NTH_ASM_T 4 bc_thm_tac THEN REPEAT strip_tac);
pop_thm()
));


val path_0_path_thm = save_thm ( "path_0_path_thm", (
set_goal([], ��� x�
	� � Topology
�	x � Space�T �
�	0�P x � Paths �
�);
a(rewrite_tac[paths_def, path_0_def] THEN REPEAT strip_tac);
a(strip_asm_tac open_�_topology_thm);
a(all_fc_tac[const_continuous_thm]);
pop_thm()
));


val path_plus_path_thm = save_thm ( "path_plus_path_thm", (
set_goal([], ��� f g�
	� � Topology
�	f � Paths �
�	g � Paths �
�	g(� 0) = f(� 1)
�	f +�P g � Paths �
�);
a(rewrite_tac[paths_def, path_plus_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(strip_asm_tac open_�_topology_thm THEN asm_rewrite_tac[]);
a(REPEAT strip_tac THEN_TRY SOLVED_T (�_continuity_tac []));
a(all_var_elim_asm_tac1 THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(LEMMA_T �x � 1 / 2� rewrite_thm_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(DROP_NTH_ASM_T 7 bc_thm_tac THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(LEMMA_T ��x � 1 / 2� rewrite_thm_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val path_minus_path_thm = save_thm ( "path_minus_path_thm", (
set_goal([], ��� f�
	� � Topology
�	f � Paths �
�	 ~�P f � Paths �
�);
a(rewrite_tac[path_minus_def, paths_def] THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(�_continuity_tac []);
(* *** Goal "2" *** *)
a(DROP_NTH_ASM_T 2 bc_thm_tac THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val path_plus_assoc_lemma1 = (* not saved *) snd ( "path_plus_assoc_lemma1", (
set_goal([], ��� f g h k�
	� � Topology
�	f � Paths �
�	g � Paths �
�	h � Paths �
�	(�t�k t = if t � 1/4 then � 2*t else if t � 1/2 then t + 1/4 else (1/2)*t + 1/2)
�	((f +�P g) +�P h) = �t� (f +�P (g +�P h)) (k t)
�);
a(rewrite_tac[paths_def, path_plus_def] THEN REPEAT strip_tac);
a(asm_rewrite_tac[]);
a(cases_tac�x � 1/4� THEN cases_tac �x � 1/2� THEN asm_rewrite_tac[]);
(* *** Goal "1" *** *)
a(LEMMA_T�� 2*x � 1/2�  rewrite_thm_tac THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "3" *** *)
a(LEMMA_T��� 2*x � 1/2 � �x + 1/4 � 1/2�  rewrite_thm_tac
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(LEMMA_T�� 2 * ((x + 1 / 4) + ~ (1 / 2)) � 1 / 2�  rewrite_thm_tac
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(conv_tac (ONCE_MAP_C �_anf_conv) THEN strip_tac);
(* *** Goal "4" *** *)
a(LEMMA_T��(1/2)*x � � 0�  rewrite_thm_tac
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(LEMMA_T��� 2 * ((1 / 2 * x + 1 / 2) + ~ (1 / 2)) � 1 / 2�  rewrite_thm_tac
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(conv_tac (ONCE_MAP_C �_anf_conv) THEN strip_tac);
pop_thm()
));


val path_plus_assoc_lemma2 = (* not saved *) snd ( "path_plus_assoc_lemma2", (
set_goal([], ��k�
	(�t�k t = if t � 1/4 then � 2*t else if t � 1/2 then t + 1/4 else (1/2)*t + 1/2)
�	k � (O�R, O�R) Continuous
�);
a(REPEAT strip_tac);
a(pure_once_rewrite_tac[conv_rule(ONCE_MAP_C eq_sym_conv) (�_elim�k��_axiom)]);
a(POP_ASM_T pure_rewrite_thm_tac);
a(ho_bc_thm_tac cond_continuous_�_thm);
a(rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY SOLVED_T (�_continuity_tac []));
(* *** Goal "1" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY SOLVED_T (�_continuity_tac []));
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(all_var_elim_asm_tac1 THEN rewrite_tac[]);
pop_thm()
));


val path_plus_assoc_lemma3 = (* not saved *) snd ( "path_plus_assoc_lemma3", (
set_goal([], ��k�
	(�t�k t = if t � 1/4 then � 2*t else if t � 1/2 then t + 1/4 else (1/2)*t + 1/2)
�	k � ((O�R, {� 0; � 1},O�R) HomotopyClass) (�x�x)
�);
a(REPEAT strip_tac);
a(bc_thm_tac homotopy_class_�_thm);
a(strip_asm_tac open_�_topology_thm THEN asm_rewrite_tac[]);
a(�_tac�{x | k x = (�x� x) x}� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac homotopy_class_�_thm);
a(ALL_FC_T asm_rewrite_tac[id_continuous_thm, path_plus_assoc_lemma2]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[]);
pop_thm()
));


val path_plus_assoc_thm = save_thm ( "path_plus_assoc_thm", (
set_goal([], ��� f g h�
	� � Topology
�	f � Paths �
�	g � Paths �
�	h � Paths �
�	g(� 0) = f(� 1)
�	h(� 0) = g(� 1)
�	((f +�P g) +�P h) � ((O�R, {� 0; � 1}, �) HomotopyClass)(f +�P (g +�P h))
�);
a(REPEAT strip_tac);
a(lemma_tac��k��t�k t = if t � 1/4 then � 2*t else if t � 1/2 then t + 1/4 else (1/2)*t + 1/2�
	THEN1 prove_�_tac);
a(strip_asm_tac open_�_topology_thm);
a(all_fc_tac[path_plus_assoc_lemma2, path_plus_assoc_lemma3]);
a(pure_once_rewrite_tac[prove_rule[]�f +�P g +�P h = �t�(f +�P g +�P h)((�x� x) t)�]);
a(PC_T1 "predicates" (ALL_FC_T pure_rewrite_tac)[path_plus_assoc_lemma1]);
a(bc_thm_tac homotopy_class_comp_left_thm);
a(�_tac�O�R� THEN REPEAT strip_tac);
a(bc_tac [path_plus_path_thm, paths_continuous_thm]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_tac [path_plus_path_thm, paths_continuous_thm]
	THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[path_plus_def]);
pop_thm()
));


val path_plus_0_lemma1 = (* not saved *) snd ( "path_plus_0_lemma1", (
set_goal([], ��� f k�
	� � Topology
�	f � Paths �
�	(�t�k t = if t � 1/2 then � 2*t else � 1)
�	(f +�P 0�P (f(� 1))) = �t� f (k t)
�);
a(rewrite_tac[paths_def, path_plus_def, path_0_def] THEN REPEAT strip_tac);
a(asm_rewrite_tac[]);
a(cases_tac�x � 1/2� THEN asm_rewrite_tac[]);
pop_thm()
));


val path_plus_0_lemma2 = (* not saved *) snd ( "path_plus_0_lemma2", (
set_goal([], ��k�
	(�t�k t = if t � 1/2 then � 2*t else � 1)
�	k � (O�R, O�R) Continuous
�);
a(REPEAT strip_tac);
a(pure_once_rewrite_tac[conv_rule(ONCE_MAP_C eq_sym_conv) (�_elim�k��_axiom)]);
a(POP_ASM_T pure_rewrite_thm_tac);
a(ho_bc_thm_tac cond_continuous_�_thm);
a(rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY (SOLVED_T (�_continuity_tac[])));
a(asm_rewrite_tac[]);
pop_thm()
));


val path_plus_0_lemma3 = (* not saved *) snd ( "path_plus_0_lemma3", (
set_goal([], ��k�
	(�t�k t = if t � 1/2 then � 2*t else � 1)
�	k � ((O�R, {� 0; � 1},O�R) HomotopyClass) (�x�x)
�);
a(REPEAT strip_tac);
a(bc_thm_tac homotopy_class_�_thm);
a(strip_asm_tac open_�_topology_thm THEN asm_rewrite_tac[]);
a(�_tac�{x | k x = (�x� x) x}� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac homotopy_class_�_thm);
a(ALL_FC_T asm_rewrite_tac[id_continuous_thm, path_plus_0_lemma2]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[]);
pop_thm()
));


val path_plus_0_thm = save_thm ( "path_plus_0_thm", (
set_goal([], ��� f�
	� � Topology
�	f � Paths �
�	f +�P 0�P (f(� 1)) � ((O�R, {� 0; � 1}, �) HomotopyClass) f
�);
a(REPEAT strip_tac);
a(lemma_tac��k��t�k t = if t � 1/2 then � 2*t else � 1�
	THEN1 prove_�_tac);
a(strip_asm_tac open_�_topology_thm);
a(all_fc_tac[path_plus_0_lemma2, path_plus_0_lemma3]);
a(conv_tac (RIGHT_C (pure_once_rewrite_conv[prove_rule[]�f = �t�f ((�t�t)t)�])));
a(PC_T1 "predicates" (ALL_FC_T pure_rewrite_tac)[path_plus_0_lemma1]);
a(bc_thm_tac homotopy_class_comp_left_thm);
a(�_tac�O�R� THEN REPEAT strip_tac);
a(bc_tac [paths_continuous_thm] THEN REPEAT strip_tac);
pop_thm()
));


val path_0_plus_lemma1 = (* not saved *) snd ( "path_0_plus_lemma1", (
set_goal([], ��� f k�
	� � Topology
�	f � Paths �
�	(�t�k t = if t � 1/2 then � 0 else � 2*t + ~(� 1))
�	0�P (f(� 0)) +�P f = �t� f (k t)
�);
a(rewrite_tac[paths_def, path_plus_def, path_0_def] THEN REPEAT strip_tac);
a(asm_rewrite_tac[]);
a(cases_tac�x � 1/2� THEN  asm_rewrite_tac[]);
a(conv_tac (ONCE_MAP_C �_anf_conv) THEN  asm_rewrite_tac[]);
pop_thm()
));


val path_0_plus_lemma2 = (* not saved *) snd ( "path_0_plus_lemma2", (
set_goal([], ��k�
	(�t�k t = if t � 1/2 then � 0 else � 2*t + ~(� 1))
�	k � (O�R, O�R) Continuous
�);
a(REPEAT strip_tac);
a(pure_once_rewrite_tac[conv_rule(ONCE_MAP_C eq_sym_conv) (�_elim�k��_axiom)]);
a(POP_ASM_T pure_rewrite_thm_tac);
a(ho_bc_thm_tac cond_continuous_�_thm);
a(rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY (SOLVED_T (�_continuity_tac[])));
a(asm_rewrite_tac[]);
pop_thm()
));


val path_0_plus_lemma3 = (* not saved *) snd ( "path_0_plus_lemma3", (
set_goal([], ��k�
	(�t�k t = if t � 1/2 then � 0 else � 2*t + ~(� 1))
�	k � ((O�R, {� 0; � 1},O�R) HomotopyClass) (�x�x)
�);
a(REPEAT strip_tac);
a(bc_thm_tac homotopy_class_�_thm);
a(strip_asm_tac open_�_topology_thm THEN asm_rewrite_tac[]);
a(�_tac�{x | k x = (�x� x) x}� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac homotopy_class_�_thm);
a(ALL_FC_T asm_rewrite_tac[id_continuous_thm, path_0_plus_lemma2]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[]);
pop_thm()
));


val path_0_plus_thm = save_thm ( "path_0_plus_thm", (
set_goal([], ��� f�
	� � Topology
�	f � Paths �
�	0�P (f(� 0)) +�P f � ((O�R, {� 0; � 1}, �) HomotopyClass) f
�);
a(REPEAT strip_tac);
a(lemma_tac��k�	(�t�k t = if t � 1/2 then � 0 else � 2*t + ~(� 1))�
	THEN1 prove_�_tac);
a(strip_asm_tac open_�_topology_thm);
a(all_fc_tac[path_0_plus_lemma2, path_0_plus_lemma3]);
a(conv_tac (RIGHT_C (pure_once_rewrite_conv[prove_rule[]�f = �t�f ((�t�t)t)�])));
a(PC_T1 "predicates" (ALL_FC_T pure_rewrite_tac)[path_0_plus_lemma1]);
a(bc_thm_tac homotopy_class_comp_left_thm);
a(�_tac�O�R� THEN REPEAT strip_tac);
a(bc_tac [paths_continuous_thm] THEN REPEAT strip_tac);
pop_thm()
));


val path_plus_minus_lemma1 = (* not saved *) snd ( "path_plus_minus_lemma1", (
set_goal([], ��� f k�
	� � Topology
�	f � Paths �
�	(�t�k t = if t � 1/2 then � 2*t else � 2 + ~(� 2*t) )
�	f +�P ~�P f= �t� f (k t)
�);
a(rewrite_tac[paths_def, path_plus_def, path_minus_def] THEN REPEAT strip_tac);
a(asm_rewrite_tac[]);
a(cases_tac�x � 1/2� THEN  asm_rewrite_tac[]);
a(conv_tac (ONCE_MAP_C �_anf_conv) THEN REPEAT strip_tac);
pop_thm()
));


val path_plus_minus_lemma2 = (* not saved *) snd ( "path_plus_minus_lemma2", (
set_goal([], ��k�
	(�t�k t = if t � 1/2 then � 2*t else � 2 + ~(� 2*t) )
�	k � (O�R, O�R) Continuous
�);
a(REPEAT strip_tac);
a(pure_once_rewrite_tac[conv_rule(ONCE_MAP_C eq_sym_conv) (�_elim�k��_axiom)]);
a(POP_ASM_T pure_rewrite_thm_tac);
a(ho_bc_thm_tac cond_continuous_�_thm);
a(rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY (SOLVED_T (�_continuity_tac[])));
a(asm_rewrite_tac[]);
pop_thm()
));


val path_plus_minus_lemma3 = (* not saved *) snd ( "path_plus_minus_lemma3", (
set_goal([], ��k�
	(�t�k t = if t � 1/2 then � 2*t else � 2 + ~(� 2*t) )
�	k � ((O�R, {� 0; � 1},O�R) HomotopyClass) (�x�� 0)
�);
a(REPEAT strip_tac);
a(bc_thm_tac homotopy_class_�_thm);
a(strip_asm_tac open_�_topology_thm THEN asm_rewrite_tac[]);
a(�_tac�{x | k x = (�x� � 0) x}� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac homotopy_class_�_thm);
a(lemma_tac�� 0 � Space�T O�R� THEN1 rewrite_tac[space_t_�_thm]);
a(ALL_FC_T asm_rewrite_tac[const_continuous_thm, path_plus_minus_lemma2]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[]);
pop_thm()
));


val path_plus_minus_thm = save_thm ( "path_plus_minus_thm", (
set_goal([], ��� f�
	� � Topology
�	f � Paths �
�	f +�P ~�P f� ((O�R, {� 0; � 1}, �) HomotopyClass) (0�P (f(� 0)))
�);
a(REPEAT strip_tac);
a(lemma_tac��k� (�t�k t = if t � 1/2 then � 2*t else � 2 + ~(� 2*t) )�
	THEN1 prove_�_tac);
a(strip_asm_tac open_�_topology_thm);
a(all_fc_tac[path_plus_minus_lemma2, path_plus_minus_lemma3]);
a(rewrite_tac[path_0_def]);
a(pure_once_rewrite_tac[prove_rule[]�(�t�f(� 0)) =(�t�f((�t�� 0)t))�]);
a(PC_T1 "predicates" (ALL_FC_T pure_rewrite_tac)[path_plus_minus_lemma1]);
a(bc_thm_tac homotopy_class_comp_left_thm);
a(�_tac�O�R� THEN REPEAT strip_tac);
a(bc_tac [paths_continuous_thm] THEN REPEAT strip_tac);
pop_thm()
));


val path_minus_minus_thm = save_thm ( "path_minus_minus_thm", (
set_goal([], ��f�
	 ~�P (~�P f) = f
�);
a(rewrite_tac[path_minus_def] THEN conv_tac (ONCE_MAP_C �_anf_conv));
a(REPEAT strip_tac);
pop_thm()
));


val path_minus_plus_thm = save_thm ( "path_minus_plus_thm", (
set_goal([], ��� f�
	� � Topology
�	f � Paths �
�	~�P f +�P f� ((O�R, {� 0; � 1}, �) HomotopyClass) (0�P (f(� 1)))
�);
a(REPEAT strip_tac);
a(all_fc_tac[path_minus_path_thm]);
a(DROP_NTH_ASM_T 2 discard_tac);
a(ALL_FC_T (MAP_EVERY ante_tac) [path_plus_minus_thm]);
a(rewrite_tac[path_minus_minus_thm]);
a(rewrite_tac[path_0_def, path_minus_def]);
pop_thm()
));


val open_connected_path_connected_thm = save_thm ( "open_connected_path_connected_thm", (
set_goal([], ��� A�
	� � Topology
�	� � LocallyPathConnected
�	A � �
�	A � � Connected
�	A � � PathConnected
�);
a(rewrite_tac[path_connected_def, connected_def, locally_path_connected_def]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(lemma_tac�{z | � f� f � Paths � � (� t� f t � A) � f (� 0) = x � f (� 1) = z} � Ԯ);
(* *** Goal "1" *** *)
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]
	THEN REPEAT strip_tac);
a(lemma_tac�x' � A� THEN1 (all_var_elim_asm_tac1 THEN asm_rewrite_tac[]));
a(list_spec_nth_asm_tac 11 [�x'�, �A�]);
a(�_tac�B� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
a(list_spec_nth_asm_tac 2 [�x'�, �x''�]);
a(�_tac�f +�P f'� THEN REPEAT strip_tac THEN_TRY SOLVED_T (asm_rewrite_tac[path_plus_def]));
(* *** Goal "1.1" *** *)
a(bc_thm_tac path_plus_path_thm THEN asm_rewrite_tac[]);
(* *** Goal "1.2" *** *)
a(rewrite_tac[path_plus_def]);
a(cases_tac�t � 1/2� THEN asm_rewrite_tac[]);
a(LEMMA_T�f' (� 2 * (t + ~ (1 / 2))) � B� ante_tac THEN1 asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 9 ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac�{z | z � A � � � f� f � Paths � � (� t� f t � A) � f (� 0) = x � f (� 1) = z} � Ԯ);
(* *** Goal "2.1" *** *)
a(ALL_FC_T1 fc_�_canon once_rewrite_tac[open_open_neighbourhood_thm]
	THEN REPEAT strip_tac);
a(list_spec_nth_asm_tac 9 [�x'�, �A�]);
a(�_tac�B� THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "2.1.1" *** *)
a(LIST_DROP_NTH_ASM_T [1, 4] (MAP_EVERY ante_tac) THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.1.2" *** *)
a(swap_nth_asm_concl_tac 10 THEN REPEAT strip_tac);
a(list_spec_nth_asm_tac 6 [�x''�, �x'�]);
a(�_tac�f +�P f'� THEN REPEAT strip_tac THEN_TRY SOLVED_T (asm_rewrite_tac[path_plus_def]));
(* *** Goal "2.1.2.1" *** *)
a(bc_thm_tac path_plus_path_thm THEN asm_rewrite_tac[]);
(* *** Goal "2.1.2.2" *** *)
a(rewrite_tac[path_plus_def]);
a(cases_tac�t � 1/2� THEN asm_rewrite_tac[]);
a(LEMMA_T�f' (� 2 * (t + ~ (1 / 2))) � B� ante_tac THEN1 asm_rewrite_tac[]);
a(DROP_NTH_ASM_T 13 ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.2" *** *)
a(lemma_tac�
	A � {z | � f� f � Paths � � (� t� f t � A) � f (� 0) = x � f (� 1) = z}
	� {z | z � A � � � f� f � Paths � � (� t� f t � A) � f (� 0) = x � f (� 1) = z}�
	THEN1 PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "2.2.1" *** *)
a(spec_nth_asm_tac 4 �f�);
a(POP_ASM_T ante_tac THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2" *** *)
a(lemma_tac�
	A � {z | � f� f � Paths � � (� t� f t � A) � f (� 0) = x � f (� 1) = z}
	� {z | z � A � � � f� f � Paths � � (� t� f t � A) � f (� 0) = x � f (� 1) = z} = {}�
	THEN1 PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "2.2.2.1" *** *)
a(spec_nth_asm_tac 1 �f�);
a(POP_ASM_T ante_tac THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2.2" *** *)
a(DROP_NTH_ASM_T 7 (ante_tac o list_�_elim
	[�{z | � f� f � Paths � � (� t� f t � A) � f (� 0) = x � f (� 1) = z}�,
	�{z | z � A � � � f� f � Paths � � (� t� f t � A) � f (� 0) = x � f (� 1) = z}�]));
a(asm_rewrite_tac[]);
a(REPEAT_N 4 (POP_ASM_T discard_tac) THEN PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "2.2.2.2.1" *** *)
a(spec_nth_asm_tac 1 �y�);
a(�_tac �f� THEN asm_rewrite_tac[]);
(* *** Goal "2.2.2.2.2" *** *)
a(i_contr_tac THEN spec_nth_asm_tac 1 �x�);
a(swap_nth_asm_concl_tac 1 THEN REPEAT strip_tac);
a(�_tac��t:�� x� THEN asm_rewrite_tac[paths_def]);
a(bc_thm_tac const_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "2.2.2.2.2.1" *** *)
a(accept_tac open_�_topology_thm);
(* *** Goal "2.2.2.2.2.2" *** *)
a(LIST_DROP_NTH_ASM_T [3, 4] (MAP_EVERY ante_tac) THEN PC_T1 "sets_ext1" prove_tac[]);
pop_thm()
));


val open_interval_path_connected_thm = save_thm ( "open_interval_path_connected_thm", (
set_goal([], ��x y�OpenInterval x y � O�R PathConnected�);
a(rewrite_tac[path_connected_def, open_interval_def, paths_def, space_t_�_thm]
	THEN REPEAT strip_tac);
a(�_tac��t�if t � � 0 then x' else if t � � 1 then x' + (y' + ~x') * t else y'� THEN rewrite_tac[]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY SOLVED_T (�_continuity_tac[]));
(* *** Goal "1.1" *** *)
a(ho_bc_thm_tac cond_continuous_�_thm);
a(rewrite_tac[open_�_topology_thm]);
a(REPEAT strip_tac THEN_TRY SOLVED_T (�_continuity_tac[]));
a(asm_rewrite_tac[] THEN PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "1.2" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(cases_tac�x'' = 1.� THEN1 (asm_rewrite_tac[] THEN PC_T1 "�_lin_arith" asm_prove_tac[]));
a(LEMMA_T ��x'' � 0. � �x'' � 1.� rewrite_thm_tac THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "4" *** *)
a(cases_tac �t � 0.� THEN cases_tac �t � 1.� THEN asm_rewrite_tac[]);
a(cases_tac�x' � y'�);
(* *** Goal "4.1" *** *)
a(bc_thm_tac �_less_�_trans_thm THEN �_tac�x'� THEN REPEAT strip_tac);
a(bc_thm_tac �_0_�_0_�_times_thm THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "4.2" *** *)
a(bc_thm_tac �_less_�_trans_thm THEN �_tac�y'� THEN REPEAT strip_tac);
a(bc_thm_tac (pc_rule1"�_lin_arith" prove_rule[]
	�� 0 � (x' + ~y') *(� 1 + ~t) � y' � x' + (y' + ~ x') * t�));
a(bc_thm_tac �_0_�_0_�_times_thm THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "5" *** *)
a(cases_tac �t � 0.� THEN cases_tac �t � 1.� THEN asm_rewrite_tac[]);
a(cases_tac�x' � y'�);
(* *** Goal "5.1" *** *)
a(bc_thm_tac �_�_less_trans_thm THEN �_tac�y'� THEN REPEAT strip_tac);
a(bc_thm_tac (pc_rule1"�_lin_arith" prove_rule[]
	�� 0 � (y' + ~x') *(� 1 + ~t) � x' + (y' + ~ x') * t � y'�));
a(bc_thm_tac �_0_�_0_�_times_thm THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "5.2" *** *)
a(bc_thm_tac �_�_less_trans_thm THEN �_tac�x'� THEN REPEAT strip_tac);
a(bc_thm_tac (pc_rule1"�_lin_arith" prove_rule[]
	�� 0 � (x' + ~y') *t � (y' + ~ x') * t � � 0�));
a(bc_thm_tac �_0_�_0_�_times_thm THEN PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "6" *** *)
a(PC_T1 "�_lin_arith" asm_prove_tac[]);
pop_thm()
));


val �_locally_path_connected_thm = save_thm ( "�_locally_path_connected_thm", (
set_goal([], �O�R � LocallyPathConnected�);
a(rewrite_tac[locally_path_connected_def] THEN REPEAT strip_tac);
a(POP_ASM_T  (fn th => all_fc_tac[rewrite_rule[open_�_def]th]));
a(�_tac�OpenInterval x' y� THEN
	asm_rewrite_tac[open_interval_open_thm, open_interval_path_connected_thm]);
pop_thm()
));


val product_locally_path_connected_thm = save_thm ( "product_locally_path_connected_thm", (
set_goal([], ��� � f a b c�
	� � Topology
�	� � Topology
�	� � LocallyPathConnected
�	� � LocallyPathConnected
�	(� ��T �) � LocallyPathConnected
�);
a(rewrite_tac[locally_path_connected_def] THEN REPEAT strip_tac);
a(POP_ASM_T
	(ante_tac o list_�_elim[�Fst x�, �Snd x�] o rewrite_rule[product_topology_def]));
a(asm_rewrite_tac[] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [8, 7] all_fc_tac);
a(�_tac�B'' � B'� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(rewrite_tac[product_topology_def] THEN REPEAT strip_tac);
a(POP_ASM_T (strip_asm_tac o rewrite_rule[�_def]));
a(�_tac�B''� THEN �_tac�B'� THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[�_def]);
(* *** Goal "3" *** *)
a(LIST_DROP_NTH_ASM_T [2, 6, 9] (MAP_EVERY ante_tac));
a(DROP_ASMS_T discard_tac);
a(MERGE_PCS_T1 ["'bin_rel", "sets_ext1"] REPEAT strip_tac);
a(DROP_NTH_ASM_T 5 bc_thm_tac THEN REPEAT strip_tac);
a(MERGE_PCS_T1 ["'bin_rel", "sets_ext1"] REPEAT strip_tac THEN all_asm_fc_tac[]);
(* *** Goal "4" *** *)
a(bc_thm_tac product_path_connected_thm THEN REPEAT strip_tac);
pop_thm()
));



val covering_projection_fibration_lemma1 = (* not saved *) snd ( "covering_projection_fibration_lemma1", (
set_goal([], ���; �; �;
	p : 'b � 'c;
	f : 'a � 'b;
	h : 'a � � � 'c;
	N : 'a SET;
	S : 'b SET;
	a b : �;
	C : 'c SET;
	U : 'b SET SET �
	� � Topology
�	� � Topology
�	� � Topology
�	h � ((N � ClosedInterval a b) �T � ��T O�R, �) Continuous
�	N � �
�	(�x� x � N � f x � S)
�	(�x� x � N � h(x, a) = p(f x))
�	S � U
�	a < b
�	(�x t� x � N � t � ClosedInterval a b � h (x, t) � C)
�	C � �
�	U � �
�	(� A� A � U � p � (A �T �, C �T �) Homeomorphism)
�	�L : 'a � � � 'b�
	L � ((N � ClosedInterval a b) �T (� ��T O�R), �) Continuous
�	(�x�	x � N
	�	L(x, a) = f x)
�	(�x s�	x � N
	�	s � ClosedInterval a b
	�	L(x, s) � S)
�	(�x s�	x � N
	�	s � ClosedInterval a b
	�	p(L(x, s)) = h(x, s))
�);
a(REPEAT strip_tac);
a(LIST_GET_NTH_ASM_T[1] all_fc_tac);
a(POP_ASM_T (ante_tac o rewrite_rule[homeomorphism_def]));
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]
	��a u s� a � u � u � s � a � s�]); 
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm2]
	THEN REPEAT strip_tac);
a(�_tac��xt�g(h xt)� THEN rewrite_tac[]);
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac comp_continuous_thm);
a(strip_asm_tac open_�_topology_thm);
a(�_tac�C �T Ԯ THEN
	ALL_FC_T asm_rewrite_tac[
subspace_topology_thm]
	THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(all_fc_tac[open_�_space_t_thm]);
a(lemma_tac�(N � ClosedInterval a b) � Space�T (� ��T O�R)�
	THEN1 (ALL_FC_T rewrite_tac[product_topology_space_t_thm]
		THEN rewrite_tac[space_t_�_thm]
		THEN POP_ASM_T ante_tac
		THEN PC_T1 "sets_ext1" prove_tac[�_def]));
a(bc_thm_tac subspace_range_continuous_bc_thm
	THEN asm_rewrite_tac[]
	THEN strip_tac
	THEN1 (bc_tac [product_topology_thm, subspace_topology_thm]
		THEN REPEAT strip_tac));
a(lemma_tac�� ��T O�R � Topology� THEN1 basic_topology_tac[]);
a(�_tac THEN ALL_FC_T rewrite_tac[subspace_topology_space_t_thm1,
	product_topology_space_t_thm]);
a(rewrite_tac[�_def]);
a(pair_tac�x = (v, s)� THEN rewrite_tac[]);
a(REPEAT strip_tac THEN all_asm_fc_tac[]);
(* *** Goal "1.2" *** *)
a(bc_thm_tac subspace_range_continuous_thm);
a(�_tac�S� THEN REPEAT strip_tac);
a(bc_thm_tac subspace_topology_thm THEN REPEAT strip_tac);
(* *** Goal "1.3" *** *)
a(bc_tac[product_topology_thm, subspace_topology_thm] THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(LIST_DROP_NTH_ASM_T [14] all_fc_tac);
a(LIST_DROP_NTH_ASM_T [4, 14] (ALL_FC_T rewrite_tac));
(* *** Goal "3" *** *)
a(LIST_DROP_NTH_ASM_T [11] all_fc_tac);
a(lemma_tac�h(x, s) � Space�T (C �T �)�
	THEN1 ALL_FC_T asm_rewrite_tac[subspace_topology_space_t_thm2]);
a(ALL_FC_T (MAP_EVERY ante_tac) [continuous_�_space_t_thm]);
a(ALL_FC_T asm_rewrite_tac[subspace_topology_space_t_thm2]);
(* *** Goal "4" *** *)
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN all_asm_fc_tac[]);
pop_thm()
));


val covering_projection_fibration_lemma2 = (* not saved *) snd ( "covering_projection_fibration_lemma2", (
set_goal([], ���; �; �;
	p : 'b � 'c;
	f : 'a � 'b;
	h : 'a � � � 'c;
	N : 'a SET;
	a b : �;
	C : 'c SET;
	U : 'b SET SET �
	� � Topology
�	� � Topology
�	� � Topology
�	f � (N �T �, �) Continuous
�	h � ((N � ClosedInterval a b) �T � ��T O�R, �) Continuous
�	N � �
�	a < b
�	(�x� x � N � h(x, a) = p(f x))
�	(�x s� x � N � s � ClosedInterval a b � h (x, s) � C)
�	C � �
�	U � �
�	(�x� x � Space�T � � p x � C � �A� x � A � A � U)
�	(� A B� A � U � B � U � � A � B = {} � A = B)
�	(� A� A � U � p � (A �T �, C �T �) Homeomorphism)
�	�L : 'a � � � 'b�
	L � ((N � ClosedInterval a b) �T (� ��T O�R), �) Continuous
�	(�x�	x � N
	�	L(x, a) = f x)
�	(�x s�	x � N
	�	s � ClosedInterval a b
	�	p(L(x, s)) = h(x, s))
�);
a(REPEAT strip_tac);
a(lemma_tac��W��v: 'a; r : ��
	W (v, r) = {w | w � N � �A� f v � A � f w � A � A � U}�
	THEN1 prove_�_tac);
a(lemma_tac��V��w r�
	V (w, r) = (W (w, r) � ClosedInterval a b)�
	THEN1 prove_�_tac);
a(lemma_tac��S��w : 'a; r : ��
	S (w, r) = {y | �A� y � A � f w � A � A � U}�
	THEN1 prove_�_tac);
a(lemma_tac��G��v r� v � N � r � ClosedInterval a b �
	G (v, r) � (V (v, r) �T (� ��T O�R), �) Continuous
�	(�w�	w � W (v, r)
	�	G(v, r)(w, a) = f w)
�	(�w s�	w � W (v, r)
	�	s � ClosedInterval a b
	�	G (v, r) (w, s) � S (v, r))
�	(�w s�	w � W (v, r)
	�	s � ClosedInterval a b
	�	p(G (v, r) (w, s)) = h(w, s))�);
(* *** Goal "1" *** *)
a(lemma_tac��H��vr� Fst vr � N � Snd vr � ClosedInterval a b �
	H vr � (V vr �T (� ��T O�R), �) Continuous
�	(�w�	w � W vr
	�	H vr (w, a) = f w)
�	(�w s�	w � W vr
	�	s � ClosedInterval a b
	�	H vr (w, s) � S vr)
�	(�w s�	w � W vr
	�	s � ClosedInterval a b
	�	p(H vr (w, s)) = h(w, s))�
	THEN1 (prove_�_tac THEN strip_tac));
(* *** Goal "1.1" *** *)
a(pair_tac�vr' = (v, r)�);
a(GET_NTH_ASM_T 2 rewrite_thm_tac);
a(cases_tac��v � N� THEN1 asm_rewrite_tac[]);
a(cases_tac��r � ClosedInterval a b� THEN1 asm_rewrite_tac[]);
a(LIST_GET_NTH_ASM_T [1, 2] rewrite_tac);
a(LEMMA_T�h(v, a) � C� ante_tac
	THEN1 (DROP_NTH_ASM_T 11 bc_thm_tac THEN asm_rewrite_tac[closed_interval_def, �_�_def]));
a(LIST_GET_NTH_ASM_T [12] (ALL_FC_T rewrite_tac) THEN strip_tac);
a(lemma_tac�f v � Space�T Ӯ
	THEN1 (bc_thm_tac continuous_�_space_t_thm
		THEN �_tac�N �T Ү
		THEN ALL_FC_T asm_rewrite_tac[�_space_t_thm, subspace_topology_space_t_thm2]));
a(LIST_GET_NTH_ASM_T [10] all_fc_tac);
a(DROP_NTH_ASM_T 3 discard_tac);
a(bc_thm_tac covering_projection_fibration_lemma1);
a(MAP_EVERY �_tac[�C�, �U�, �Ԯ]);
a(LIST_DROP_NTH_ASM_T [6, 7, 8] asm_rewrite_tac THEN REPEAT strip_tac);
(* *** Goal "1.1.1" *** *)
a(LEMMA_T �
	({w|w � N � (� A� f v � A � f w � A � A � U)} � ClosedInterval a b)
		�T � ��T O�R =
	({w|w � N � (� A� f v � A � f w � A � A � U)} � ClosedInterval a b)
		�T (N � ClosedInterval a b) �T � ��T O�R�
	rewrite_thm_tac
	THEN1 (conv_tac eq_sym_conv THEN bc_thm_tac �_subspace_topology_thm
		THEN1 PC_T1 "sets_ext1" prove_tac[�_def]));
a(bc_thm_tac subspace_domain_continuous_thm THEN REPEAT strip_tac);
a(bc_tac[product_topology_thm, subspace_topology_thm] THEN REPEAT strip_tac);
a(rewrite_tac[open_�_topology_thm]);
(* *** Goal "1.1.2" *** *)
a(DROP_NTH_ASM_T 10 discard_tac);
a(LIST_GET_NTH_ASM_T [9] (PC_T1 "sets_ext1" all_fc_tac));
a(all_fc_tac [continuous_open_thm]);
a(POP_ASM_T ante_tac THEN ALL_FC_T rewrite_tac[subspace_topology_space_t_thm2]);
a(rewrite_tac[subspace_topology_def] THEN strip_tac);
a(lemma_tac�B � N � Ү THEN1 all_fc_tac[�_open_thm]); 
a(LEMMA_T ��z� (� A� f v � A � z � A � A � U) � z � A� asm_rewrite_thm_tac);
a(REPEAT strip_tac);
(* *** Goal "1.1.2.1" *** *)
a(LEMMA_T �A = A'� asm_rewrite_thm_tac);
a(DROP_NTH_ASM_T 14 bc_thm_tac THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [3, 9] (MAP_EVERY ante_tac));
a(PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "1.1.2.2" *** *)
a(�_tac�A� THEN REPEAT strip_tac);
(* *** Goal "1.1.3" *** *)
a(�_tac�A'� THEN REPEAT strip_tac);
(* *** Goal "1.1.4" *** *)
a(DROP_NTH_ASM_T 16 bc_thm_tac THEN strip_tac);
(* *** Goal "1.1.5" *** *)
a(LEMMA_T�{y|� A� y � A � f v � A � A � U} = A� asm_rewrite_thm_tac);
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "1.1.5.1" *** *)
a(LEMMA_T�A = A'� asm_rewrite_thm_tac);
a(DROP_NTH_ASM_T 10 bc_thm_tac THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2, 5] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "1.1.5.2" *** *)
a(�_tac�A� THEN REPEAT strip_tac);
(* *** Goal "1.1.6" *** *)
a(all_asm_fc_tac[]);
(* *** Goal "1.2" *** *)
a(�_tac�H� THEN REPEAT �_tac THEN �_tac);
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(�_tac��(v, r)� G (v, r) (v, r)� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(bc_thm_tac compatible_family_continuous_thm1);
a(�_tac�V� THEN POP_ASM_T ante_tac
	THEN LIST_DROP_NTH_ASM_T [1, 2, 3] rewrite_tac);
a(rewrite_tac[�_def] THEN REPEAT strip_tac);
(* *** Goal "2.1.1" *** *)
a(bc_thm_tac product_topology_thm THEN asm_rewrite_tac[open_�_topology_thm]);
(* *** Goal "2.1.2" *** *)
a(PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.1.3" *** *)
a(rewrite_tac[taut_rule��p q�p � p � q � p � q�]);
a(GET_NTH_ASM_T 6 bc_thm_tac);
a(LEMMA_T�f v � Space�T Ӯ rewrite_thm_tac
	THEN1 (bc_thm_tac continuous_�_space_t_thm
		THEN �_tac�N �T Ү
		THEN ALL_FC_T asm_rewrite_tac[�_space_t_thm, subspace_topology_space_t_thm2]));
a(LEMMA_T�h(v, a) � C� ante_tac
	THEN1 (DROP_NTH_ASM_T 9 bc_thm_tac THEN asm_rewrite_tac[closed_interval_def, �_�_def]));
a(LIST_DROP_NTH_ASM_T [10] (ALL_FC_T rewrite_tac));
(* *** Goal "2.1.4" *** *)
a(LEMMA_T�h(v, a) � C� ante_tac
	THEN1 (DROP_NTH_ASM_T 9 bc_thm_tac THEN asm_rewrite_tac[closed_interval_def, �_�_def]));
a(LIST_GET_NTH_ASM_T [10] (ALL_FC_T rewrite_tac) THEN strip_tac);
a(lemma_tac�f v � Space�T Ӯ
	THEN1 (bc_thm_tac continuous_�_space_t_thm
		THEN �_tac�N �T Ү
		THEN ALL_FC_T asm_rewrite_tac[�_space_t_thm, subspace_topology_space_t_thm2]));
a(LIST_GET_NTH_ASM_T [8] all_fc_tac);
a(rewrite_tac[subspace_topology_def]);
a(�_tac�{v|v � N � f v � A} � Universe� THEN rewrite_tac[�_def] THEN REPEAT strip_tac);
(* *** Goal "2.1.4.1" *** *)
a(LIST_GET_NTH_ASM_T [11] (PC_T1 "sets_ext1" all_fc_tac));
a(all_fc_tac [continuous_open_thm]);
a(POP_ASM_T discard_tac THEN POP_ASM_T ante_tac);
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm2]);
a(rewrite_tac[subspace_topology_def] THEN strip_tac);
a(POP_ASM_T (strip_asm_tac o eq_sym_rule));
a(LEMMA_T�B � N � Ү ante_tac THEN1 all_fc_tac[�_open_thm]);
a(asm_rewrite_tac[product_topology_def] THEN REPEAT strip_tac);
a(�_tac�{x|x � N � f x � A}� THEN �_tac�Universe�);
a(asm_rewrite_tac[empty_universe_open_closed_thm]);
a(PC_T1 "sets_ext1" prove_tac[�_def]);
(* *** Goal "2.1.4.2" *** *)
a(PC_T1 "sets_ext1" REPEAT strip_tac);
(* *** Goal "2.1.4.2.1" *** *)
a(lemma_tac�f v � A � f v � A' � �A' � A = {}�
	THEN1 PC_T1 "sets_ext1" prove_tac[]);
a(LIST_DROP_NTH_ASM_T [15] all_fc_tac THEN all_var_elim_asm_tac);
(* *** Goal "2.1.4.2.2" *** *)
a(�_tac�A� THEN REPEAT strip_tac);
(* *** Goal "2.1.5" *** *)
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
(* *** Goal "2.1.6" *** *)
a(GET_NTH_ASM_T 8 (strip_asm_tac o list_�_elim[�v�, �r�]));
a(DROP_NTH_ASM_T 12 (strip_asm_tac o list_�_elim[�w�, �s�]));
a(LIST_DROP_NTH_ASM_T [3, 4, 7, 8] discard_tac);
a(lemma_tac�p(G(v, r)(w, s)) = h(w, s)�
	THEN1 (DROP_NTH_ASM_T 3 bc_thm_tac THEN REPEAT strip_tac
		THEN �_tac�A� THEN REPEAT strip_tac));
a(lemma_tac�p(G(w, s)(w, s)) = h(w, s)�
	THEN1 (DROP_NTH_ASM_T 2 bc_thm_tac THEN REPEAT strip_tac
		THEN �_tac�A� THEN REPEAT strip_tac));
a(LIST_DROP_NTH_ASM_T [3, 5] discard_tac);
a(DROP_NTH_ASM_T 4 (strip_asm_tac o list_�_elim[�w�, �s�])
	THEN1 all_asm_fc_tac[]);
a(DROP_NTH_ASM_T 6 (strip_asm_tac o list_�_elim[�w�, �s�])
	THEN1 all_asm_fc_tac[]);
a(lemma_tac�A' = A�);
(* *** Goal "2.1.6.1" *** *)
a(DROP_NTH_ASM_T 17 bc_thm_tac THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [5, 12] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.1.6.2" *** *)
a(all_var_elim_asm_tac);
a(lemma_tac�A'' = A�);
(* *** Goal "2.1.6.2.1" *** *)
a(DROP_NTH_ASM_T 15 bc_thm_tac THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2, 9] (MAP_EVERY ante_tac)
	THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.1.6.2.2" *** *)
a(all_var_elim_asm_tac);
a(LIST_DROP_NTH_ASM_T [12] all_fc_tac);
a(POP_ASM_T (ante_tac o rewrite_rule[homeomorphism_def]));
a(all_fc_tac[pc_rule1 "sets_ext1" prove_rule[]
	��a u s� a � u � u � s � a � s�]); 
a(ALL_FC_T rewrite_tac[subspace_topology_space_t_thm2]
	THEN REPEAT strip_tac);
a(LEMMA_T �g(p(G(w, s)(w, s))) = g(p(G(v, r)(w, s)))� ante_tac
	THEN1 asm_rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T [2] (ALL_FC_T rewrite_tac));
(* *** Goal "2.2" *** *)
a(DROP_NTH_ASM_T 2 (ante_tac o list_�_elim[�x�, �a�]));
a(asm_rewrite_tac[closed_interval_def, �_�_def] THEN strip_tac);
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN REPEAT strip_tac);
a(rewrite_tac[taut_rule��p q�p � p � q � p � q�]);
a(GET_NTH_ASM_T 10 bc_thm_tac);
a(LEMMA_T�f x � Space�T Ӯ rewrite_thm_tac
	THEN1 (bc_thm_tac continuous_�_space_t_thm
		THEN �_tac�N �T Ү
		THEN ALL_FC_T asm_rewrite_tac[�_space_t_thm, subspace_topology_space_t_thm2]));
a(LEMMA_T �p(f x) = h(x, a)� rewrite_thm_tac
	THEN1 LIST_DROP_NTH_ASM_T [14] (ALL_FC_T rewrite_tac));
a(DROP_NTH_ASM_T 13 bc_thm_tac);
a(asm_rewrite_tac[closed_interval_def, �_�_def]);
(* *** Goal "2.3" *** *)
a(DROP_NTH_ASM_T 3 (ante_tac o list_�_elim[�x�, �s�]));
a(LIST_DROP_NTH_ASM_T[3, 4, 5] rewrite_tac
	THEN REPEAT strip_tac);
a(POP_ASM_T bc_thm_tac THEN asm_rewrite_tac[]);
a(rewrite_tac[taut_rule��p q�p � p � q � p � q�]);
a(LEMMA_T�h(x, a) � C� ante_tac
	THEN1 (DROP_NTH_ASM_T 11 bc_thm_tac THEN asm_rewrite_tac[closed_interval_def, �_�_def]));
a(LIST_DROP_NTH_ASM_T [12] (ALL_FC_T rewrite_tac)
	THEN strip_tac);
a(lemma_tac�f x � Space�T Ӯ
	THEN1 (bc_thm_tac continuous_�_space_t_thm
		THEN �_tac�N �T Ү
		THEN ALL_FC_T asm_rewrite_tac[�_space_t_thm, subspace_topology_space_t_thm2]));
a(DROP_NTH_ASM_T 10 bc_thm_tac THEN REPEAT strip_tac);
pop_thm()
));


val covering_projection_fibration_lemma3 = (* not saved *) snd ( "covering_projection_fibration_lemma3", (
set_goal([], ���; �; �;
	p : 'b � 'c;
	f : 'a � 'b;
	h : 'a � � � 'c;
	N : 'a SET;
	t : � � �;
	n : � �
	� � Topology
�	� � Topology
�	� � Topology
�	f � (N �T �, �) Continuous
�	h � ((N � ClosedInterval 0. 1.) �T � ��T O�R, �) Continuous
�	N � �
�	(�x� x � N � h(x, 0.) = p(f x))
�	t 0 = 0. � t n = 1.
�	(�i j� i < j � t i < t j)
�	(�i� i < n � �C�
			(�x s� x � N � s � ClosedInterval (t i) (t(i+1)) � h(x, s) � C)
		�	C � �
		�	�U�
			U � �
		�	(�x� x � Space�T � � p x � C � �A� x � A � A � U)
		�	(� A B� A � U � B � U � � A � B = {} � A = B)
		�	(� A� A � U � p � (A �T �, C �T �) Homeomorphism))
�	�L : 'a � � � 'b�
	L � ((N � ClosedInterval 0. 1.) �T (� ��T O�R), �) Continuous
�	(�x�	x � N
	�	L(x, 0.) = f x)
�	(�x s�	x � N
	�	s � ClosedInterval 0. 1.
	�	p(L(x, s)) = h(x, s))
�);
a(REPEAT strip_tac);
a(lemma_tac��k�k < n �
	�L : 'a � � � 'b�
	L � ((N � ClosedInterval 0. (t(k+1))) �T (� ��T O�R), �) Continuous
�	(�x�	x � N
	�	L(x, 0.) = f x)
�	(�x s�	x � N
	�	s � ClosedInterval 0. (t(k+1))
	�	p(L(x, s)) = h(x, s))�);
a(strip_tac THEN induction_tac�k:� THEN REPEAT strip_tac
	THEN_TRY PC_T1 "lin_arith" asm_prove_tac[]
	THEN rewrite_tac[plus_assoc_thm]);
(* *** Goal "1.1" *** *)
a(bc_thm_tac covering_projection_fibration_lemma2);
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac);
a(GET_NTH_ASM_T 8 (strip_asm_tac o list_�_elim [�0�, �1�]));
a(LIST_DROP_NTH_ASM_T [1, 7] (MAP_EVERY ante_tac)
	THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
a(MAP_EVERY �_tac[�U�, �C�, �Ԯ] THEN asm_rewrite_tac[]);
a(cases_tac�n = 1� THEN1 (all_var_elim_asm_tac1 THEN asm_rewrite_tac[]));
a(lemma_tac�1 < n� THEN1 PC_T1 "lin_arith" asm_prove_tac[]);
a(GET_NTH_ASM_T 11 (strip_asm_tac o list_�_elim [�1�, �n�]));
a(POP_ASM_T ante_tac THEN asm_rewrite_tac[] THEN strip_tac);
a(LEMMA_T �
	(N � ClosedInterval 0. (t 1)) �T � ��T O�R =
	(N � ClosedInterval 0. (t 1))
		�T (N � ClosedInterval 0. 1.) �T � ��T O�R�
	rewrite_thm_tac
	THEN1 (conv_tac eq_sym_conv THEN bc_thm_tac �_subspace_topology_thm
		THEN PC_T1 "sets_ext1" asm_rewrite_tac[closed_interval_def, �_def]
		THEN REPEAT strip_tac
		THEN PC_T1 "�_lin_arith" asm_prove_tac[]));
a(bc_thm_tac subspace_domain_continuous_thm THEN REPEAT strip_tac);
a(bc_tac[subspace_topology_thm, product_topology_thm] THEN REPEAT strip_tac);
a(rewrite_tac[open_�_topology_thm]);
(* *** Goal "1.2" *** *)
a(lemma_tac ��M�
	M � ((N � ClosedInterval (t(k+1)) (t(k+2))) �T � ��T O�R, �) Continuous 
�	(� x� x � N � M(x, t(k+1)) = (�x� L(x, t(k+1))) x)
�	(� x s� x � N � s � ClosedInterval (t(k+1)) (t(k+2))
	�	p (M(x, s)) = h (x, s))�);
(* *** Goal "1.2.1" *** *)
a(bc_thm_tac covering_projection_fibration_lemma2);
a(DROP_NTH_ASM_T 3 discard_tac);
a(LIST_DROP_NTH_ASM_T [4] all_fc_tac);
a(GET_NTH_ASM_T 10 (ante_tac o list_�_elim [�k+1�, �(k+1)+1�])
	THEN rewrite_tac[]);
a(LIST_DROP_NTH_ASM_T [6] (MAP_EVERY ante_tac)
	THEN asm_rewrite_tac[plus_assoc_thm] THEN REPEAT strip_tac);
a(MAP_EVERY �_tac[�U�, �C�, �Ԯ] THEN asm_rewrite_tac[]
	THEN REPEAT strip_tac);
(* *** Goal "1.2.1.1" *** *)
a(lemma_tac�(N � ClosedInterval 0. (t (k + 1))) �T � ��T O�R � Topology�
	THEN1 basic_topology_tac[open_�_topology_thm]);
a(lemma_tac�N �T � � Topology�
	THEN1 basic_topology_tac[]);
a(�_continuity_tac[subspace_range_continuous_bc_thm]);
(* *** Goal "1.2.1.1.1" *** *)
a(strip_asm_tac open_�_topology_thm);
a(ALL_FC_T rewrite_tac[product_topology_space_t_thm]);
a(PC_T1 "sets_ext1" rewrite_tac[space_t_�_thm, �_def]);
a(LEMMA_T �N � Space�T Ү ante_tac THEN1 all_fc_tac [open_�_space_t_thm]);
a(PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "1.2.1.1.2" *** *)
a(rewrite_tac[comb_i_def, comb_k_def, �_def]);
a(POP_ASM_T ante_tac THEN ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]
	THEN REPEAT strip_tac);
a(rewrite_tac[closed_interval_def]);
a(GET_NTH_ASM_T 15 (ante_tac o list_�_elim [�0�, �k+1�])
	THEN rewrite_tac[]);
a(asm_rewrite_tac[] THEN PC_T1 "�_lin_arith" prove_tac[]);
(* *** Goal "1.2.1.1.3" *** *)
a(bc_thm_tac subspace_domain_continuous_thm THEN REPEAT strip_tac);
a(ALL_FC_T rewrite_tac[i_continuous_thm]);
(* *** Goal "1.2.1.2" *** *)
a(LEMMA_T �
	(N � ClosedInterval (t (k + 1)) (t (k + 2))) �T � ��T O�R =
	(N � ClosedInterval (t (k + 1)) (t (k + 2)))
		�T (N � ClosedInterval 0. 1.) �T � ��T O�R�
	rewrite_thm_tac);
(* *** Goal "1.2.1.2.1" *** *)
a(conv_tac eq_sym_conv THEN bc_thm_tac �_subspace_topology_thm);
a(GET_NTH_ASM_T 11 (ante_tac o list_�_elim [�0�, �k+1�])
	THEN rewrite_tac[]);
a(PC_T1 "sets_ext1" asm_rewrite_tac[closed_interval_def, �_def]
	THEN REPEAT strip_tac
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(cases_tac�(k+2) = n�
	THEN1 (all_var_elim_asm_tac1
		THEN PC_T1 "�_lin_arith" asm_prove_tac[]));
a(lemma_tac�k+2 < n� THEN1 PC_T1 "lin_arith" asm_prove_tac[]);
a(DROP_NTH_ASM_T 17 (ante_tac o list_�_elim [�k+2�, �n�])
	THEN asm_rewrite_tac[]
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(bc_thm_tac subspace_domain_continuous_thm THEN REPEAT strip_tac);
a(bc_tac[subspace_topology_thm, product_topology_thm]
	THEN asm_rewrite_tac[open_�_topology_thm]);
(* *** Goal "1.2.1.3" *** *)
a(conv_tac eq_sym_conv THEN DROP_NTH_ASM_T 10 bc_thm_tac);
a(asm_rewrite_tac[closed_interval_def]);
a(DROP_NTH_ASM_T 11 (ante_tac o list_�_elim [�0�, �k+1�])
	THEN asm_rewrite_tac[]
	THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
(* *** Goal "1.2.2" *** *)
a(lemma_tac��x� x � N � L(x, t(k+1)) = M(x, t(k+1))�
	THEN1 (REPEAT strip_tac THEN ALL_ASM_FC_T rewrite_tac[]));
a(lemma_tac�0. � t(k+1)�
	THEN1(DROP_NTH_ASM_T 10 (ante_tac o list_�_elim [�0�, �k+1�])
		THEN asm_rewrite_tac[]
		THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]));
a(lemma_tac�t(k+1) � t(k+2)�
	THEN1(DROP_NTH_ASM_T 11 (ante_tac o list_�_elim [�k+1�, �(k+1)+1�])
		THEN rewrite_tac[] THEN rewrite_tac[plus_assoc_thm]
		THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]));
a(all_fc_tac[open_�_space_t_thm]);
a(all_fc_tac[�_interval_glueing_thm]);
a(�_tac�h'� THEN rename_tac[(�h'�, "K")] THEN REPEAT strip_tac);
(* *** Goal "1.2.2.1" *** *)
a(LIST_DROP_NTH_ASM_T [14] all_fc_tac);
a(POP_ASM_T (rewrite_thm_tac o eq_sym_rule));
a(DROP_NTH_ASM_T 3 bc_thm_tac);
a(asm_rewrite_tac[closed_interval_def]);
(* *** Goal "1.2.2.2" *** *)
a(LIST_DROP_NTH_ASM_T [1, 3, 4, 10, 14] (MAP_EVERY ante_tac));
a(rewrite_tac[closed_interval_def] THEN REPEAT strip_tac);
a(strip_asm_tac (list_�_elim[�s�, �t(k+1)�] �_�_cases_thm)
	THEN ALL_ASM_FC_T rewrite_tac[]);
(* *** Goal "2" *** *)
a(lemma_tac��n = 0�
	THEN1 (contr_tac THEN all_var_elim_asm_tac1
			THEN PC_T1 "�_lin_arith" asm_prove_tac[]));
a(strip_asm_tac (�_elim �n� �_cases_thm));
a(DROP_NTH_ASM_T 2 discard_tac THEN all_var_elim_asm_tac1);
a(POP_ASM_T (ante_tac o �_elim�i�));
a(asm_rewrite_tac[]);
pop_thm()
));


val covering_projection_fibration_lemma4 = (* not saved *) snd ( "covering_projection_fibration_lemma4", (
set_goal([], ���; �; �;
	p : 'b � 'c;
	f : 'a � 'b;
	h : 'a � � � 'c;
	y : 'a �
	� � Topology
�	� � Topology
�	� � Topology
�	p � (�, �) CoveringProjection
�	f � (�, �) Continuous
�	h � (� ��T O�R, �) Continuous
�	y � Space�T �
�	�n t N�
		y � N
	�	N � �
	�	t 0 = 0.
	�	t n = 1.
	�	(�i j� i < j � t i < t j)
	�	�i�	i < n �
		�C�	(� x s� x � N � s � ClosedInterval (t i) (t (i + 1)) � h (x, s) � C)
		�	C � �
		�	�U�	U � �
			�	(� x� x � Space�T � � p x � C � (� A� x � A � A � U))
			�	(� A B� A � U � B � U � � A � B = {} � A = B)
			�	(� A� A � U � p � (A �T �, C �T �) Homeomorphism)
�);
a(REPEAT strip_tac);
a(lemma_tac��U�
U = {A | �C� C � � � A = {vr | vr � Space�T (� ��T O�R) � h vr � C} �
	�U�	U � �
	�	(� x� x � Space�T � � p x � C � (� A� x � A � A � U))
	�	(� A B� A � U � B � U � � A � B = {} � A = B)
	�	(� A� A � U � p � (A �T �, C �T �) Homeomorphism)}�
	THEN1 prove_�_tac);
a(lemma_tac��n t N� t 0 = 0. � t n = 1. � (� i j� i < j � t i < t j)
	�	y � N
	�	N � �
	�	�i� i < n � �B� B � U � (N � ClosedInterval (t i) (t (i+1))) � B�);
(* *** Goal "1" *** *)
a(bc_thm_tac product_interval_cover_thm);
a(all_var_elim_asm_tac1 THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(PC_T "sets_ext1" strip_tac THEN REPEAT strip_tac THEN all_var_elim_asm_tac1);
a(all_fc_tac[continuous_open_thm]);
(* *** Goal "1.2" *** *)
a(DROP_NTH_ASM_T 5 (strip_asm_tac o rewrite_rule[covering_projection_def]));
a(strip_asm_tac open_�_topology_thm);
a(lemma_tac�(y, s) � Space�T (� ��T O�R)�
	THEN1 (ALL_FC_T rewrite_tac[product_topology_space_t_thm]
		THEN asm_rewrite_tac[�_def, space_t_�_thm]));
a(all_fc_tac[continuous_�_space_t_thm]);
a(LIST_DROP_NTH_ASM_T [5] fc_tac);
a(�_tac�{vr|vr � Space�T (� ��T O�R) � h vr � C}�
	THEN asm_rewrite_tac[]);
a(�_tac�C� THEN asm_rewrite_tac[]);
a(�_tac�U� THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(MAP_EVERY �_tac [�n�, �t�, �N�] THEN all_var_elim_asm_tac1
	THEN asm_rewrite_tac[] THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T [2] all_fc_tac THEN all_var_elim_asm_tac1);
a(�_tac�C� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(DROP_NTH_ASM_T 3 (fn th => all_fc_tac[pc_rule1 "sets_ext1"rewrite_rule[�_def]th]));
(* *** Goal "2.2" *** *)
a(�_tac�U� THEN asm_rewrite_tac[]);
pop_thm()
));






val covering_projection_fibration_lemma5 = (* not saved *) snd ( "covering_projection_fibration_lemma5", (
set_goal([], ���; �; �;
	p : 'b � 'c;
	f : 'a � 'b;
	h : 'a � � � 'c �
	� � Topology
�	� � Topology
�	� � Topology
�	p � (�, �) CoveringProjection
�	f � (�, �) Continuous
�	h � (� ��T O�R, �) Continuous
�	(�x� x � Space�T � �  h (x, 0.) = p (f x))
�	y � Space�T �
�	�N : 'a SET�
	y � N � N � � �
	�L : 'a � � � 'b�
	L � ((N � ClosedInterval 0. 1.) �T � ��T O�R, �) Continuous
�	(�x�	x � N
	�	L(x, 0.) = f x)
�	(�x s�	x � N
	�	s � ClosedInterval 0. 1.
	�	p(L(x, s)) = h(x, s))
�);
a(REPEAT strip_tac THEN all_fc_tac[covering_projection_fibration_lemma4]);
a(�_tac�N� THEN REPEAT strip_tac);
a(bc_thm_tac covering_projection_fibration_lemma3);
a(MAP_EVERY �_tac[�n�, �t�, �Ԯ]
	THEN asm_rewrite_tac[]
	THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(bc_thm_tac subspace_domain_continuous_thm
	THEN REPEAT strip_tac);
(* *** Goal "2" *** *)
a(bc_thm_tac subspace_domain_continuous_thm
	THEN REPEAT strip_tac);
a(bc_thm_tac product_topology_thm THEN REPEAT strip_tac);
a(accept_tac open_�_topology_thm);
(* *** Goal "3" *** *)
a(ALL_FC_T (PC_T1 "sets_ext1" all_fc_tac)[open_�_space_t_thm]);
a(DROP_NTH_ASM_T 10 bc_thm_tac THEN strip_tac);
pop_thm()
));




val covering_projection_fibration_thm1 = save_thm ( "covering_projection_fibration_thm1", (
set_goal([], ���; �; �;
	p : 'b � 'c;
	f : 'a � 'b;
	h : 'a � � � 'c �
	� � Topology
�	� � Topology
�	� � Topology
�	p � (�, �) CoveringProjection
�	f � (�, �) Continuous
�	h � (� ��T O�R, �) Continuous
�	(�x� x � Space�T � �  h (x, 0.) = p (f x))
�	�L : 'a � � � 'b�
	L � ((Space�T � � ClosedInterval 0. 1.) �T � ��T O�R, �) Continuous
�	(�x�	x � Space�T �
	�	L(x, 0.) = f x)
�	(�x s�	x � Space�T �
	�	s � ClosedInterval 0. 1.
	�	p(L(x, s)) = h(x, s))
�);
a(REPEAT strip_tac);
a(lemma_tac��N : 'a � 'a SET; K : 'a � 'a � � � 'b�
	�y� y � Space�T � �
	y � N y � N y � � �
	K y � ((N y � ClosedInterval 0. 1.) �T � ��T O�R, �) Continuous
�	(�x�	x � N y
	�	K y (x, 0.) = f x)
�	(�x s�	x � N y
	�	s � ClosedInterval 0. 1.
	�	p(K y (x, s)) = h(x, s))�
	THEN1 (prove_�_tac THEN strip_tac));
a(cases_tac�y'' � Space�T Ү THEN asm_rewrite_tac[]);
a(all_fc_tac[covering_projection_fibration_lemma5]);
a(�_tac�L� THEN �_tac�N� THEN asm_rewrite_tac[]);
(* *** Goal "2" *** *)
a(�_tac��(y, s)� K y (y, s)� THEN rewrite_tac[]
	THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(LEMMA_T�(� (y, s)� K y (y, s)) = 
(� (y, s)� (�(y, s)�K y) (y, s) (y, s))�
	pure_rewrite_thm_tac
	THEN1 rewrite_tac[]);
a(bc_thm_tac compatible_family_continuous_thm1);
a(�_tac��(y, r)�(N y � ClosedInterval 0. 1.)� THEN asm_rewrite_tac[�_def]
	THEN REPEAT strip_tac);
(* *** Goal "2.1.1" *** *)
a(bc_thm_tac product_topology_thm THEN
	asm_rewrite_tac[open_�_topology_thm]);
(* *** Goal "2.1.2" *** *)
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(all_fc_tac[open_�_space_t_thm]);
a(POP_ASM_T ante_tac THEN PC_T1 "sets_ext1" prove_tac[]);
(* *** Goal "2.1.3" *** *)
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
(* *** Goal "2.1.4" *** *)
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(rewrite_tac[subspace_topology_def]);
a(�_tac�N v � Universe� THEN REPEAT strip_tac);
(* *** Goal "2.1.4.1" *** *)
a(rewrite_tac[product_topology_def, �_def]
	THEN REPEAT strip_tac);
a(�_tac�N v� THEN �_tac�Universe� THEN asm_rewrite_tac[empty_universe_open_closed_thm]);
(* *** Goal "2.1.4.2" *** *)
a(all_fc_tac[open_�_space_t_thm]);
a(POP_ASM_T ante_tac THEN PC_T1 "sets_ext1" prove_tac[�_def]);
(* *** Goal "2.1.5" *** *)
a(LIST_DROP_NTH_ASM_T [3] all_fc_tac);
a(LEMMA_T �{(v', w)|v' � N v � w � ClosedInterval 0. 1.} =
	(N v � ClosedInterval 0. 1.)� asm_rewrite_thm_tac);
a(PC_T1 "sets_ext1" prove_tac[�_def]);
(* *** Goal "2.1.6" *** *)
a(LEMMA_T��r�r � ClosedInterval 0. 1. �
	(�r�K w (w, r)) r = (�r�K v (w, r)) r�
	(fn th => ALL_FC_T rewrite_tac[rewrite_rule[]th]));
a(strip_asm_tac open_�_topology_thm);
a(LEMMA_T �ClosedInterval 0. 1. = Space�T(ClosedInterval 0. 1. �T O�R)�
	pure_once_rewrite_thm_tac
	THEN1 (ALL_FC_T rewrite_tac[subspace_topology_space_t_thm]
		THEN rewrite_tac[space_t_�_thm]));
a(lemma_tac�ClosedInterval 0. 1. �T O�R � Topology�
	THEN1 basic_topology_tac[]);
a(bc_thm_tac unique_lifting_thm);
a(MAP_EVERY �_tac[�0.�, �p�, �Ԯ, �Ӯ]
	THEN ALL_FC_T asm_rewrite_tac[subspace_topology_space_t_thm]
	THEN rewrite_tac[space_t_�_thm]
	THEN REPEAT strip_tac);
(* *** Goal "2.1.6.1" *** *)
a(ALL_FC_T1 fc_�_canon rewrite_tac[
	conv_rule(ONCE_MAP_C eq_sym_conv)connected_topological_thm]);
a(bc_tac[closed_interval_connected_thm] THEN REPEAT strip_tac);
(* *** Goal "2.1.6.2" *** *)
a(bc_thm_tac comp_continuous_thm);
a(lemma_tac�� ��T O�R � Topology�
	THEN1 ALL_FC_T rewrite_tac[product_topology_thm]);
a(lemma_tac�(N v � ClosedInterval 0. 1.) �T � ��T O�R � Topology�
	THEN1 ALL_FC_T rewrite_tac[subspace_topology_thm]);
a(�_tac�(N v � ClosedInterval 0. 1.) �T � ��T O�R�
	THEN REPEAT strip_tac);
(* *** Goal "2.1.6.2.1" *** *)
a(LEMMA_T�$, w = �r:��(w, r)� once_rewrite_thm_tac
	THEN1 rewrite_tac[]);
a(bc_thm_tac subspace_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "2.1.6.2.1.1" *** *)
a(bc_thm_tac right_product_inj_continuous_thm
	THEN REPEAT strip_tac);
a(lemma_tac�N v � Ү THEN1 LIST_DROP_NTH_ASM_T[9] all_fc_tac);
a(ALL_FC_T (PC_T1 "sets_ext1" all_fc_tac)[open_�_space_t_thm]);
(* *** Goal "2.1.6.2.1.2" *** *)
a(POP_ASM_T ante_tac THEN PC_T1 "sets_ext1" rewrite_tac[�_def]
	THEN REPEAT strip_tac);
(* *** Goal "2.1.6.2.2" *** *)
a(LIST_DROP_NTH_ASM_T [9] fc_tac);
(* *** Goal "2.1.6.3" *** *)
a(bc_thm_tac comp_continuous_thm);
a(lemma_tac�� ��T O�R � Topology�
	THEN1 ALL_FC_T rewrite_tac[product_topology_thm]);
a(lemma_tac�N v � Ү THEN1 LIST_DROP_NTH_ASM_T[8] all_fc_tac);
a(ALL_FC_T (PC_T1 "sets_ext1" all_fc_tac)[open_�_space_t_thm]);
a(lemma_tac�(N w � ClosedInterval 0. 1.) �T � ��T O�R � Topology�
	THEN1 ALL_FC_T rewrite_tac[subspace_topology_thm]);
a(�_tac�(N w � ClosedInterval 0. 1.) �T � ��T O�R�
	THEN REPEAT strip_tac);
(* *** Goal "2.1.6.3.1" *** *)
a(LEMMA_T�$, w = �r:��(w, r)� once_rewrite_thm_tac
	THEN1 rewrite_tac[]);
a(bc_thm_tac subspace_continuous_thm THEN REPEAT strip_tac);
(* *** Goal "2.1.6.3.1.1" *** *)
a(bc_thm_tac right_product_inj_continuous_thm
	THEN REPEAT strip_tac);
(* *** Goal "2.1.6.3.1.2" *** *)
a(POP_ASM_T ante_tac THEN PC_T1 "sets_ext1" rewrite_tac[�_def]
	THEN REPEAT strip_tac);
a(LIST_DROP_NTH_ASM_T[12] all_fc_tac);
(* *** Goal "2.1.6.3.2" *** *)
a(LIST_DROP_NTH_ASM_T [11] fc_tac);
(* *** Goal "2.1.6.4" *** *)
a(lemma_tac�N v � Ү THEN1 LIST_DROP_NTH_ASM_T[8] all_fc_tac);
a(ALL_FC_T (PC_T1 "sets_ext1" all_fc_tac)[open_�_space_t_thm]);
a(LIST_DROP_NTH_ASM_T [10] fc_tac);
(* It is unclear why so much hand-instantiation is needed here. *)
a(list_spec_nth_asm_tac 5 [�w�, �x�]);
a(list_spec_nth_asm_tac 10 [�w�, �x�]);
a(asm_rewrite_tac[]);
(* *** Goal "2.1.6.5" *** *)
a(rewrite_tac[closed_interval_def]);
(* *** Goal "2.1.6.6" *** *)
a(lemma_tac�N v � Ү THEN1 LIST_DROP_NTH_ASM_T[7] all_fc_tac);
a(ALL_FC_T (PC_T1 "sets_ext1" all_fc_tac)[open_�_space_t_thm]);
a(LIST_DROP_NTH_ASM_T [9] fc_tac);
a(spec_nth_asm_tac 4 �w�);
a(spec_nth_asm_tac 9 �w�);
a(asm_rewrite_tac[]);
(* *** Goal "2.2" *** *)
a(all_asm_fc_tac[] THEN all_asm_fc_tac[]);
(* *** Goal "2.3" *** *)
a(LIST_DROP_NTH_ASM_T [3] fc_tac);
a(LIST_DROP_NTH_ASM_T [5] all_fc_tac);
pop_thm()
));


val covering_projection_continuous_thm = save_thm ( "covering_projection_continuous_thm", (
set_goal([], ��� � p �
	� � Topology
�	� � Topology
�	p � (�, �) CoveringProjection
�	p � (�, �) Continuous
�);
a(rewrite_tac [covering_projection_def] THEN taut_tac);
pop_thm()
));


val covering_projection_fibration_thm = save_thm ( "covering_projection_fibration_thm", (
set_goal([], ���; �; �;
	p : 'b � 'c �
	� � Topology
�	� � Topology
�	� � Topology
�	p � (�, �) CoveringProjection
�	(�, (p, �, �)) � HomotopyLiftingProperty
�);
a(rewrite_tac [homotopy_lifting_property_def] THEN REPEAT strip_tac
	THEN1 all_fc_tac[covering_projection_continuous_thm]);
a(all_fc_tac[covering_projection_fibration_thm1]);
a(LEMMA_T �Space�T � � Space�T Ү asm_tac THEN1 rewrite_tac[]);
a(LEMMA_T �0. � 1.� asm_tac THEN1 rewrite_tac[]);
a(all_fc_tac [closed_interval_extension_thm]);
a(�_tac�g� THEN REPEAT strip_tac);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 2 ante_tac);
a(strip_asm_tac open_�_topology_thm);
a(lemma_tac�� ��T O�R � Topology� THEN1 basic_topology_tac[]);
a(LEMMA_T �(Space�T � � Universe) = Space�T(� ��T O�R)�
	(fn th => rewrite_tac[th]
		THEN ALL_FC_T rewrite_tac[trivial_subspace_topology_thm]));
a(ALL_FC_T rewrite_tac[product_topology_space_t_thm]);
a(rewrite_tac[space_t_�_thm]);
(* *** Goal "2" *** *)
a(lemma_tac�0. � ClosedInterval 0. 1.� THEN1 rewrite_tac[closed_interval_def]);
a(ALL_ASM_FC_T asm_rewrite_tac[]);
(* *** Goal "3" *** *)
a(ALL_ASM_FC_T asm_rewrite_tac[]);
pop_thm()
));



val covering_projection_path_lifting_thm = save_thm ( "covering_projection_path_lifting_thm", (
set_goal([], ���; �;
	p : 'a � 'b;
	y : 'a;
	f : � � 'b �
	� � Topology
�	� � Topology
�	p � (�, �) CoveringProjection
�	f � Paths �
�	y � Space�T �
�	p y = f 0.
�	�g: � � 'a�
	g � Paths �
�	g 0. = y
�	(�s� p(g s) = f s)
�);
a(REPEAT strip_tac);
a(DROP_NTH_ASM_T 3 (strip_asm_tac o rewrite_rule[paths_def]));
a(lemma_tac��h: � � 'a�
	h � (O�R, �) Continuous
�	h 0. = y
�	(�s� s � ClosedInterval 0. 1. � p(h s) = f s)�);
(* *** Goal "1" *** *)
a((ante_tac o list_�_elim[ �1�T�, �Ӯ, �Ԯ, �p�])
	covering_projection_fibration_thm);
a(asm_rewrite_tac [homotopy_lifting_property_def,
	one_def, unit_topology_thm, space_t_unit_topology_thm]);
a(ALL_FC_T rewrite_tac[covering_projection_continuous_thm]);
a(STRIP_T (ante_tac o list_�_elim[ ��x:ONE�y�, ��(x:ONE, t)�f t�]));
a(asm_rewrite_tac[] THEN REPEAT strip_tac);
(* *** Goal "1.1" *** *)
a(i_contr_tac THEN POP_ASM_T ante_tac THEN �_continuity_tac[unit_topology_thm]);
(* *** Goal "1.2" *** *)
a(i_contr_tac THEN POP_ASM_T ante_tac THEN �_continuity_tac[unit_topology_thm]);
(* *** Goal "1.3" *** *)
a(�_tac��t� L(One, t)� THEN asm_rewrite_tac[]);
a(lemma_tac�1�T ��T O�R � Topology� THEN1 basic_topology_tac[open_�_topology_thm]);
a(�_continuity_tac[unit_topology_thm, space_t_unit_topology_thm]);
(* *** Goal "2" *** *)
a(DROP_NTH_ASM_T 6 (fn th => all_fc_tac[paths_representative_thm]
	THEN asm_tac th));
a(�_tac�g� THEN REPEAT strip_tac);
(* *** Goal "2.1" *** *)
a(DROP_NTH_ASM_T 6 (rewrite_thm_tac o eq_sym_rule));
a(DROP_NTH_ASM_T 3 bc_thm_tac THEN rewrite_tac[closed_interval_def]);
(* *** Goal "2.2" *** *)
a(cases_tac�s � ClosedInterval 0. 1.� THEN1 ALL_ASM_FC_T rewrite_tac[]);
a(DROP_NTH_ASM_T 5 (strip_asm_tac o rewrite_rule[paths_def]));
a(DROP_NTH_ASM_T 4 (strip_asm_tac o rewrite_rule[closed_interval_def]));
(* *** Goal "2.2.1" *** *)
a(lemma_tac�s � 0.� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(ALL_ASM_FC_T rewrite_tac[]);
a(LEMMA_T �g 0. = h 0.� rewrite_thm_tac THEN1
	(DROP_NTH_ASM_T 8 bc_thm_tac THEN rewrite_tac[closed_interval_def]));
a(DROP_NTH_ASM_T 9 bc_thm_tac THEN rewrite_tac[closed_interval_def]);
(* *** Goal "2.2.2" *** *)
a(lemma_tac�1. � s� THEN1 PC_T1 "�_lin_arith" asm_prove_tac[]);
a(ALL_ASM_FC_T rewrite_tac[]);
a(LEMMA_T �g 1. = h 1.� rewrite_thm_tac THEN1
	(DROP_NTH_ASM_T 8 bc_thm_tac THEN rewrite_tac[closed_interval_def]));
a(DROP_NTH_ASM_T 9 bc_thm_tac THEN rewrite_tac[closed_interval_def]);
pop_thm()
));

output_theory{out_file="wrk0671.th.doc", theory="topology"};
output_theory{out_file="wrk0672.th.doc", theory="metric_spaces"};
output_theory{out_file="wrk0673.th.doc", theory="topology_�"};
output_theory{out_file="wrk0674.th.doc", theory="homotopy"};
