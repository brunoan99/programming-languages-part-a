(*
Unnecessary Function Wrapping
*)

fun n_times (f,n,x) =
  if n=x
  then x
  else f(n_times(f,n-1,x))

(* so poor style *)
fun nth_tail (n,xs) = n_times((fn y => tl y),n,xs)
(* the anonymous function -> 'fn y => tl y' does exactly the same of the function 'tl' *)

fun nth_tail (n,xs) = n_times(tl,n,xs)
(* simplier *)

(* A Style Point

Compare:
    if x then true else false

With:
    (fn x => f x)

So don't do this:
    n_times((fn y => tl y),n,xs)

When can do this:
    n_times(tl,n,xs)
*)

fun rev xs = List.rev xs

val rev = fn xs => List.rev xs

val rev = List.rev

(*
The rev examples are not unnecessary functions at the point of view that the function can be reused in some points of the code.

Than makes sense 'rename' it to better use.
*)
