use "hw3.sml";

val capitals = ["texas","London","manchester","Sydney","perth","florida"];
print "\nonly_capitals\n";
only_capitals capitals = ["London","Sydney"];

val strings = ["short","longer","longest1","short","longest2","long"];
print "\nlongest_string1\n";
longest_string1 strings = "longest1";

print "\nlongest_string2\n";
longest_string2 strings = "longest2";

print "\nlongest_string3\n";
longest_string3 strings = longest_string1 strings;

print "\nlongest_string4\n";
longest_string4 strings = longest_string2 strings;

print "\nlongest_capitalized\n";
longest_capitalized capitals = "London";

print "\nrev_string\n";
rev_string "steven" = "nevets";


fun is_even x =
    if x mod 2 = 0 then SOME([x]) else NONE;

print "\nfirst_answer\n";
val first_answer_test1 = first_answer is_even [1, 2, 3, 4, 5, 6] = [2];
val first_answer_test2 = (first_answer is_even [1, 3, 5] handle NoAnswer => [0]) = [0];
val first_answer_test3 = first_answer is_even [1, 3, 5, 6] = [6];
val first_answer_test4 = (first_answer is_even [] handle NoAnswer => [0]) = [0];

print "\nall_answers\n";
val all_answers_test1 = all_answers is_even [1, 2, 3, 4, 5, 6] = NONE;
val all_answers_test2 = all_answers is_even [2, 4, 6] = SOME ([2, 4, 6]);
val all_answers_test3 = all_answers is_even [] = SOME ([]);

print "\ncount_wildcards\n";
val count_wildcards_test1 = count_wildcards(TupleP([Wildcard, ConstructorP("a", Wildcard), Variable("z"), Wildcard])) = 3;

print "\ncount_wild_and_variable_lengths\n";
val count_wild_and_variable_lengths_test1 = 
count_wild_and_variable_lengths(
    TupleP([Wildcard, Variable("steve"), ConstructorP("a", Wildcard), Variable("abc")])
) = 10 ;

print "\ncount_some_var\n";
val count_some_var_test1 = 
count_some_var(
    "steve",
    TupleP([Variable("steve"), Wildcard, Variable("steve"), ConstructorP("a", Wildcard), Variable("abc"), Variable("steve")])
) = 3; 

print "\ncheck_pat\n";
val check_pat_test1 = 
check_pat(
    TupleP([Variable("steve"), Wildcard, Variable("alpha"), ConstructorP("a", Wildcard), Variable("beta"), Variable("theta")])
) = true;
val check_pat_test2 = 
check_pat(
    TupleP([Variable("steve"), Wildcard, Variable("alpha"), ConstructorP("a", Wildcard), Variable("steve"), Variable("theta")])
) = false;

print "\nmatch\n";
val match_test_wildcard_1 = match( Const 7, Wildcard ) = SOME [];
val match_test_wildcard_2 = match( Unit, Wildcard ) = SOME [];
val match_test_wildcard_3 = match( Tuple[Const 7], Wildcard ) = SOME [];
val match_test_wildcard_4 = match( Constructor( "ABC", Const 7 ), Wildcard ) = SOME [];
val match_test_variable_1 = match( Const 7, Variable "A" ) = SOME [("A", Const 7)];
val match_test_variable_2 = match( Unit, Variable "sName" ) = SOME [("sName", Unit)];
val match_test_unitp_1 = match( Unit, UnitP ) = SOME [];
val match_test_unitp_2 = match( Const 7, UnitP ) = NONE;
val match_test_const_1 = match( Const 7, ConstP 7 ) = SOME [];
val match_test_const_2 = match( Const 7, ConstP 8 ) = NONE;
val match_test_constructor_1 = match( Constructor("ABC", Const 7), ConstructorP( "ABC", Wildcard ) ) = SOME[];
val match_test_constructor_2 = match( Constructor("AB", Const 7), ConstructorP( "ABC", Wildcard ) ) = NONE;
val match_test_constructor_3 = match( Constructor("ABC", Const 7), ConstructorP( "ABC", UnitP ) ) = NONE;
val match_test_constructor_4 = match( Constructor("ABC", Const 7), ConstructorP( "ABC", Variable "bbba" ) ) = SOME [("bbba",Const 7)];
val match_test_tuple_1 = match( Tuple[Const 7], TupleP[ConstP 7] ) = SOME [];
val match_test_tuple_2 = match( Tuple[Const 7], TupleP[ConstP 7,ConstP 7] ) = NONE;
val match_test_tuple_3 = match( Tuple[Const 7, Const 6, Unit, Const 8], TupleP[ConstP 7, Variable "ba", Wildcard, ConstP 8] ) 
			 = SOME [("ba",Const 6)];
val match_test_tuple_4 = match( Tuple[Const 7, Const 6, Unit, Const 7], TupleP[Variable "a", Variable "ba", Variable "bba", Variable "bbba"] )
			 = SOME [("a",Const 7),("ba",Const 6),("bba",Unit),("bbba",Const 7)];
val match_test2_1 = match(Tuple [Const 4, Unit], TupleP [ConstP 4, Variable "a"]) =  SOME [("a", Unit)];
val match_test2_2 = match(Tuple [Const 3, Unit], TupleP [ConstP 4, Variable "a"]) = NONE;
val match_test2_3 = match(Constructor("abc" , Const 1), ConstructorP("abc", ConstP 1)) = SOME [];
val match_test2_4 = match(Constructor("DEF" , Const 1), ConstructorP("abc", ConstP 1)) = NONE;
val match_test2_5 = match(Tuple [Const 1, Constructor("foo", Const 2), Tuple [Unit, Unit]], TupleP [Variable "a", Variable "b", Variable "c"])
		    = SOME [ ("a", Const 1), ("b", Constructor("foo", Const 2)), ("c", Tuple [Unit, Unit]) ];

