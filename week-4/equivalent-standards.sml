(* Standard Equivalences *)

(* Syntatic sugar

Using or not using syntatic sugar is always equivalent
  - By definition, else not syntatic sugar

*)

fun f x = x andalso g x
(* = *)
fun f x = if x then g x else false

(*
But be careful about evaluation order
*)

fun f x = x andalso g x
(* != *)
fun f x = if g x then x else false

(*
Three general equivalences that always work for functions

1. Consistently rename bound variables and uses
*)

val y=14
fun f x = x+y+x
(*=*)
val y = 14
fun f z = z+y+z

(*
But notice you can't use a variable name already used in the function body to refer to something eelse
*)

val y = 14
fun f x = x+y+x
(*!=*)
val y = 14
fun f y = y+y+y

fun f x = let val y = 3 in x + y end
(*!=*)
fun f y = let val y = 3 in y + y end

(*
2. Use a helper function or do not
*)

val y = 14
fun g z = (z+y+z) + z
(*=*)
val y = 14
fun f x = x+y+x
fun g z = (f z) + z

(*
But notice you need to be careful about environments
*)

val y =14
val y = 7
fun g z = (z+y+z) + z
(*!=*)
val y = 14
fun f x = x+y+x
val y = 7
fun g z = (f z) + z

(*
3. Unnecessary function wrapping
*)

fun f x = x+x
fun g y = f y
(*=*)
fun f x = x+x
fun g = f

(*
But notice that if you compute the function to call and that computation has side-effects, you have to be careful
*)

fun f x = x+x
fun h () = (print "hi"; f)
fun g y = (h()) y
(*!=*)
fun f x = x+x
fun h () = (print "hi"; f)
fun g = (h())

(*
If we ignore types, the ML let-bindings can be syntatic sugar for calling an anonymous function:

  let val x = e1
  in e2 end

  (fn x => e2) e1

  - These both evaluate e1 to v1, then evaluate e2 in an environment extended to map x to v1
  - So exactly the same evaluation of expression and result

But in ML is a type-system difference:
  - x on the left can have a polymorphic type, but not on the right
  - Can always go from right to left
  - If x need not to be polymorphic, can go from left to right
*)
