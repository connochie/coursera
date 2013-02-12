(* Coursera Programming Languages, Homework 3, Provided Code *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => r p + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

fun only_capitals (l: string list)=
    List.filter((fn s => Char.isUpper(String.sub(s, 0)))) l

fun longest_string1 (l: string list)=
    foldl (fn (x,y) => if String.size x > String.size y then x else y) "" l

fun longest_string2 (l: string list)=
    foldl (fn (x,y) => if String.size x >= String.size y then x else y) "" l

fun longest_string_helper (z: int * int -> bool) (l: string list)=
    foldl (fn (x,y) => if z(String.size x, String.size y) then x else y) "" l

val longest_string3 = longest_string_helper (fn (x,y) => x > y)

val longest_string4 = longest_string_helper (fn (x,y) => x >= y)

val longest_capitalized = (longest_string3 o only_capitals)

val rev_string = String.implode o rev o String.explode

fun first_answer f s =
    case s of
	[] => raise NoAnswer
      | s1::s2 => case f s1 of
		     NONE => first_answer f s2
		   | SOME t => t 
	   
fun all_answers f a =
    let fun aux (b, acc)=
	    case b of
		[] => if null acc then SOME [] else SOME acc 
	      | b1::b2 =>  case f b1 of
			      NONE => NONE
			    | SOME l => aux(b2, acc @ l)  
    in
	aux(a,[])
    end

fun count_wildcards x = g (fn x => 1) (fn y => 0) x

fun count_wild_and_variable_lengths x = g (fn x => 1) (fn y => String.size y) x

fun count_some_var (s,p) = g (fn x => 0) (fn y => if y=s then 1 else 0) p 

fun check_pat p = 
    let fun vars (p: pattern, acc: string list) =
	    case p of
		Variable v => v::acc
	      | TupleP ps => List.foldl (fn (p,i) => vars(p,i)) acc ps
	      | ConstructorP(_,p) => vars(p,acc)
	      | _ => acc
	fun dup (s: string list)=
	    case s of
		[] => false
	      | x::xs => (List.exists (fn y => x = y) xs) orelse (dup xs) 
    in
	not(dup(vars(p,[])))
    end


fun match (v: valu, p: pattern)=
    case (v,p) of
	(v, Wildcard) => SOME[]
      | (v, Variable s)  => SOME[(s,v)]
      | (c, UnitP) => (case c of Unit => SOME[] | _ => NONE)
      | (Const c, ConstP c') => if c = c' then SOME[] else NONE 
      | (Tuple vs, TupleP ps) => if List.length vs = List.length ps
				 then all_answers match (ListPair.zip(vs,ps))
				 else NONE 
      | (Constructor(s1,v), ConstructorP(s2,p)) => if s1 = s2 then match(v,p) else NONE
      | _ => NONE


fun first_match v ps=
    let fun merge (v,ps,a)=
	    case ps of
		[] => a
	      | p::ps' => merge(v,ps',(v,p)::a) 
    in
	SOME(first_answer match (merge(v,ps,[]))) handle NoAnswer => NONE
    end
