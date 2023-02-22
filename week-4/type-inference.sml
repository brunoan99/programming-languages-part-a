(* Type Inference *)

(*
(Static) type-checking can reject a program before it runs to preevent the possibility of some errors
  - A feature of statically typed languages

Dynamically typed languages do little (none!) such checking
  - So might try to treat a number as a function at run-time

ML is statically typed
  - Every binding has one type, determined "at compile-time"

ML is implicitly typed: rarely need to write down types

*)
fun f x = (* infer val f : int -> int*)
  if x > 3
  then 42
  else x * 2

(*
fun g x = (* report type error *)
  if x > 3
  then true
  else x * 2

then branch and else branch needs to be the same type to type-check a if expression. And this condition isnt true in this example.
*)

(*
Type inference problem: Give every binding/expression a type such that type-checking succeeds
  - Fail if and only if no solution exists

In principle, could be a pass before the type-checker
  - But often implemented together

Type inference can be easy, difficultm or impossible
  - Easy: Accept all programs
  - Easy: Reject all programs
  - Subtle, elegant, and not magic: ML



*)

