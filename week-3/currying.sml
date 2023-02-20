(* Currying *)

(*
Recall every ML function takes exactly one argument

Previously encoded n arguments via one n-tuple

Another way: Take one argument and return a function that takes another argument and...
  Called "currying" after famous logician Haskell Curry
*)

(* int * int * int -> bool *)
fun sorted3_tuple (x,y,z) = z >= y andalso y >= x

val t1 = sorted3_tuple (7,9,11) (* -> true *)

(* new way: currying *)

(* int -> int -> int -> bool *)
val sorted3 = fn x => fn y => fn z => z >= z andalso y >= x

val t2 = ((sorted3 7) 9) 11 (* -> true *)

(*
Calling (sorted3 7) returns a closure with
  - Code fn y => fn z => z >= y andalso y >= x
  - Environment maps x to 7

Calling that closure with 9 return a closure with
  - Code fn z => z >= y andalso y >= x
  - Environment maps x to 7, y to 9

Callint that closure with 11 return true

In geenral, e1 e2 e3 e4 ...,
means (...((e1 e2) e3) e4)

So instead of ((sorted3 7)9) 11
can just write sorted3 7 9 11

Callers can just think "multi-argument function with spaces instead of a tuple expression"
  - Different than tupling; callser and calle must use same technique
*)

val t3 = sorted3 7 9 11 (* -> true *)

(*
sorted3_tuple has only one way to bel call with a tuple, instead of it sorted3 can be called with both ways like t2 and t3
*)

fun sorted3_nicer x y z = z >= y andalso y >= x
(* syntatic sugar to sorted3 = fn x => fn y => fn z => z >= z andalso y >= x *)

val t4 = sorted3_nicer 7 9 11 (* -> true *)
val t5 = ((sorted3_nicer 7)9)11 (* -> true *)

(* fold version using currying *)
fun fold f acc xs =
  case xs of
      []      => acc
    | x'::xs' => fold f (f(acc,x)) xs'

fun sum xs = fold (fn (x, y) => x+y) 0 xs
