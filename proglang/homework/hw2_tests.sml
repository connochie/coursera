use "hw2.sml";

val options = ["r","s","t", "steven", "james", "dan"];
print "all_except_option\n";
all_except_option("r", options) = SOME ["s","t","steven","james","dan"];
all_except_option("s", options) = SOME ["r","t","steven","james","dan"];
all_except_option("nope", options) = NONE;
all_except_option("james", options) = SOME ["r","s","t","steven","dan"];
all_except_option("dan", options) = SOME ["r","s","t","steven","james"];

val subs1 = [["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]];
val subs2 = [["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]];
print "get_substitutions1\n";
get_substitutions1(subs1,"Fred") = ["Fredrick","Freddie","F"];
get_substitutions1(subs2,"Jeff") = ["Jeffrey","Geoff","Jeffrey"];

print "get_substitutions2\n";
get_substitutions2([],"Steven") = [];
get_substitutions2([["Steve","Steven","Stevie"]],"Steven") = ["Steve","Stevie"];
get_substitutions2(subs1,"Fred") = get_substitutions1(subs1,"Fred");
get_substitutions2(subs2,"Jeff") = get_substitutions1(subs2,"Jeff");

print "similar_names\n";
similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) 
= [{first="Fred", last="Smith", middle="W"},{first="Fredrick", last="Smith", middle="W"},
   {first="Freddie", last="Smith", middle="W"},{first="F", last="Smith", middle="W"}];

print "all_same_color\n";
all_same_color([(Spades,Jack),(Spades,Ace),(Hearts,Queen),(Clubs,King)]) = false;
all_same_color([(Spades,Jack),(Spades,Ace),(Clubs,King)]) = true;

val cards = [(Spades,Jack),(Spades,Ace),(Clubs,King),(Clubs,Num 1)];
val cards2 = [(Hearts,Num 2),(Spades,Ace),(Hearts, Num 5),(Hearts,King),(Hearts,Jack)];

print "sum_cards\n";
sum_cards((Hearts,Queen)::cards) = 42;

print "score\n";
score((Hearts,Queen)::cards, 30) = 36;
score((Hearts,Queen)::cards, 42) = 0;
score((Clubs,Queen)::cards, 30) = 18;

val moves = [Draw,Draw,Discard(Spades,Ace),Draw,Draw];

print "officiate\n";
officiate(cards,moves,42);
officiate(cards2,moves @ moves,42);
officiate([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],[Draw,Draw,Draw,Draw,Draw],42) = 3;
(officiate([(Clubs,Jack),(Spades,Num(8))],[Draw,Discard(Hearts,Jack)],42) handle IllegalMove => ~1) = ~1;

print "score_challenge\n";
score_challenge((Clubs,Queen)::cards, 30);

print "officiate_challenge\n";
officiate_challenge(cards,moves,42);
officiate_challenge(cards2,moves @ moves,42);
officiate_challenge([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],[Draw,Draw,Draw,Draw,Draw],42) = 3;
(officiate_challenge([(Clubs,Jack),(Spades,Num(8))],[Draw,Discard(Hearts,Jack)],42) handle IllegalMove => ~1) = ~1;
