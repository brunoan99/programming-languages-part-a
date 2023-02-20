(*
Lexical Scope and Higher-Order Functions

The rule staus the same

A function body is evaluated in the environment where the function was defined
  - Extended with the function argument

Nothing changes to this rule when we take and return functions
  - But "the environment" may involve nested let-expressions not just the top-level sequence of bindings

Makes first-class functions much more powerful
  - Eveen if may seem counterintuitive at first
*)

(* First example *)
val x = 1 (* irrelevant *)

fun f y =
  let
    val x = y + 1
  in
    fn z => x + y + z (* take z and return 2y + 1 + z*)
  end

val x = 3 (* irrelevant *)

val g = f 4 (* return a function that adds 9 to its argument *)

val y = 5 (* irrelevant *)

val z = g 6 (* z maps to 15 *)

(* Second example *)
fun f' g' =
  let
    val x' = 3 (* irrelevant *)
  in
    g' 2
  end

val x' = 4 (* x maps to 4 *)

fun h' y' = x' + y' (* h maps to a function that adds 4 to its argument *)

val z' = f' h' (* z maps to 6 *)
