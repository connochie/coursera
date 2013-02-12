
fun is_older (x:(int * int * int), y:(int * int * int)) = 
    (#1 x < #1 y)
    orelse (#1 x = #1 y andalso #2 x < #2 y)
    orelse (#1 x = #1 y andalso #2 x = #2 y andalso #3 x < #3 y)

fun number_in_month (dates:(int * int * int)list, month: int)=
    if null dates
    then 0
    else 
	let val counter = number_in_month(tl dates, month)
	in 
	    if  #2 (hd dates) = month
	    then counter + 1 
	    else counter
	end

fun number_in_months (dates:(int * int * int)list, months: int list)=
    if null months
    then 0
    else 
	let val counter = number_in_months(dates, tl months)
        in
           counter + number_in_month(dates, hd months)
	end					

fun dates_in_month (dates:(int * int * int)list, month: int)=
    if null dates
    then []
    else
	let fun date_in_month (date:(int * int * int))=
		if #2 date = month
                then [date]
		else []
        in
	    let val maybe = date_in_month(hd dates)
	    in
		if null maybe
		then dates_in_month(tl dates, month)
		else hd maybe :: dates_in_month(tl dates, month)
	    end
	end

fun dates_in_months (dates:(int * int * int)list, months: int list)=
    if null months
    then []
    else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth (strings: string list, n: int)=
    if n = 1
    then hd strings
    else 
	let fun nth (strings: string list, n: int, i: int)=
		if n = i
		then hd strings
		else nth (tl strings, n, i + 1) 
	in
	    nth (tl strings, n, 2)
	end

fun date_to_string (date: (int * int * int))=
    get_nth(
	["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"],
	#2 date
    ) ^ " " ^  Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
																       
fun number_before_reaching_sum (sum: int, l: int list)=
    let fun func (running: int, n: int, sub: int list)=
	    if running + hd sub > sum
            then n
	    else func (running + hd sub, n + 1, tl sub)
    in
	func(1, 0, l)
    end

fun what_month (day: int)=
    number_before_reaching_sum(day, [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]) + 1

fun month_range (day1: int, day2: int)=
    if day1 > day2
    then []
    else [what_month(day1)] @ month_range(day1 + 1, day2)

fun oldest (dates: (int * int * int) list)=
    if null dates
    then NONE
    else 
	let val tl_ans = oldest(tl dates)
	in
	    if isSome tl_ans andalso is_older(valOf tl_ans, hd dates)
	    then tl_ans
	    else SOME(hd dates)
	end

fun remove_duplicates (l: int list)=
    let fun contains (l: int list, i: int)=
	    if null l then false else
	    if hd l = i then true
	    else contains(tl l, i)
    in
	let fun rem (l: int list, ans: int list)=
		if null l then ans else
		if contains(ans, hd l)
	        then rem(tl l, ans)
		else rem(tl l, ans @ [hd l])
	in
	    rem(l, [])
	end
    end

fun number_in_months_challenge (dates:(int * int * int)list, months: int list)=
    number_in_months(dates, remove_duplicates months)

fun dates_in_months_challenge (dates:(int * int * int)list, months: int list)=
    dates_in_months(dates, remove_duplicates months)
