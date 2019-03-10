force_delete_theory"BASICS'spec" handle Fail _ => ();
new_script {name="BASICS", unit_type="spec"};
�CN
package BASICS is

    BASE : constant INTEGER := 10;
    PRECISION : constant INTEGER := 6;
    MAX_NUMBER : constant INTEGER := BASE ** PRECISION - 1;
    MIN_NUMBER : constant INTEGER := -MAX_NUMBER;

    subtype DIGIT is INTEGER range 0 .. BASE - 1;

    subtype NUMBER is INTEGER range MIN_NUMBER .. MAX_NUMBER;

    type OPERATION is
      (PLUS, MINUS, TIMES, CHANGE_SIGN, SQUARE_ROOT, FACTORIAL, EQUALS);

end BASICS;
�
output_ada_program{script="BASICS'spec", out_file="wrk507.ada"};
output_hypertext_edit_script{out_file="wrk507.ex"};
new_script {name="STATE", unit_type="spec"};
�CN
with BASICS;
package STATE is

    DISPLAY, ACCUMULATOR : BASICS.NUMBER;

    LAST_OP : BASICS.OPERATION;

    IN_NUMBER : BOOLEAN;

end STATE;
�
output_ada_program{script="-", out_file="wrk507a.ada"};
output_hypertext_edit_script{out_file="wrk507a.ex"};
open_theory "BASICS'spec";
new_theory "preliminaries";
� DO_DIGIT �����������
� DISPLAY�0, DISPLAY : �;
� IN_NUMBER�0, IN_NUMBER : BOOLEAN;
� D : BASICSoDIGIT
�������
�	IN_NUMBER�0 = TRUE � DISPLAY = DISPLAY�0*BASICSoBASE + D;
�	IN_NUMBER�0 = FALSE �  DISPLAY = D;
�	IN_NUMBER = TRUE
�
�Z
� UNARY � {BASICSoCHANGE_SIGN, BASICSoFACTORIAL, BASICSoSQUARE_ROOT}
�
�Z
� BINARY � BASICSoOPERATION \ UNARY
�
�ZAX
�	fact : � � �
�������
�	fact 0 = 1 ;
� 	�m:� fact(m+1) = (m + 1) * fact m
�
� DO_UNARY_OPERATION �����������
� ACCUMULATOR�0, ACCUMULATOR : �;
� DISPLAY�0, DISPLAY : �;
� LAST_OP�0, LAST_OP : �;
� IN_NUMBER : BOOLEAN;
� O : UNARY
�������
�	IN_NUMBER = FALSE;
�	ACCUMULATOR = ACCUMULATOR�0;
�	LAST_OP = LAST_OP�0;
�	O = BASICSoCHANGE_SIGN � DISPLAY = ~DISPLAY�0;
�	O = BASICSoFACTORIAL � DISPLAY�0 � 0 � DISPLAY = fact DISPLAY�0;
�	O = BASICSoSQUARE_ROOT  � DISPLAY�0 � 0 �
�			DISPLAY ** 2 � DISPLAY�0 < (DISPLAY + 1) ** 2
�
� DO_BINARY_OPERATION �����������
� ACCUMULATOR�0, ACCUMULATOR : �;
� DISPLAY�0, DISPLAY : �;
� LAST_OP�0, LAST_OP : �;
� IN_NUMBER : BOOLEAN;
� O : BINARY
�������
�	IN_NUMBER = FALSE;
�	DISPLAY = ACCUMULATOR;
�	LAST_OP = O;
�	LAST_OP�0 = BASICSoEQUALS �
�			ACCUMULATOR = DISPLAY�0;
�	LAST_OP�0 = BASICSoPLUS �
�			ACCUMULATOR = ACCUMULATOR�0 + DISPLAY�0;
�	LAST_OP�0 = BASICSoMINUS �
�			ACCUMULATOR = ACCUMULATOR�0 - DISPLAY�0;
�	LAST_OP�0 = BASICSoTIMES �
�			ACCUMULATOR = ACCUMULATOR�0 * DISPLAY�0
�
�Z
� DO_OPERATION � DO_UNARY_OPERATION � DO_BINARY_OPERATION
�
new_script1 {name="OPERATIONS", unit_type="spec", library_theories=["preliminaries"]};
�CN
with BASICS, STATE;
package OPERATIONS is
procedure DIGIT_BUTTON (D : in BASICS.DIGIT)
        � STATEoDISPLAY, STATEoIN_NUMBER [
         DO_DIGIT [
           STATEoDISPLAY�0/DISPLAY�0,  STATEoDISPLAY/DISPLAY,
           STATEoIN_NUMBER�0/IN_NUMBER�0, STATEoIN_NUMBER/IN_NUMBER,
           D/D] ] ;
