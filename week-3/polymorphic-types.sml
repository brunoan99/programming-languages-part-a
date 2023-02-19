(*
The key point

- Higher-order functions aree often so "generic" and "reusable" that they have polymorphic types, i.e., types with type variables
- But there are higher-order functions that are not polymorphic
- And there are non-higher-order functions that are polymorphic
- Always a good idea to understand the type of a function, especially a high-order functions

Types
*)

fun n_times (f, n, x) =
  if n=0
  then x
  else f (n_times(f,n-1,x))
(*
val n_times : ('a -> 'a) * int * 'a -> 'a
  - Simpler but less useful: (int -> int) * int * int -> int

Type is infeerred based on how arguments are used
  - Describes which types must be exactly something (e.g., int) and which can be anything but the same (e.g., 'a)
*)

(* (int -> int) * int -> int *)
fun times_until_zero (f, x) =
  if x = 0 then 0 else 1 + times_until_zero(f, f x)
(* x is compared to zero than it only can be a int *)
(* f takes x as argument, and the result of this will be applied to this function recursivily than it only can be a (int -> int) *)


(* 'a list -> int *)
fun len ([]) = 0
  | len ([_,xs']) = 1 + len xs'
(* its a polymorphic function that are not higher-order*)
