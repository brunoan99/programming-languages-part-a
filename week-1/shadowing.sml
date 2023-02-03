(*
Multiple bindings of same variable

Multiple variable bindings of the same variable is often poor style
  - Often confusing


But it's an instructive exercice
  - Helps explain how the environment "works"
  - Helps explain how a variable binding "works"
*)

val a = 10

(*  a : int
    a -> 10 *)

val b = a * 2
(*  a : int, b : int
    a --> 10, b --> 20 *)

val a = 5 (* this is not an assignment statement *)
(*  a : int, b : int
    a --> 5, b --> 20 *)

val c = b
(*  a : int, b : int, c : int
    a --> 5, b -> 20, c --> 20 *)

val d = a
(*  a : int, b : int, c : int, d : int
    a --> 5, b -> 20, c --> 20, d --> 5 *)

val a = a + 1 (* this is not an assignment statement *)
(*  a : int, b : int, c : int, d : int
    a --> 6, b -> 20, c --> 20, d --> 5 *)

(* val g = f - 3 this will return a error cause f is not in environment *)
(* Error: unbound variable or constructor: f *)

(* When renning this on REPL
[openning shadowing.sml]
val a = <hidden> : int
val b = 20 : int
val a = <hidden> : int
val c = 20 : int
val d = 5 : int
val a = 6 : int
val it = () : unit
*)

(*
Two reasons (either one sufficient)

val a = 1
val b = a (* b is bound to 1 *)
val a = 2

1. Expressions in variable bindings are evaluated "eagerly"
  - Before the variable binding "finishes"
  - Afterwards, the expression producing the value is irrelevant

2. There is no way to "assign to" a variable in ML
  - Can only shadow it in a later environment
*)