procedure OPERATION_BUTTON (O : in BASICS.OPERATION)
        � STATEoACCUMULATOR, STATEoDISPLAY,
                STATEoIN_NUMBER, STATEoLAST_OP [
         DO_OPERATION[
          STATEoACCUMULATOR�0/ACCUMULATOR�0,
          STATEoACCUMULATOR/ACCUMULATOR,
          STATEoDISPLAY�0/DISPLAY�0,  STATEoDISPLAY/DISPLAY,
          STATEoLAST_OP�0/LAST_OP�0,  STATEoLAST_OP/LAST_OP,
          STATEoIN_NUMBER�0/IN_NUMBER�0, STATEoIN_NUMBER/IN_NUMBER,
          D/D] ] ;
end OPERATIONS;
�
output_ada_program{script="-", out_file="wrk507b.ada"};
output_hypertext_edit_script{out_file="wrk507b.ex"};
new_script {name="OPERATIONS", unit_type="body"};
�CN
$references BASICS, STATE;
package body OPERATIONS is
procedure DIGIT_BUTTON (D : in BASICS.DIGIT)
        � STATEoDISPLAY, STATEoIN_NUMBER [
         DO_DIGIT [
           STATEoDISPLAY�0/DISPLAY�0, STATEoDISPLAY/DISPLAY,
           STATEoIN_NUMBER�0/IN_NUMBER�0, STATEoIN_NUMBER/IN_NUMBER,
           D/D] ]
    is begin
        � STATEoDISPLAY, STATEoIN_NUMBER [
         DO_DIGIT [ STATEoDISPLAY�0/DISPLAY�0, STATEoDISPLAY/DISPLAY,
           STATEoIN_NUMBER�0/IN_NUMBER�0, STATEoIN_NUMBER/IN_NUMBER,
           D/D] ]				(3001)
    end DIGIT_BUTTON;
procedure OPERATION_BUTTON (O : in BASICS.OPERATION)
        � STATEoACCUMULATOR, STATEoDISPLAY,
                 STATEoIN_NUMBER, STATEoLAST_OP [
         DO_OPERATION[
          STATEoACCUMULATOR�0/ACCUMULATOR�0,
          STATEoACCUMULATOR/ACCUMULATOR,
          STATEoDISPLAY�0/DISPLAY�0, STATEoDISPLAY/DISPLAY,
          STATEoLAST_OP�0/LAST_OP�0, STATEoLAST_OP/LAST_OP,
          STATEoIN_NUMBER�0/IN_NUMBER�0, STATEoIN_NUMBER/IN_NUMBER,
          D/D] ]
    is
       � Extra Declarations �			( 500 )
    begin
        � STATEoACCUMULATOR, STATEoDISPLAY,
                STATEoIN_NUMBER, STATEoLAST_OP [
         DO_OPERATION[ STATEoACCUMULATOR�0/ACCUMULATOR�0,
          STATEoACCUMULATOR/ACCUMULATOR,
          STATEoDISPLAY�0/DISPLAY�0, STATEoDISPLAY/DISPLAY,
          STATEoLAST_OP�0/LAST_OP�0, STATEoLAST_OP/LAST_OP,
          STATEoIN_NUMBER�0/IN_NUMBER�0, STATEoIN_NUMBER/IN_NUMBER,
          D/D] ]			(3002)
    end OPERATION_BUTTON;
