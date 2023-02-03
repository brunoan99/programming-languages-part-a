(*
Let Efficiency
*)

(* return [from, from+1, ..., to] *)
fun countup(from : int, to : int) =
  if from = to
  then to :: []
  else from :: countup (from + 1, to)

(* return [from, from-1, ..., to] *)
fun countdown(from : int, to : int) =
  if from = to
  then to :: []
  else from :: countdown (from - 1, to)

fun bad_max (xs : int list) =
  if null xs
  then 0
  else if null (tl xs)
  then hd xs
  else if hd xs > bad_max (tl xs)
  then hd xs
  else bad_max (tl xs)

(*
This function is bad cause it repeat some important part of the code

The call to bad_max (tl xs) is the most unusual call that is done in the execution and its beeing done twice

This will add exponential time to function execution in cenarios that the max number are close to the end of the list.

To prevent the code to execute the function twice and twice and twice for each recursion, using a let expression to store the call and use it to define the result
*)

fun good_max (xs : int list) =
  if null xs
  then 0
  else if null (tl xs)
  then hd xs
  else
    let val tl_ans = good_max (tl xs)
    in
      if hd xs > tl_ans
      then hd xs
      else tl_ans
    end

fun better_max (xs : int list) =
  if null xs
  then 0
  else
    let
      val tail = tl xs
      val head = hd xs
    in
      if null tail
      then head
      else
        let
          val tail_ans = good_max tail
        in
          if head > tail_ans
          then head
          else tail_ans
        end
    end
