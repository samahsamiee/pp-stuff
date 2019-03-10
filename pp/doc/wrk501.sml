
new_script {name="PRIMES", unit_type="proc"};

πZ
‹	prime ¶ { n : Óâ1 | ≥(∂ i, j : Óâ1 \ {1} ∑ i * j = n)}
∞
πZ
‹	not_prime ¶ Óâ1 \ prime
∞
πZ
‹	rel     _ next_prime _
∞
πZAX
‹	_ next_prime _ : Óâ1 ™ Óâ1
˜¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸
‹	(_ next_prime _) =
‹	{i, j : Óâ1 | i ç prime ± j ç prime ± j>i ± (i+1)..(j-1) Ä not_prime}
∞
πZ
‹	primed ¶ {p : seqâ1 Óâ1 | p(1) = 2 ±
‹			(µ i : dom p \ {1} ∑ p(i-1) next_prime p(i))}
∞
πCN
procedure primes is
subtype Indexrange is Integer range 1..1000;
type Arraytype is array (Indexrange) of Integer;
p : Arraytype;

ß other declarations ¢				(1)
ß other declarations ¢				(2)
ß other declarations ¢				(3)

begin

Ñ P [true, P ç primed]

end primes;
∞
πCN
(1) È

j, k : integer;
∞
πZ
‹	odd ¶ {n : Óâ1 | µ i : Óâ1 ∑ n Ω 2 * i}
∞
ˇInv1¸¸¸¸¸¸¸¸¸¸¸¸¸
‹	P : ARRAYTYPE;
‹	J, K : ˙
˜¸¸¸¸¸
‹	((1 .. K-1) Ú P) ç primed;
‹	J = P(K-1);
‹	J ç odd
à
πCN
√ Ñ J,K,P [true, Inv1 ± K = 1001]
∞
πCN
(2) È

ord, square : Integer;
ord_max : constant Integer := 30;
subtype mult_index_type is Integer range 2..ord_max;
type mult_type is array (mult_index_type) of Integer;
mult : mult_type;
∞
ˇ ord_inv¸¸¸¸¸¸¸¸¸¸¸¸¸
‹	P : ARRAYTYPE;
‹	J, K, ORD, SQUARE : ˙
˜¸¸¸¸¸
‹	ORD > 1;
‹	SQUARE = P(ORD) * P(ORD);
‹	J < SQUARE;
‹	ORD < K;
‹	ORD = 2 ¥ J ç prime
à
πZ
‹	rel     _ factor_of _
∞
πZAX
‹	_ factor_of _ : Óâ1 ™ Óâ1
˜¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸¸
‹	(_ factor_of _) =
‹	{i, n : Óâ1 | ∂ j : 2..(n-1) ∑ i * j = n}
∞
ˇ mult_inv¸¸¸¸¸¸¸¸¸¸¸¸¸
‹	P : ARRAYTYPE;
‹	MULT : MULT_TYPE;
‹	ORD, J : ˙
˜¸¸¸¸¸
‹	µ n : 2..(ORD - 1) ∑
‹	MULT(n) ç odd ±
‹	P(n) factor_of MULT (n) ±
‹	(MULT(n) < J ≤
‹		MULT(n) - 2 * P(n) < J º MULT(n))
à
πZ
‹	Inv ¶ ord_inv ± mult_inv
∞
πCN
√

p(1) := 2;
p(2) := 3;
j := 3;
k := 3;
ord := 2;
square := 9;

Ñ J,K,P,ORD, SQUARE, MULT [Inv1 ± Inv, Inv1 ± Inv ± K = 1001]
∞
πCN
√

while k /= 1001
loop
	Ñ J,K,P,ORD,SQUARE,MULT [Inv1 ± Inv, Inv1 ± Inv]
end loop;
∞
ˇ Inter1¸¸¸¸¸¸¸¸¸¸¸¸¸
‹	P : ARRAYTYPE;
‹	J, K : ˙
˜¸¸¸¸¸
‹	((1 .. K - 1) Ú P) ç primed;
‹	P(K - 1) next_prime J;
‹	J ç odd
à
πCN
√

