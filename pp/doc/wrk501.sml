
new_script {name="PRIMES", unit_type="proc"};

�Z
�	prime � { n : �1 | �(� i, j : �1 \ {1} � i * j = n)}
�
�Z
�	not_prime � �1 \ prime
�
�Z
�	rel     _ next_prime _
�
�ZAX
�	_ next_prime _ : �1 � �1
���������������������������
�	(_ next_prime _) =
�	{i, j : �1 | i � prime � j � prime � j>i � (i+1)..(j-1) � not_prime}
�
�Z
�	primed � {p : seq�1 �1 | p(1) = 2 �
�			(� i : dom p \ {1} � p(i-1) next_prime p(i))}
�
�CN
procedure primes is
subtype Indexrange is Integer range 1..1000;
type Arraytype is array (Indexrange) of Integer;
p : Arraytype;

� other declarations �				(1)
� other declarations �				(2)
� other declarations �				(3)

begin

� P [true, P � primed]

end primes;
�
�CN
(1) �

j, k : integer;
�
�Z
�	odd � {n : �1 | � i : �1 � n � 2 * i}
�
�Inv1�������������
�	P : ARRAYTYPE;
�	J, K : �
������
�	((1 .. K-1) � P) � primed;
�	J = P(K-1);
�	J � odd
�
�CN
� � J,K,P [true, Inv1 � K = 1001]
�
�CN
(2) �

ord, square : Integer;
ord_max : constant Integer := 30;
subtype mult_index_type is Integer range 2..ord_max;
type mult_type is array (mult_index_type) of Integer;
mult : mult_type;
�
� ord_inv�������������
�	P : ARRAYTYPE;
�	J, K, ORD, SQUARE : �
������
�	ORD > 1;
�	SQUARE = P(ORD) * P(ORD);
�	J < SQUARE;
�	ORD < K;
�	ORD = 2 � J � prime
�
�Z
�	rel     _ factor_of _
�
�ZAX
�	_ factor_of _ : �1 � �1
���������������������������
�	(_ factor_of _) =
�	{i, n : �1 | � j : 2..(n-1) � i * j = n}
�
� mult_inv�������������
�	P : ARRAYTYPE;
�	MULT : MULT_TYPE;
�	ORD, J : �
������
�	� n : 2..(ORD - 1) �
�	MULT(n) � odd �
�	P(n) factor_of MULT (n) �
�	(MULT(n) < J �
�		MULT(n) - 2 * P(n) < J � MULT(n))
�
�Z
�	Inv � ord_inv � mult_inv
�
�CN
�

p(1) := 2;
p(2) := 3;
j := 3;
k := 3;
ord := 2;
square := 9;

� J,K,P,ORD, SQUARE, MULT [Inv1 � Inv, Inv1 � Inv � K = 1001]
�
�CN
�

while k /= 1001
loop
	� J,K,P,ORD,SQUARE,MULT [Inv1 � Inv, Inv1 � Inv]
end loop;
�
� Inter1�������������
�	P : ARRAYTYPE;
�	J, K : �
������
�	((1 .. K - 1) � P) � primed;
�	P(K - 1) next_prime J;
�	J � odd
�
�CN
�

� J, ORD, SQUARE, MULT [Inv1 � Inv, Inter1 � Inv]
p(k) := j;
k := k+1;
�
�CN
�
$CON lastj : � � � J, ORD, SQUARE, MULT
	[lastj = J � Inv1 � Inv, lastj next_prime J � Inv]
�
� Inv2�������������
�	P : ARRAYTYPE;
�	J, K, lastj : �
������
�	lastj = P(K - 1);
�	J � lastj;
�	(lastj+1) .. (J-1) � not_prime;
�	((1..K-1) � P) � primed;
�	J � odd
�
�CN
�

$till �Inv2 � J > lastj � J � prime � Inv�
loop
	� J, ORD, SQUARE, MULT [Inv2 � Inv � (J � prime � lastj = J),
		Inv2 � Inv � J � prime]

end loop;
�
�CN
(3) �

jprime : Boolean;
�
�CN
�

	� J, ORD, SQUARE, MULT [Inv2 � Inv � (J � prime � lastj = J),
		Inv2 � Inv � J = J�0 + 2]
	� JPRIME, MULT [Inv2 � Inv � J > lastj,
		Inv2 � Inv � J > lastj � JPRIME = J mem prime]		(4)
exit when jprime;
�
�CN
�

j := j + 2;
if j = square
then
	ord := ord + 1;
	square := p(ord) * p(ord);
	mult (ord-1) := j;
end if;
�
�CN
(4) �

jprime := true;
� JPRIME, MULT [Inv2 � Inv � JPRIME = TRUE,
		Inv2 � Inv � JPRIME = J mem prime]
�
� Inv3�������������
�	P : ARRAYTYPE;
�	J, ORD, N : �;
�	JPRIME : BOOLEAN
������
�	N � 2..(ORD - 1);
�	� m : 2.. (N-1) � �(P(m) factor_of J);
�	JPRIME = TRUE;
�	J � odd
�
�CN
�

for n in Integer range 2 .. (ord - 1)
$till �P(N) factor_of J � JPRIME = FALSE � Inv�

loop
	� JPRIME, MULT [Inv3 � Inv,
			Inv3 � Inv � �(P(N) factor_of J)]
end loop;
�
�CN
�

� JPRIME, MULT [Inv3 � mult_inv, mult_inv � (P(N) factor_of J � JPRIME = FALSE)]

exit when not jprime;
�
�CN
�
� MULT[mult_inv, mult_inv � MULT (N) � J]
� JPRIME [mult_inv � MULT (N) � J,
		mult_inv � MULT (N) � J � JPRIME = MULT (N) noteq J]	(5)
�
�CN
�

while mult(n) < j
loop
	� MULT [mult_inv � MULT(N) < J, mult_inv]
end loop;
�
�CN
�

mult(n) := mult(n) + p(n) + p(n);
�
�CN
(5) �

jprime := mult(n) /= j;
�


output_z_document{script="PRIMES'proc", out_file="wrk501.zdoc"};
output_ada_program{script="-", out_file="wrk501.ada"};


val wrk501_browse =
	let val shvar = get_shell_var "PP_USE_VC_BROWSER"
	in	if shvar <> "" andalso shvar <> "NO" andalso shvar <> "no"
			andalso shvar <> "No"
		then browse_vcs() else ()
	end;
diag_line "All module tests passed";
