(*
Tuples and lists

So far: numbers, booleans, conditionals, variables, functions
  - Now ways to build up data with multiple parts
  - This is essential
  - Java examples: classes with fields, arrays

Tuples: fixed "number of pieces" that may have different types

Lists: any "number of pieces" that may have the same type

*)

(*
Pairs (2-tuples)

Need a way to build pairs and a way to access the pices

Build:
  Syntax:
    (e1, e2)

  Evaluation:
    Evaluate e1 to v1 and e2 to v2
    Result is (v1, v2)
    - A pair of values is a value

  Type-checking:
    If e1 has type ta and e2 has type tb, then
    the pair expression has type ta * tb
    - A new kind of type

Access:
  Syntax:
    #1 e (* return first part of the pair *)
    #2 e (* return second part of the pair *)

  Evaluation:
    Evaluate e to a pair of values and return first or second piece
    Example:
      If e is a variable x, then look up x in environment

  Type-checking:
    If e has type ta * tb
    Then #1 e has type ta and #2 e has type tb
*)

(* (int * bool) -> (bool * int) *)
fun swap (pair: int * bool) =
  (#2 pair, #1 pair)

(* (int * int) * (int * int) -> int *)
fun sum_two_pairs (pair1 : int * int, pair2 : int * int) =
  (#1 pair1) + (#2 pair1) + (#1 pair2) + (#2 pair2)

(* (int * int) -> (int * int) *)
fun div_mod (x : int, y : int) =
  (x div y, x mod y)

(* (int * int) -> (int * int) *)
fun sort_pair(pair: int * int) =
  if (#1 pair) < (#2 pair)
  then pair
  else (#2 pair, #1 pair)

(*
Tuples

Actually, you can have tuples with more than two parts
  - A new feature: a generalization of pairs

(e1, e2, ..., en)
ta * tb * ... * tn
#1 e, #2 e, ... #n e

Nesting

Pairs and tuples can be nested however you want
  - Not a new feature: implied by the syntax and semantics
*)

val x1 = (7, (true, 9)) (* int * (bool * int) *)

val x2 = #1 (#2 x1) (* bool *)

val x3 = (#2 x1) (* bool * int *)

val x4 = ((3, 5), ((4, 8), (0, 0)))
        (* (int * int) * ((int * int) * (int * int)) *)

val x = (3, (4, (5, 6)))
(*  #1 x -> 3
    #2 x -> (4, (5, 6)) *)


(* val y = (#2 x, (#1 x, #2 (#2 x ))) *)
val y = ((4, (5, 6)), (3, (5, 6)))

val ans = ((3, (5, 6)), 4)