Ñ J, ORD, SQUARE, MULT [Inv1 ± Inv, Inter1 ± Inv]
p(k) := j;
k := k+1;
∞
πCN
√
$CON lastj : ˙ ∑ Ñ J, ORD, SQUARE, MULT
	[lastj = J ± Inv1 ± Inv, lastj next_prime J ± Inv]
∞
ˇ Inv2¸¸¸¸¸¸¸¸¸¸¸¸¸
‹	P : ARRAYTYPE;
‹	J, K, lastj : ˙
˜¸¸¸¸¸
‹	lastj = P(K - 1);
‹	J æ lastj;
‹	(lastj+1) .. (J-1) Ä not_prime;
‹	((1..K-1) Ú P) ç primed;
‹	J ç odd
à
πCN
√

$till ˚Inv2 ± J > lastj ± J ç prime ± Inv˝
loop
	Ñ J, ORD, SQUARE, MULT [Inv2 ± Inv ± (J ç prime ¥ lastj = J),
		Inv2 ± Inv ± J é prime]

end loop;
∞
πCN
(3) È

jprime : Boolean;
∞
πCN
√

	Ñ J, ORD, SQUARE, MULT [Inv2 ± Inv ± (J ç prime ¥ lastj = J),
		Inv2 ± Inv ± J = Jâ0 + 2]
	Ñ JPRIME, MULT [Inv2 ± Inv ± J > lastj,
		Inv2 ± Inv ± J > lastj ± JPRIME = J mem prime]		(4)
exit when jprime;
∞
πCN
√

j := j + 2;
if j = square
then
	ord := ord + 1;
	square := p(ord) * p(ord);
	mult (ord-1) := j;
end if;
∞
πCN
(4) √

jprime := true;
Ñ JPRIME, MULT [Inv2 ± Inv ± JPRIME = TRUE,
		Inv2 ± Inv ± JPRIME = J mem prime]
∞
ˇ Inv3¸¸¸¸¸¸¸¸¸¸¸¸¸
‹	P : ARRAYTYPE;
‹	J, ORD, N : ˙;
‹	JPRIME : BOOLEAN
˜¸¸¸¸¸
‹	N ç 2..(ORD - 1);
‹	µ m : 2.. (N-1) ∑ ≥(P(m) factor_of J);
‹	JPRIME = TRUE;
‹	J ç odd
à
πCN
√

for n in Integer range 2 .. (ord - 1)
$till ˚P(N) factor_of J ± JPRIME = FALSE ± Inv˝

loop
	Ñ JPRIME, MULT [Inv3 ± Inv,
			Inv3 ± Inv ± ≥(P(N) factor_of J)]
end loop;
∞
πCN
√

Ñ JPRIME, MULT [Inv3 ± mult_inv, mult_inv ± (P(N) factor_of J § JPRIME = FALSE)]

exit when not jprime;
∞
πCN
√
Ñ MULT[mult_inv, mult_inv ± MULT (N) æ J]
Ñ JPRIME [mult_inv ± MULT (N) æ J,
		mult_inv ± MULT (N) æ J ± JPRIME = MULT (N) noteq J]	(5)
∞
πCN
√

while mult(n) < j
loop
	Ñ MULT [mult_inv ± MULT(N) < J, mult_inv]
end loop;
∞
πCN
√

mult(n) := mult(n) + p(n) + p(n);
∞
πCN
(5) √

jprime := mult(n) /= j;
∞


output_z_document{script="PRIMES'proc", out_file="wrk501.zdoc"};
output_ada_program{script="-", out_file="wrk501.ada"};


val wrk501_browse =
	let val shvar = get_shell_var "PP_USE_VC_BROWSER"
	in	if shvar <> "" andalso shvar <> "NO" andalso shvar <> "no"
			andalso shvar <> "No"
		then browse_vcs() else ()
	end;
diag_line "All module tests passed";
