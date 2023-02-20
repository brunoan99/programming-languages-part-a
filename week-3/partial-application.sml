(* Partial Application *)

(*
Previously used currying to simulate multiple arguments

But if caller provides "too few" arguments, we get back a closure "waiting for the remaining arguments"
  - Called partial application
  - Convenient and useful
  - Can bee done with any curried function

No new semantics here: a pleasant idiom

*)

fun sorted3 x y z = z >= y andalso  y >= x

fun fold f acc xs =
  case xs of
      []      => acc
    | x'::xs' => fold f (f(acc,x)) xs'

val is_nonnegative = sorted3 0 0

fun is_nonnegative_inferior x = sorted3 0 0 x

val sum = fold (fn (x,y) => x+y) 0

fun sum_inferior xs = fold (fn (x,y) => x+y) 0 xs

fun range i j = if i > j then [] else i ::range(i+1) j
(* range 3 6 -> [3,4,5,6] *)

val contup = range 1
(* countup 6 -> [1,2,3,4,5,6] *)

fun contup_inferior x = range 1 x

fun exists predicate xs =
  case xs of
      [] => false
    | x'::xs' => predicate x' orelse exists predicate xs'

val no = exists (fn x => x=7) [4,11,23]

val hasZero = exists (fn x => x=0)

(*
Library functions foldlm List.filterm etc. also can be curried
*)

val incrementAll = List.map (fn x => x + 1)

val removeZeros = List.filter (fn x => x <> 0)


(*
The Value Restriction Appears

If you use partial application to create a polymorphic function, it may not work due to the value restriction
  -  Warning about "type vars not generalized"
    - And won't let you call the function

  - This should surprise; nothing wrong but must change the code

  - See the codee for workarounds
*)

(* Value Restriction appears:
val pairWithOne = List.map (fn x => (x, 1)) (* 'a list -> ('a int) list *)
*)

(* workarounds *)
fun pairWithOne xs = List.map (fn x => (x, 1)) xs

val pairWithOne' : string list -> (string * int) list = List.map (fn x => (x, 1))

(* this function works fine because result is not polymorphic *)
val incrementAndPairWithOne = List.map (fn x => (x+1,1))