end OPERATIONS;
�
open_theory "cn";
set_pc"cn";
open_theory "OPERATIONS'body";
set_goal([], get_conjecture"-""vcOPERATIONS_1");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONS_1";
set_goal([], get_conjecture"-""vcOPERATIONS_2");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONS_2";
set_goal([], get_conjecture"-""vcOPERATIONS_3");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONS_3";
set_goal([], get_conjecture"-""vcOPERATIONS_4");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONS_4";
open_theory "OPERATIONSoDIGIT_BUTTON'proc";
set_goal([], get_conjecture"-""vcOPERATIONSoDIGIT_BUTTON_1");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONSoDIGIT_BUTTON_1";
set_goal([], get_conjecture"-""vcOPERATIONSoDIGIT_BUTTON_2");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONSoDIGIT_BUTTON_2";
open_theory "OPERATIONSoOPERATION_BUTTON'proc";
set_goal([], get_conjecture"-""vcOPERATIONSoOPERATION_BUTTON_1");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONSoOPERATION_BUTTON_1";
set_goal([], get_conjecture"-""vcOPERATIONSoOPERATION_BUTTON_2");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONSoOPERATION_BUTTON_2";
open_scope "OPERATIONS.OPERATION_BUTTON";
�CN
 (500) �
    function FACT (M : NATURAL) return NATURAL
        � [ FACT(M) = fact(M) ]
    is
        RESULT : NATURAL;
    begin
        RESULT := 1;
        � RESULT [M � 0 � RESULT = 1, RESULT = fact M ]	(1001)
        return RESULT;
    end FACT;

    function SQRT (M : NATURAL) return NATURAL
        � [SQRT(M) ** 2 � M < (SQRT(M) + 1) ** 2]
    is
        RESULT : NATURAL;
       � other local vars �		(2)
    begin
       RESULT := 0;
       � RESULT [RESULT = 0, RESULT ** 2 � M < (RESULT + 1) ** 2]	(2001)
      return RESULT;
    end SQRT;
�
open_theory "preliminaries";
set_goal([], �m : NATURAL� m � 0�);
a(rewrite_tac[z_get_spec�NATURAL�] THEN REPEAT strip_tac);
val natural_thm = save_pop_thm"natural_thm";
open_scope "OPERATIONS.OPERATION_BUTTON.FACT";
set_goal([], get_conjecture"-""vcOPERATIONSoOPERATION_BUTTONoFACT_1");
a(REPEAT strip_tac THEN all_fc_tac[natural_thm]);
val _ = save_pop_thm "vcOPERATIONSoOPERATION_BUTTONoFACT_1";
set_goal([], get_conjecture"-""vcOPERATIONSoOPERATION_BUTTONoFACT_2");
a(REPEAT strip_tac THEN all_var_elim_asm_tac1);
val _ = save_pop_thm "vcOPERATIONSoOPERATION_BUTTONoFACT_2";
open_scope "OPERATIONS.OPERATION_BUTTON.SQRT";
set_goal([], get_conjecture"-""vcOPERATIONSoOPERATION_BUTTONoSQRT_1");
a(REPEAT strip_tac);
val _ = save_pop_thm "vcOPERATIONSoOPERATION_BUTTONoSQRT_1";
set_goal([], get_conjecture"-""vcOPERATIONSoOPERATION_BUTTONoSQRT_2");
a(REPEAT strip_tac THEN all_var_elim_asm_tac1);
val _ = save_pop_thm "vcOPERATIONSoOPERATION_BUTTONoSQRT_2";
open_scope "OPERATIONS";
open_scope "OPERATIONS.OPERATION_BUTTON.FACT";
�CN
  (1001) �
    for J in INTEGER range 2 .. M
    loop
        � RESULT [J � 1 � RESULT = fact (J-1), RESULT = fact J] (1002)
    end loop;
