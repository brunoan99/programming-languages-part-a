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

(*
With nested pattern matching the functions works the same but in terms of readability is clearly shorter and easier to understand what each piece of code do.
*)

(*
Another example
The function nondecreasing will check if the function isn't decreasing the numbers
This example dont use nested pattern matching
*)
fun nondecreasing xs = (* int list -> bool *)
  case xs of
      [] => true
    | x::xs' =>
      case xs' of
        [] => true
      | y::ys' => x <= y andalso nondecreasing xs'

(* using nested pattern matching *)
fun nondecreasing xs = (* int list -> bool *)
  case xs of
      [] => true
    | _::[] => true
    | head::neck::tail => head <= neck
                          andalso nondecreasing (neck::tail)

datatype sgn = P | N | Z

fun multsign (x1, x2) = (* int * int -> sgn *)
  let fun sign x = if x=0 then Z else if x>0 then P else N
  in
    case (sign x1, sign x2) of
        (Z,_) => Z
      | (_,Z) => Z
      | (P,P) => P
      | (N,N) => P
      | (P,N) => N
      | (N,P) => N
    (*
    or instead of using explicit the last 2 patterns is possible to use the pattern:
      | _ => N
    *)
  end

fun multsign2 (x1, x2) = (* int * int -> sgn *)
  let fun sign x = if x=0 then Z else if x>0 then P else N
  in
    case (sign x1, sign x2) of
        (Z,_) => Z
      | (_,Z) => Z
      | (x,y) => if x = y then P else N
  end

fun len xs =
  case xs of
      [] => 0
    | _::xs' => 1 + len xs'

(*
Style

Nested patterns can lead to very elegant, concise code
  - Avoid nested case expressions if nested patterns are simpler and avoid unnecessary branches or let-expressions
    Example: unizp3 and nondecreasing
  - A common idiom is matching against a tuple of datatype to compare them
    Example: zip3 and multsign

Wildcards are good style: use them instead of variables when you do not need the data
 - Examples: len and multsign

*)

(*
(Most of) the full definition

The semantics for pattern-matching takes a pattern p and a value v and decides (1) does it match and (2) if so, what variable bindings are introduced.

Sice patterns can nest, the definition is elegantly recursive, with a separate rule for each kind of pattern. Some of the rules:
- If p is a variable x,
    the match succeeds and x is bound to v
- If p is _,
    the match succeeds and no bindings are introduced
- If p is (p1, ..., pn) and v is (v1, ..., vn),
    the match succeeds if and only if p1 matches v1, ..., pn matches vn. The bindings are the union of all bindings from the submatches
- If p is C p1,
    the match succeeeds if v is C v1 (i.e., the same constructor) and p1 matches v1. The bindings are the bindings from the submatch.
- ... (there are severral other similar forms of patterns)
*)

(*
Examples:

- Pattern a::b::c::d matches all list with >= 3 elemnts
    Supposing the pattern is being applied to a type 'a list then,
    the a, b and c will be type 'a and d will be 'a list. d can be a empty list.

- Pattern a::b::c::[] matches all list with 3 elemnts
    Supposing the pattern is being applied to a type 'a list then,
    the a, b and c will be type 'a.

- Pattern ((a,b), (c,d))::e matches all non-empty list of pairs of pairs
    Supposing the pattern is being applied to a type ('a * 'b) * ('c * 'd) list then,
    a will be type 'a, b will be type 'b, c will be type 'c and d will be type 'd.

*)
