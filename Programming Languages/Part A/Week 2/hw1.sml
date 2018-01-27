fun is_older (a : (int*int*int), b : (int*int*int)) =
  (#1 a < #1 b)
  orelse (#1 a = #1 b andalso #2 a < #2 b)
  orelse (#1 a = #1 b andalso #2 a = #2 b andalso #3 a < #3 b)

fun number_in_month (dates : (int*int*int) list, month : int) =
  if null dates
  then 0
  else
      let val tl_ans =  number_in_month(tl dates, month)
      in
	  if (#2 (hd dates)) = month
	  then 1 + tl_ans
	  else tl_ans
      end
	  
fun number_in_months (dates : (int*int*int) list, months : int list) =
  if null months
  then 0
  else number_in_month(dates, hd months) + number_in_months(dates, tl months)

fun dates_in_month (dates : (int*int*int) list, month : int) =
  if null dates
  then []
  else
      let val tl_ans =  dates_in_month(tl dates, month)
      in
	  if (#2 (hd dates)) = month
	  then (hd dates)::tl_ans
	  else tl_ans
      end

fun dates_in_months (dates : (int*int*int) list, months : int list) =
  if null months
  then []
  else dates_in_month(dates, hd months) @ dates_in_months(dates, tl months)

fun get_nth (sl : string list, n : int) =
  if n = 1
  then hd sl
  else get_nth(tl sl, n - 1)

fun date_to_string (date : (int*int*int)) =
  let val month_names = ["January", "February", "March", "April", "May", "June",
			 "July", "August", "September", "October", "November", "December"]
  in
      get_nth(month_names, #2 date) ^ " " ^ Int.toString(#3 date) ^ ", " ^ Int.toString(#1 date)
  end
      
fun number_before_reaching_sum (sum : int, numbers : int list ) =
  if hd numbers >= sum
  then 0
  else 1 + number_before_reaching_sum(sum - hd numbers, tl numbers)

fun what_month (day_of_year : int) =
  let val month_days = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
  in
      number_before_reaching_sum(day_of_year, month_days) + 1
  end

fun month_range (day1 : int, day2 : int) =
  if day1 > day2
  then []
  else what_month(day1)::month_range(day1 + 1, day2)

fun oldest (dates : (int*int*int) list) =
  if null dates
  then NONE
  else
      let
	  fun oldest_nonempty (dates: (int*int*int) list) =
	    if null (tl dates)
	    then hd dates
	    else let val tl_ans = oldest_nonempty(tl dates)
		 in
		     if is_older(hd dates, tl_ans)
		     then hd dates
		     else tl_ans
		 end
      in
	  SOME (oldest_nonempty dates)
      end

(* Challenge Problems *)
fun duplicate(n : int, numbers : int list) =
  if null numbers
  then false
  else
      if n = hd numbers
      then true
      else duplicate(n, tl numbers)
		    
fun remove_duplicates(numbers : int list) =
  if null numbers
  then []
  else
      let val tl_ans = remove_duplicates(tl numbers)
      in
	  if duplicate(hd numbers, tl_ans)
	  then tl_ans
	  else hd numbers::tl_ans
      end

fun number_in_months_challenge (dates : (int*int*int) list, months : int list) =
  number_in_months(dates, remove_duplicates(months))

fun dates_in_months_challenge (dates : (int*int*int) list, months : int list) =
  dates_in_months(dates, remove_duplicates(months))

fun reasonable_date (date : int*int*int) = 
  let    
      val y = #1 date
      val m = #2 date
      val d = #3 date
      fun is_leap_year (year : int) =
	year mod 400 = 0 orelse (year mod 100 <> 0 andalso year mod 4 = 0)
  in
      y > 0 andalso (
      (duplicate(m, [1,3,5,7,8,10,12]) andalso d <= 31)
      orelse (duplicate(m, [4,6,9,11]) andalso d <= 30)
      orelse (m = 2 andalso (if is_leap_year(y) then d <= 29 else d <= 28)))
  end
      
