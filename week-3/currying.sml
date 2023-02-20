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
    | x'::xs' => fold f (f(acc,x')) xs'

fun sum xs = fold (fn (x, y) => x+y) 0 xs

(* Currying Wrapup *)

(*
More combining fuctions

- What if you want to curry a tupled function or vice versa?
- What if a function's argument are in the wrong order for the partial application you want?

Naturally, it is easy to write higher-order wrapper functions
  - And their types are neat logical formuals
*)

(* ('a -> 'b -> 'c) -> 'b -> 'a -> 'c *)
fun other_curry1 f = fn x => fn y => f y x

(* ('a -> 'b -> 'c) -> 'b -> 'a -> 'c *)
fun other_curry2 f x y = f y x

(* ('a * 'b -> 'c) -> 'a -> 'b -> 'c *)
fun curry f x y = f (x,y)

(* ('a -> 'b -> 'c) -> 'a * 'b -> 'c *)
fun uncurry f (x, y) = f x y

fun range (i,j) = if i > j then [] else i::range(i+1,j)

(* val contup = range 1 does not work (yet) *)

val contup = curry range 1

val xs = contup 7 (* -> [1,2,3,4,5,6,7] *)

(*
So which is faster: tupling or currying multiple-arguments?

- They are both constant-time operations, so it doesn't matter in most of your code - "plenty fast"
  - Don't program against an implementation until it matters!

- For the smal (zero?) part where efficiency matter:
  - It turns out SML/NJ compiles tuples more efficiently
  - But many other functiona-languiages implementations do better with currying (OCaml, F#, Haskell)
    - So currying is the "normal thing" and programmers read t1 -> t2 -> t3 -> t4 as a 3-argument function that also allows partial application

*)
