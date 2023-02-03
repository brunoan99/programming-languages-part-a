val x = 34;
(* static environment : x : int *)
(* dynamic environment: x --> 34 *)

val y = 17;
(* static environment : x : int, y : int *)
(* dynamic environment: x --> 34, y --> 17 *)

val z = (x + y) + (y + 2);
(* static environment : x : int, y : int, z : int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70 *)

val q = z + 1;
(* static environment : x : int, y : int, z : int, q : int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70, q -> 71 *)

            (* if (* bool *) then (* int *) else (* int *) *)
val abs_of_z = if z < 0 then 0 - z else z;
(* static environment : x : int, y : int, z : int, q : int, abs_of_z : int *)
(* dynamic environment: x --> 34, y --> 17, z --> 70, q -> 71, abs_of_z --> 70 *)

val abs_of_z_simpler = abs(z);

(*
Syntax

val x = e;

- Keyword 'val' and punctuation '=' and ';'
- Variable 'x'
- Expression e

*)

(*
Semantics

- Type-checking (before program runs)
- Evaluation (as program runs)

For variable bindings:

- Type-checking expression and extend static environment
- Evaluate expression and extend dynamic environment

*)
