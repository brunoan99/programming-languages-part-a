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

(*
How ML do Type Inference

Will describe ML type inference via several examples
  - General algorithm is a slightly more advanced topic
  - Support nested functions also a bit more advanced

Enough to help "do type inference in head"


Key Steps

- Determine types of bindings in order
  - Except for mutual recursion
  - So you cannot use later bindings: will not type-check

- For each val or fun binding
  - Analyze definition for all necessary facts (constraints)
  - Example: if see 'x > 0' then 'x' must have type int
  - Type error if no way for all facts to hold (over-constrained)

- Afterward, use type variables (e.g., 'a) for any unconstrained types
  - Example: An unused argument can have any type

- Finally, enforce the value restriction

Example:
*)

val x = 42 (* val x : int *)

fun f (y, z, w) =
  if y (* y must be bool *)
  then z + x (* z must be int, because x is an int *)
  else 0 (* both branches have same type *)
(* f must return an int
   f must take a bool * int * ANYTHING
   so val f : bool * int * 'a -> int *)

(*
Relation to Polymorphism

- Central feature of ML type inference: it can infer types with type variables
  - Great for code reuse and understanding functions

- But remember there are two orthogonal conceepts
  - Languages can have type inference without type variables
  - Languages can have type variables without type inference
*)
