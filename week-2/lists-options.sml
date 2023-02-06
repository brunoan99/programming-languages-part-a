(*
Recursive datatypes

Datatype bindings can describe recursive structures
  - Have seen arithmetic expressions
  - Now, linked lists:
*)

datatype my_int_list = Empty
                     | Cons of int * my_int_list

val x = Cons (4, Const(23, Const(2008, Empty)))

fun append_my_list (xs, ys) =
  case xs of
      Empty => ys
    | Const (x, xs') => Cons(x, append_my_list(xs', ys))

(*
Options are datatypes

Options are just a predefined datatype bindinb
  - NONE and SOME are constructors, not just functions
  - So use pattern-matching not isSome and valOf
*)

fun inc_or_zero intoption =
  case intoption of
      NONE => 0
    | SOME i => i + 1

(*
List are datatypes

Do not use hd, tl, or null either
 - [] and :: are constructors too
 - (strange, syntax, particularly infix)
*)

fun sum_list xs =
  case xs of
      [] => 0
    | x::xs' => x + sum_list xs'

fun append (xs, ys) =
  case xs of
      [] => ys
    | x::xs' => x::append(xs', ys)

(*
Why pattern-matching

Pattern-matching is better for options and lists for the same reasons as for all datatypes
  - No missing cases, no exceptions for wrong variant, etc.

Do not use isSome, valOf, null , hd, tl.

So why are null, tl, etc. predefined?
  - For passing as arguiments to other functions
  - Because sometimes they are convenient
  - But not a big deal: could define them yourself
*)
