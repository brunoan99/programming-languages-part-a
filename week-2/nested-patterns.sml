(*

Nested patterns

We can nest patterns as deep as we want
  - Just like we can nest expressions as deep as we want
  - Often avoids hard-to-read, wordy ensted case expressions

So the full meaning of pattern-matching is to compare a pattern against a value for the "same shape" and bind variables  to the "right parts"

Without nested pattern matching
*)

exception ListLengthMismatch

fun old_zip3 (l1, l2, l3) =
  if null l1 andalso null l2 andalso null l3
  then []
  else if null l1 orelse null l2 orelse null l3
  then raise ListLengthMismatch
  else (hd l1, hd l2, hd l3) :: old_zip3(tl l1, tl l2, tl l3)

fun shallow_zip3 (l1, l2, l3) =
  case l1 of
      [] =>
      (case l2 of
            [] =>
            (case l3 of
                  [] => []
                | _ => raise ListLengthMismatch)
          | _ => raise ListLengthMismatch)
    | hd1::tl1 =>
      (case l2 of
            [] => raise ListLengthMismatch
          | hd2::tl2 =>
            (case l3 of
                  [] => raise ListLengthMismatch
                | hd3::tl3 =>
                  (hd1, hd2, hd3)::shallow_zip3(tl1,tl2,tl3)))

(*
Both solutions are awful in terms of readability.
Without using nested pattern matching the function extends to much in each case expression.
*)

fun zip3 list_triple =
  case list_triple of
      ([], [], []) => []
    | (hd1::tl1,hd2::tl2,hd3::tl3) => (hd1, hd2, hd3)::zip3(tl1,tl2,tl3)
    | _ => raise ListLengthMismatch

fun unzip3 lst =
  case lst of
      [] => ([], [], [])
    | (a,b,c)::tl =>
      let val (l1, l2, l3) = unzip3 tl
      in
        (a::l1, b::l2, c::l3)
      end
    | _ => raise ListLengthMismatch

(*
With nested pattern matching the functions works the same but in terms of readability is clearly shorter and easier to understand what each piece of code do.
*)
