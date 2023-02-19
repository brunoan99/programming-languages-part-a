(*
Anonymous Functions
*)
fun n_times (f,n,x) =
  if n=0
  then x
  else f (n_times(f,n-1,x))

fun triple1 x = 3*x

fun triple_n_times1 (n,x) = n_times(triple(n,x))
(* in this case triple1 is only used by triple_n_times1, it doesnt makes a lot of sense to define triple1 in top-level*)

fun triple_n_times2 (n,x) =
  let
    fun triple2 x = 3*x
  in
    n_times(triple2,n,x)
  end
(* in this case triple2 is only used in a small scope, triple are only needed in n_times call *)

fun triple_n_times3 (n,x) =
  n_times(let fun triple3 x = 3*x in triple end,n,x)
(* this works, but its bad style cause sml have a better construct to this situations*)

fun triple_n_times4 (n,x) =
  n_times(fn x => 3*x,n,x)
(* in this case triple isnt define as a function binding, is just a expression

Using fn we can define expressions/anonymous functions
*)

(*


Syntax:
  fn (x1 : t1, ..., xn : tn) = e1

Most commom use: Argument to a higher-order function
  - Don't need a name just to pass a function

But: Cannot use an anonymous function for a recursive function
  - Because there is no name for making recursive calls
  - If not for recursion, fun bindings would be syntactic sugar for val bindings and anonymous functions
*)

fun triple_fun x = 3*x

val triple_val = fn y => 3 * y
(*
triple_fun its the same as triple_val
As long triple was not a recursive function *)
