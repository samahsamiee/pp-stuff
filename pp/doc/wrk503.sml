
new_script {name="PACK_P", unit_type="spec"};

�CN
� package PACK_P spec �	(1)
�
�CN
(1) �

package PACK_P is
   I : INTEGER;
   type COLOUR is (RED, BLUE, GREEN);
   procedure SQRT (X : INTEGER; Y : out INTEGER)

    � Y [X � 0, Y ** 2 � X < (Y + 1) ** 2];

   procedure CUBE_ROOT (N : in out INTEGER)

    � N [N � 0, N ** 3 � N�0 < (N + 1) ** 3];

   function NEXT_COLOUR (C : COLOUR) return COLOUR

    �
    [true,
    C � PACK_PoCOLOURvLAST �
    PACK_PoNEXT_COLOUR(C) = PACK_PoCOLOURvSUCC(C)
    �
    C = PACK_PoCOLOURvLAST �
    PACK_PoNEXT_COLOUR(C) = PACK_PoCOLOURvFIRST];

   function PLUS_ONE (X : INTEGER) return INTEGER;

end PACK_P;
�

output_z_document{script="PACK_P'spec", out_file="lit1.zdoc"};
output_ada_program{script="-", out_file="lit1.ada"};
new_script {name="MAIN", unit_type="proc"};

�CN
� main procedure �		(2)
�
�CN
(2) �

with PACK_P;
procedure MAIN is
   C : PACK_P.COLOUR;
   type PERSON is
   record
      AGE : INTEGER;
      EYES : PACK_P.COLOUR;
   end record;
   JACK : PERSON;
begin
      PACK_P.CUBE_ROOT(PACK_P.I);

       � C, JACK [true, C = PACK_PoRED]

      C := PACK_P.BLUE;
end MAIN;
�
�CN
�

JACK := PERSON'(25, PACK_P.GREEN);
C := PACK_P.NEXT_COLOUR(JACK.EYES);
�

output_z_document{script="MAIN'proc", out_file="lit1a.zdoc"};
output_ada_program{script="-", out_file="lit1a.ada"};


new_script {name="PACK_P", unit_type="body"};

�CN
� package PACK_P body �	(1)
�
�CN
(1) �

package body PACK_P is
   HAIR : COLOUR;
   J, K : INTEGER;
   type ARR_COLOUR is array(COLOUR) of COLOUR;
   NEXT_COL : constant ARR_COLOUR :=
                 ARR_COLOUR'(BLUE, GREEN, RED);
   function PLUS_TWO (L : INTEGER) return INTEGER

   � [true, PLUS_TWO(L) = L + 2]

   is
   begin
      return L + 2;
   end PLUS_TWO;
   procedure SQRT (X : INTEGER; Y : out INTEGER)

    � Y [X � 0, Y ** 2 � X < (Y + 1) ** 2]

   is separate;
   procedure CUBE_ROOT (N : in out INTEGER)

    � N, J [N � 0, N ** 3 � N�0 < (N + 1) ** 3]

   is
      L : INTEGER;
   begin

      � N, J, L [N � 0, N ** 3 � N�0 < (N + 1) ** 3]	(2)

      L := PLUS_TWO(L);
   end CUBE_ROOT;

   � function NEXT_COLOUR body �				(3)

   function PLUS_ONE (X : INTEGER) return INTEGER

    � [true, PLUS_ONE(X) = X + 1]

   is
      L : INTEGER;

        � procedure PLUS_FOUR body �				(4)

   begin

        � L [true, PLUS_ONE(X) = X + 1]			(5)

   end PLUS_ONE;
end PACK_P;
�
�CN
(3) �

function NEXT_COLOUR (C : COLOUR) return COLOUR

�
[true,
C � PACK_PoCOLOURvLAST �
NEXT_COLOUR(C) = PACK_PoCOLOURvSUCC(C)
�
C = PACK_PoCOLOURvLAST �
NEXT_COLOUR(C) = PACK_PoCOLOURvFIRST]

is separate;
�
open_scope "PACK_P.PLUS_ONE";
�CN
(4) �

procedure PLUS_FOUR (A : INTEGER; B : out INTEGER)

� B [true, B = A + 4]

is
begin
   B := A + 4;
end PLUS_FOUR;
�
�CN
(5) !�
PLUS_FOUR(X, L);
L := L - 3;
return L;
�

output_z_document{script="PACK_P'body", out_file="lit2.zdoc"};
output_ada_program{script="-", out_file="lit2.ada"};


new_script {name="PACK_P.SQRT", unit_type="proc"};

�CN
� procedure PACK_P.SQRT body �	(1)
�
�CN
(1) �

separate (PACK_P)
procedure SQRT (X : INTEGER; Y : out INTEGER)

� Y [X � 0, Y ** 2 � X < (Y + 1) ** 2]

is
   LO : INTEGER;

   � local vars �		(2)

begin
   LO := 0;

    � LO [X � 0 � LO = 0, LO ** 2 � X < (LO + 1) ** 2]

   Y := LO;
end SQRT;
�
�CN
(2) �

HI : INTEGER;
�
�CN
�
� LO, HI [X � 0 � LO = 0, LO ** 2 � X < (LO + 1) ** 2]
�
�CN
�

HI := X + 1;

$till �LO ** 2 � X < (LO + 1) ** 2�

loop

    � LO, HI [LO ** 2 � X < HI ** 2, LO ** 2 � X < HI ** 2]

end loop;
�
�CN
�

exit when LO + 1 = HI;

� LO, HI [LO ** 2 � X < HI ** 2, LO ** 2 � X < HI ** 2]
�

output_z_document{script="PACK_PoSQRT'proc", out_file="lit3.zdoc"};
output_ada_program{script="-", out_file="lit3.ada"};



new_script {name="PACK_P.NEXT_COLOUR", unit_type="func"};

�CN
separate (PACK_P)
function NEXT_COLOUR (C : COLOUR) return COLOUR
�
[true,
C � PACK_PoCOLOURvLAST �
NEXT_COLOUR(C) = PACK_PoCOLOURvSUCC(C)
�
C = PACK_PoCOLOURvLAST �
NEXT_COLOUR(C) = PACK_PoCOLOURvFIRST]

is
   C1 : COLOUR;
begin

  � C1
  [true,
  C � PACK_PoCOLOURvLAST �
  NEXT_COLOUR(C) = PACK_PoCOLOURvSUCC(C)
  �
  C = PACK_PoCOLOURvLAST �
  NEXT_COLOUR(C) = PACK_PoCOLOURvFIRST]

end NEXT_COLOUR;
�
�CN
�

C1 := C;
C1 := NEXT_COL(C1);
return C1;
�

output_z_document{script="PACK_PoNEXT_COLOUR'func", out_file="lit4.zdoc"};
output_ada_program{script="-", out_file="lit4.ada"};


diag_line "All module tests passed.";

