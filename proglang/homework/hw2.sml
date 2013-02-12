(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* put your solutions for problem 1 here *)

fun all_except_option(s:string, lst:string list)=
   case lst of
       [] => NONE
    |  l::[] => if same_string(s,l) then SOME([]) else NONE
    |  l::(m::n) => case same_string(s,l) of
			true => SOME(m::n)
		     |  false => case same_string(s,m) of
				     true => SOME(l::n)
				  |  false => case all_except_option(s, m::n) of
						  NONE => NONE
						| SOME m' => SOME(l::m')
			      
fun get_substitutions1(substitutions:string list list, s:string)=
    case substitutions of
	[] => []
      | l::[] => (case all_except_option(s, l) of
		     NONE => []
		   | SOME l' => l')
      | l::(m::n)  => get_substitutions1(l::[], s) @ get_substitutions1(m::n, s)
  
fun get_substitutions2(substitutions:string list list, s:string)=
    let fun aux(substitutions: string list list, acc: string list)=
	    case substitutions of
		[] => acc
	      | subs::[] => (case all_except_option(s, subs) of
				       NONE => acc
				     | SOME t => acc @ t)		  
	      | s1::s2::s3  => aux(s2::s3, case all_except_option(s, s1) of
					      NONE => acc 
					    | SOME t => acc @ t)
    in
	aux(substitutions, [])
    end

fun similar_names(substitutions: string list list, name: {first:string, middle:string, last:string})=
    let fun aux(substitutions: string list, acc: {first:string, middle:string, last:string} list)=
	 case substitutions of
	     [] => acc
	   | f::[] => (case name of
			  {first,middle,last} => acc @ [{first=f, middle=middle, last=last}])
	   | f::(f'::r) => aux(f'::r, (case name of
			  {first,middle,last} => acc @ [{first=f, middle=middle, last=last}]))
    in
	case name of
	    {first, middle, last} => aux(get_substitutions2(substitutions, first), [name])
    end

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(* put your solutions for problem 2 here *)

fun card_color(card: card)=
    case card of
	(suit, rank) => case suit of
			    Clubs => Black
			 | Spades => Black
			 | _ => Red 

fun card_value(card: card)=
    case card of 
	(suit, rank) => case rank of
			    Num n => n
			  | Ace => 11
			  | _ => 10
    
fun remove_card(cs: card list, c: card, e: exn)=
    let fun next(cs: card list)=
	    case cs of
		[] => []
		   | cs'::[] => if cs'=c then [] else cs
		   | c1::(c2::c3) => if c1=c then c2::c3 else c1::next(c2::c3) 
    in 
	let val removed = next(cs)
	in
	    if removed=cs then raise e else removed
	end
    end

fun all_same_color(cs: card list)=
    case cs of
	c::(c1::c2) => card_color(c) = card_color(c1) andalso all_same_color(c1::c2)
      | _ => true 

fun sum_cards(cs: card list)=
    let fun aux(cs: card list, acc: int)=
	    case cs of
		[] => acc
	      | c::[] => acc + card_value(c)
	      | c::(c1::c2) => aux(c1::c2, acc + card_value(c))
    in aux(cs, 0)
    end 

fun score(cs: card list, goal: int)=
    let val sum = sum_cards(cs)
    in
	let val prelim = if sum > goal then 3*(sum-goal) else goal-sum
	in
	    if all_same_color(cs) then prelim div 2 else prelim
	end
    end

fun officiate(cs: card list, moves: move list, goal: int)=
    let fun aux(cs: card list, moves: move list, held: card list)=
	    case moves of
		[] => score(held, goal)
		   | mv::mv' => case mv of
				    Discard d => aux(cs,mv',remove_card(held,d,IllegalMove))
				  | Draw => case cs of
						[] => score(held, goal)
					      | c::c' => if sum_cards(c::held) > goal
							 then score(c::held, goal)
						         else aux(c',mv',c::held)
    in
	aux(cs, moves, [])
    end

(* challenge helper functions *)

        fun count(cs: card list, acc: int)=
	    case cs of
		[] => acc
	      | c::c' => count(c', 1 + acc)
 
	fun remove_aces(cs: card list)=
	    case cs of
		[] => []
	      | c::c1 => case card_value(c) of
			     11 => remove_aces(c1)
			   | _ => c :: remove_aces(c1) 

	fun sums(s:int, a:int, r: int list, i: int)=
	    if i < a
	    then sums(s,a,(s+(a*(i+1))+(i*10))::r,i+1)
	    else r

	fun score2(cs: card list, c: int, goal: int)=
	    let val prelim = if c > goal then 3*(c-goal) else goal-c
	    in	
		if all_same_color(cs) then prelim div 2 else prelim
	    end

	fun lowest_score(cs: card list, s: int list, goal: int)=
	    let fun aux(s: int list, r: int)=
		    case s of
			[] => r
		      | s1::s2 => let val s1' = score2(cs, s1, goal)
				  in
				      if r = ~1 
				      then aux(s2, s1') 
				      else aux(s2, if s1' < r then s1' else r)  
				  end
	    in
		aux(s, ~1)
	    end

	fun get_sums(cs: card list)=
	        let val sans_aces = remove_aces(cs)
		    val sum_sans_aces = sum_cards(sans_aces)			       
		    val aces_count = count(cs, 0) - count(sans_aces,0)
		in
		    sums(sum_sans_aces, aces_count, [], 0)
		end

	fun lowest_sum(cs: card list)=
	    let fun aux(sums: int list, l: int)=
		case sums of
		    [] => l
		  | c1::c2 => if l = ~1 
			      then aux(c2, c1)
			      else aux(c2, if c1 < l then c1 else l)
	    in
		aux(get_sums(cs), ~1)
	    end

(* end challenge helper functions *)

fun score_challenge(cs: card list, goal: int)=
    lowest_score(cs, get_sums(cs), goal)

fun officiate_challenge(cs: card list, moves: move list, goal: int)=
    let fun aux(cs: card list, moves: move list, held: card list)=
	    case moves of
		[] => score(held, goal)
	      | mv::mv' => case mv of
			       Discard d => aux(cs,mv',remove_card(held,d,IllegalMove))
			     | Draw => case cs of
					   [] => score_challenge(held, goal)
					 | c::c' => if lowest_sum(c::held) > goal
						    then score_challenge(c::held, goal)
						    else aux(c',mv',c::held)
    in
	aux(cs, moves, [])
    end