�
set_goal([], �fact 0 = 1 � fact 1 = 1�);
a(rewrite_tac[z_get_spec�fact�,
	(rewrite_rule[z_get_spec�fact�] o z_�_elim�0� o
			�_right_elim o �_right_elim o z_get_spec)�fact�
]);
val fact_thm  = save_pop_thm"fact_thm";
set_goal([], get_conjecture"-""vc1001_1");
a(REPEAT strip_tac THEN asm_rewrite_tac[fact_thm]);
val _ = save_pop_thm "vc1001_1";
set_goal([], get_conjecture"-""vc1001_2");
a(REPEAT strip_tac THEN all_var_elim_asm_tac1);
a(lemma_tac�M = 0 � M = 1�);
(* *** Goal "1" *** *)
a(PC_T1 "z_lin_arith" asm_prove_tac[]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[fact_thm]);
(* *** Goal "3" *** *)
a(asm_rewrite_tac[fact_thm]);
val _ = save_pop_thm "vc1001_2";
set_goal([], get_conjecture"-""vc1001_3");
a(REPEAT strip_tac);
(* *** Goal "1" *** *)
a(asm_ante_tac�2 � J� THEN PC_T1 "z_lin_arith" prove_tac[]);
(* *** Goal "2" *** *)
a(asm_rewrite_tac[z_plus_assoc_thm]);
val _ = save_pop_thm "vc1001_3";
set_goal([], get_conjecture"-""vc1001_4");
a(REPEAT strip_tac THEN asm_rewrite_tac[]);
val _ = save_pop_thm "vc1001_4";
�CN
  (1002) �
       RESULT := J * RESULT;
�
set_goal([], get_conjecture"-""vc1002_1");
a(REPEAT strip_tac THEN all_var_elim_asm_tac1);
a(lemma_tac�K:�� K + 1 = J�);
(* *** Goal "1" *** *)
a(z_�_tac�J - 1� THEN PC_T1 "z_lin_arith" prove_tac[]);
(* *** Goal "2" *** *)
a(all_var_elim_asm_tac1);
a(rewrite_tac[z_plus_assoc_thm]);
a(ALL_FC_T rewrite_tac[z_get_spec�fact�]);
val _ = save_pop_thm "vc1002_1";
open_scope"OPERATIONS.OPERATION_BUTTON.SQRT";
�CN
(2) �
    MID, HI : INTEGER;
�
�CN
(2001) �
        � RESULT, MID, HI
            [RESULT = 0, RESULT ** 2 � M < (RESULT + 1) ** 2] (2002)
�
set_goal([], get_conjecture "-" "vc2001_1");
a(REPEAT strip_tac);
val _ = save_pop_thm "vc2001_1";
set_goal([], get_conjecture "-" "vc2001_2");
a(REPEAT strip_tac);
val _ = save_pop_thm "vc2001_2";
�CN
(2002) �
       HI := M + 1;
       $till �RESULT ** 2 � M < (RESULT + 1) ** 2�
       loop
           � RESULT, MID, HI
               [RESULT ** 2 � M < HI ** 2, RESULT ** 2 � M < HI ** 2] (2003)
       end loop;
�
set_goal([], �x: ��  x ** 1 = x�);
a(REPEAT strip_tac);
a(rewrite_tac[rewrite_rule[](
    z_�_elim�(x � x, y � 0)� (�_right_elim(z_get_spec�(_**_)�)))]);
val star_star_1_thm = pop_thm();
set_goal([], �x: ��  x ** 2 = x * x�);
a(REPEAT strip_tac);
a(rewrite_tac[star_star_1_thm, rewrite_rule[](
    z_�_elim�(x � x, y � 1)� (�_right_elim(z_get_spec�(_**_)�)))]);
