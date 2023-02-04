(*
Options

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

(*
This function will return 0 to cases when recive a empty list

This could not be good, cause 0 is a valid value to the function return, and cause 0 does not represent
that the list was no max.

Having max return 0 for the empty list is really awful
  - Could raise an exception
  - Could return a zero-element or one-element list
    - That works but is poor style because the built-in support for options expresses this situation directly
*)

(*
t option is a type for any type t
  - (much like t list, but a different type, not a list)

Building:
  - NONE has type 'a option (much like [] has type 'a list)
  - SOME e has type t option if e has type t (much like e::[])

Accessing:
  - isSome has type 'a option -> bool (true if is SOME and false for NONE)
  - valOf has type 'a option -> 'a (exception is given NONE)
*)

fun max1 (xs : int list) =
  if null xs
  then NONE
  else
    let
      val tl_ans = max1 (tl xs)
      val head = hd xs
    in
      if isSome tl_ans andalso valOf tl_ans > head
      then tl_ans
      else SOME head
    end

fun max2 (xs : int list) =
  if null xs
  then NONE
  else
    let
      fun max_nonempty (xs : int list) =
        if null (tl xs)
        then hd xs
        else
          let
            val tl_ans = max_nonempty (tl xs)
          in
            if hd xs > tl_ans
            then hd xs
            else tl_ans
          end
    in
      SOME (max_nonempty xs)
    end
