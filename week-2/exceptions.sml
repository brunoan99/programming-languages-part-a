(*
Exceptions
*)

fun hd xs =
  case xs of
      []   => raise List.Empty
    | x::_ => x

exception MyUndesirableCondition

exception MyOtherException of int * int

fun mydiv (x, y) =
  if y = 0
  then raise MyUndesirableCondition
  else x div y

(* int list * exn -> int *)
fun maxlist (xs, ex) =
  case xs of
      [] => raise ex
    | x::[] => x
    | x::xs' => Int.max(x, maxlist(xs', ex))

val w = maxlist([3,4,5], MyUndesirableCondition)
(* w -> 5 *)

val x = maxlist([3,4,5], MyUndesirableCondition)
        handle MyUndesirableCondition => 42
(* x -> 5

val y = maxlist([], MyUndesirableCondition) -> this will raise MyUndesirableCondition *)

val z = maxlist([], MyUndesirableCondition)
        handle MyUndesirableCondition => 42
(* z -> 42 *)

(*
Exceptions

An exception binding introduces a new kind of exception
  expception MyFirstException
  exception MySecondException of int * int

The raise primitive raises (a.k.a. throws) an exception
  raise MyFirstException
  raise (MySecondException(1,2))

A handle expression can handle (a.k.a. catch) an exception
  - If doesn't match, exception continues to propagate
  e1 handle MyFirstException => e2
  e1 handle MySecondException(x,y) => e2

Exceptions are a lot like datatype constructors
  - Declaring a exception makes adds a constructor for type exn
  - Can pass values of exn anywhere (e.g., function arguments)
    - Not too common to do this but can be useful
  - Handle can have multiple branches with patterns for type exn

*)