val star_star_2_thm = pop_thm();
set_goal([], get_conjecture "-" "vc2002_1");
a(REPEAT strip_tac THEN all_fc_tac[natural_thm]);
(* *** Goal "1" *** *)
a(asm_rewrite_tac[star_star_1_thm, star_star_2_thm]);
(* *** Goal "2" *** *)
a(POP_ASM_T ante_tac THEN DROP_ASMS_T discard_tac THEN strip_tac);
a(z_�_induction_tac�M�);
(* *** Goal "2.1" *** *)
a(rewrite_tac[star_star_1_thm, star_star_2_thm]);
(* *** Goal "2.2" *** *)
a(POP_ASM_T ante_tac);
a(rewrite_tac[star_star_2_thm]);
a(PC_T1 "z_lin_arith" asm_prove_tac[]);
val _ = save_pop_thm "vc2002_1";
set_goal([], get_conjecture "-" "vc2002_2");
a(REPEAT strip_tac);
val _ = save_pop_thm "vc2002_2";
set_goal([], get_conjecture "-" "vc2002_3");
a(REPEAT strip_tac);
val _ = save_pop_thm "vc2002_3";
�CN
(2003) �
       exit when RESULT + 1 = HI;
       � RESULT, MID, HI
            [RESULT ** 2 � M < HI ** 2, RESULT ** 2 � M < HI ** 2] (2004)
�
set_goal([], get_conjecture "-" "vc2003_1");
a(rewrite_tac[]);
a(REPEAT strip_tac);
a(all_var_elim_asm_tac1);
val _ = save_pop_thm "vc2003_1";
set_goal([], get_conjecture "-" "vc2003_2");
a(REPEAT strip_tac);
val _ = save_pop_thm "vc2003_2";
set_goal([], get_conjecture "-" "vc2003_3");
a(REPEAT strip_tac);
val _ = save_pop_thm "vc2003_3";
�CN
(2004)    �
    MID := (RESULT + HI + 1) / 2;
    if      MID ** 2 > M
    then    HI := MID;
    else    RESULT := MID;
    end if;
�
set_goal([], get_conjecture "-" "vc2004_1");
a(rewrite_tac[star_star_2_thm]);
a(REPEAT strip_tac);
val _ = save_pop_thm "vc2004_1";
set_goal([], get_conjecture "-" "vc2004_2");
a(rewrite_tac[star_star_2_thm]);
a(REPEAT strip_tac);
val _ = save_pop_thm "vc2004_2";
open_scope"OPERATIONS.DIGIT_BUTTON";
�CN
 (3001) �
    if    STATE.IN_NUMBER
    then  STATE.DISPLAY := STATE.DISPLAY * BASICS.BASE + D;
    else  STATE.DISPLAY := D;
    end if;
    STATE.IN_NUMBER := true;
�
set_goal([], get_conjecture"-""vc3001_1");
a(REPEAT strip_tac);
a(asm_rewrite_tac[z_get_spec�DO_DIGIT�]);
a(REPEAT strip_tac);
val _ = save_pop_thm "vc3001_1";
set_goal([], get_conjecture"-""vc3001_2");
a(REPEAT strip_tac);
a(asm_rewrite_tac[z_get_spec�DO_DIGIT�]);
val _ = save_pop_thm "vc3001_2";
open_scope "OPERATIONS.OPERATION_BUTTON";
�CN
 (3002) �
    if      O = BASICS.CHANGE_SIGN
    then    STATE.DISPLAY := -STATE.DISPLAY;
    elsif   O = BASICS.FACTORIAL
    then    STATE.DISPLAY := FACT(STATE.DISPLAY);
    elsif   O = BASICS.SQUARE_ROOT
    then    STATE.DISPLAY := SQRT(STATE.DISPLAY);
    else    if      STATE.LAST_OP = BASICS.EQUALS
            then    STATE.ACCUMULATOR := STATE.DISPLAY;
            elsif   STATE.LAST_OP = BASICS.PLUS
            then   STATE.ACCUMULATOR := STATE.ACCUMULATOR + STATE.DISPLAY;
            elsif   STATE.LAST_OP = BASICS.MINUS
            then   STATE.ACCUMULATOR := STATE.ACCUMULATOR - STATE.DISPLAY;
            elsif   STATE.LAST_OP = BASICS.TIMES
            then   STATE.ACCUMULATOR := STATE.ACCUMULATOR * STATE.DISPLAY;
            end if;
            STATE.DISPLAY := STATE.ACCUMULATOR;
            STATE.LAST_OP := O;
    end if;
    STATE.IN_NUMBER := false;
