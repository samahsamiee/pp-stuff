structure SlrpDriver = struct
open EfficientDictionary;
type STATE = int;
type STATE_STACK = STATE list;
datatype ('tok, 'lc, 'pp) INPUT_STACK_ITEM = Token of 'tok * 'lc | Parsed of 'pp;
type('tok, 'lc, 'pp) INPUT_STACK = ('tok, 'lc, 'pp) INPUT_STACK_ITEM list;
datatype ACTION	= Shift of STATE
			| Reduce of ((string * int) * int)
			| Dynamic of STATE * ((string * int) * int)
			| Accept
			| Error;
type ('lc)ACTION_TABLE =  ('lc * ACTION) list PPArray.array;
type GOTO_TABLE = (string * STATE) list PPArray.array;
type ('tok, 'lc, 'pp)REDUCTION_TABLE =
	(('tok, 'lc, 'pp)INPUT_STACK -> 'pp) Array.array E_DICT;
datatype RESOLUTION	= DoShift
			| DoReduce
			| DoError;
type ('tok, 'lc, 'pp)RESOLVER =
	('tok * 'lc) * ('tok, 'lc, 'pp)INPUT_STACK * ((string * int) * int) -> RESOLUTION;
type ('tok, 'lc)CLASSIFIER = 'tok -> 'lc;
type ('tok, 'lc, 'pp, 'st)ERROR_ROUTINE =
	'tok * ('tok, 'lc, 'pp)INPUT_STACK * STATE_STACK * 'st -> ('tok*'st * int);
type ('tok, 'st)READER = 'st -> ('tok * 'st);
exception SYNTAX_ERROR;
exception PARSER_ERROR of string;
local
	fun get_action (actions : (''lc)ACTION_TABLE) (s:STATE) (lc:''lc) : ACTION = (
	(let	open PPArray
	in	lassoc3 (sub(actions, s)) lc
	end	handle Fail _ => Error)
	handle PPArray.Subscript => raise PARSER_ERROR "invalid state"
	);
in	fun lookup_action
		(resolver : ('tok, ''lc, 'pp)RESOLVER)
		(actions : (''lc)ACTION_TABLE)
		(tok : 'tok)
		(stk : ('tok, ''lc, 'pp)INPUT_STACK)
		(s : STATE)
		(lc : ''lc) : ACTION = (
		case get_action actions s lc of
			Dynamic (s', altsymn) => (
				case resolver((tok, lc), stk, altsymn) of
					DoShift => Shift s'
				|	DoReduce => Reduce altsymn
				|	DoError => Error
			) |	easy => easy
	);
end;
fun lookup_goto (gotos : GOTO_TABLE) (s:STATE) (nt : string) : STATE = (
	(let	open PPArray
	in	force_value (s_lookup nt (sub(gotos, s)))
	end	handle Fail _ => raise PARSER_ERROR "invalid non-terminal")
	handle PPArray.Subscript => raise PARSER_ERROR "invalid state"

);
fun lookup_reducer (reducers : ('tok, ''lc, 'pp)REDUCTION_TABLE)
		(nt:string) (alt : int) : ('tok, ''lc, 'pp)INPUT_STACK -> 'pp = (
	(case e_lookup nt reducers of
		Value tab => Array.sub(tab, alt)
	|	Nil  => raise PARSER_ERROR "invalid non-terminal")
	handle PPArray.Subscript => raise PARSER_ERROR "invalid alternative"
);
fun slrp'parse
	(s0 : STATE)
	(actions : (''lc)ACTION_TABLE)
	(gotos : GOTO_TABLE)
	(reducers : ('tok, ''lc, 'pp)REDUCTION_TABLE)
	(resolver : ('tok, ''lc, 'pp) RESOLVER)
	(classify : ('tok, ''lc)CLASSIFIER)
	(error : ('tok, ''lc, 'pp, 'st)ERROR_ROUTINE)
	(reader : ('tok, 'st) READER) : 'st -> 'pp = (
	let	open PPArray;
		val init_ss = [s0];
		val init_is = [];
		fun next st = (
			let	val (tok, st') = reader st;
			in	(classify tok, tok, st')
			end
		);
		val fetch_action = lookup_action resolver actions;
		val fetch_reducer = lookup_reducer reducers;
		val fetch_goto = lookup_goto gotos;
		fun go (x as (lc, tok, st)) = (fn (ss, is) =>
			let	val s = hd ss;
			in	case fetch_action tok is s lc of
					Shift s' => go (next st)((s' :: ss), Token(tok, lc) :: is)
				|	Reduce((nt, alt), r) => (
						let	val reducer = fetch_reducer nt alt;
							val A = reducer is;
							val ss' = ss from r;
							val is' = is from r;
							val s' = fetch_goto (hd ss') nt;
						in go x (s' :: ss', Parsed A :: is')
						end
				) |	Accept => ((ss, is)
				) |	Error =>(
						let	val (tok', st', n) = error(tok, is, ss, st);
							val ss' = ss from n;
							val is' = is from n;
						in	case ss' of
								_::_ => go (classify tok', tok', st') (ss', is')
							|	[] =>
								raise PARSER_ERROR
								"error recovery failed"
						end
				) |	Dynamic _ => (
					raise PARSER_ERROR "conflict resolution error"
				)
			end
		);
	in
		(fn st => (
			case go (next st) (init_ss, init_is)of
				(_, [Parsed res]) => res
			|	_ => raise PARSER_ERROR "stacks corrupt at end of parse"))
	end
);
fun format_stack (do_tok : 'tok -> string)(stk : ('tok, 'lc, 'pp)INPUT_STACK) : string = (
	format_list (fn Token (tk, _) => do_tok tk | _ => "...") (rev stk) " "
);
fun default_error
	(do_tok : 'tok -> string)
	(tok: 'tok, stk : ('tok, 'lc, 'pp)INPUT_STACK, _ : STATE_STACK, st : 'st) : ('tok*'st*int) = (
	raw_diag_line("*** ERROR Syntax error ***");
	if any stk (fn Token _ => true | _ => false)
	then raw_diag_line(do_tok tok ^ " not expected after: " ^ format_stack do_tok stk)
	else raw_diag_line(do_tok tok ^ " not expected here");
	raise SYNTAX_ERROR
);
val (default_resolver : ('tok, 'lc, 'pp)RESOLVER) = (fn _ =>
	raise PARSER_ERROR "shift/reduce conflict"
);
fun simple_resolver (prec : (('tok * 'lc) * ('tok * 'lc)) -> RESOLUTION)
		: ('tok, 'lc, 'pp)RESOLVER = (fn (toklc, stk, ignored) =>
	case stk of
		Token toklc' :: _ => prec (toklc', toklc)
	|	_ :: more => simple_resolver prec (toklc, more, ignored)
	|	[] => DoError
);
end; (* of structure SlrpDriver *)