�
open_theory "preliminaries";
val basics_defs = map z_get_spec(get_consts"BASICS'spec");
val op_defs = map z_get_spec(flat(
	map get_consts ["preliminaries", "OPERATIONS'body", "OPERATIONS'spec"]));
open_scope "OPERATIONS.OPERATION_BUTTON";
set_goal([], get_conjecture"-""vc3002_1");
a(rewrite_tac op_defs);
a(z_�_tac THEN �_tac THEN asm_rewrite_tac basics_defs);
val _ = save_pop_thm "vc3002_1";
�Z
� BASICSoMAX_NUMBER � INTEGERvLAST
�
val number_ax = snd(hd(get_axioms"-"));
set_goal([], get_conjecture"-""vc3002_2");
a(rewrite_tac op_defs);
a(z_�_tac THEN �_tac THEN asm_rewrite_tac basics_defs);
a(all_var_elim_asm_tac1 THEN strip_tac);
a(lemma_tac �STATEoDISPLAY � NATURAL�);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 5 ante_tac);
a(ante_tac number_ax);
a(asm_rewrite_tac(z_get_spec�NATURAL� :: basics_defs));
a(PC_T1 "z_lin_arith" prove_tac[]);
(* *** Goal "2" *** *)
a(ALL_FC_T rewrite_tac[z_get_spec�FACT�]);
val _ = save_pop_thm "vc3002_2";
set_goal([], get_conjecture"-""vc3002_3");
a(rewrite_tac op_defs);
a(z_�_tac THEN �_tac THEN asm_rewrite_tac basics_defs);
a(all_var_elim_asm_tac1 THEN strip_tac);
a(lemma_tac �STATEoDISPLAY � NATURAL�);
(* *** Goal "1" *** *)
a(DROP_NTH_ASM_T 6 ante_tac);
a(ante_tac number_ax);
a(asm_rewrite_tac(z_get_spec�NATURAL� :: basics_defs));
a(PC_T1 "z_lin_arith" prove_tac[]);
(* *** Goal "2" *** *)
a(all_fc_tac[z_get_spec�SQRT�]);
a(REPEAT strip_tac);
val _ = save_pop_thm "vc3002_3";
set_goal([], get_conjecture"-""vc3002_4");
a(rewrite_tac op_defs);
a(z_�_tac THEN �_tac THEN asm_rewrite_tac basics_defs);
val _ = save_pop_thm "vc3002_4";
set_goal([], get_conjecture"-""vc3002_5");
a(rewrite_tac op_defs);
a(z_�_tac THEN �_tac THEN asm_rewrite_tac basics_defs);
val _ = save_pop_thm "vc3002_5";
set_goal([], get_conjecture"-""vc3002_6");
a(rewrite_tac op_defs);
a(z_�_tac THEN �_tac THEN asm_rewrite_tac basics_defs);
val _ = save_pop_thm "vc3002_6";
set_goal([], get_conjecture"-""vc3002_7");
a(rewrite_tac op_defs);
a(z_�_tac THEN �_tac THEN asm_rewrite_tac basics_defs);
val _ = save_pop_thm "vc3002_7";
set_goal([], get_conjecture"-""vc3002_8");
a(rewrite_tac op_defs);
a(z_�_tac THEN �_tac THEN asm_rewrite_tac basics_defs);
val _ = save_pop_thm "vc3002_8";
output_ada_program{script="OPERATIONS'body", out_file="wrk507c.ada"};
output_hypertext_edit_script{out_file="wrk507c.ex"};
output_z_document{script="BASICS'spec", out_file="wrk507.zdoc"};
output_z_document{script="STATE'spec", out_file="wrk507a.zdoc"};
output_z_document{script="OPERATIONS'spec", out_file="wrk507b.zdoc"};
output_z_document{script="OPERATIONS'body", out_file="wrk507c.zdoc"};
val thys = get_descendants "cn" less "cn";
val unproved =
map (fn thy => (open_theory thy; (thy, get_unproved_conjectures thy))) thys drop (is_nil o snd);
val _ =
	if	is_nil unproved
	then	diag_line "All module tests passed"
	else	diag_line "Some VCs have not been proved";
