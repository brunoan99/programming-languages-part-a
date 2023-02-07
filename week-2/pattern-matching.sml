(*
Pattern Matching So Far

*)

datatype t = C1 of t1 | C2 of t2 | ... | Cn of tn

(*
Adds type t and constructor Ci of type ti -> t
  - Ci v is a value, i.e., the result "includes the tag"

Omit "of t" for constructors that are just tags, no underyling data
  - Such a Ci is a value of type t

Given an expression of type t, use case expressions to:
  - See which variant (tag) it has
  - Extract underlying data once you know which variant
*)

(*

case e of p1 => e1 | p2 => e2 | ... | pn => en

An usual, can use a case expression anywhere an expression goes
  - Does not need to be whole function body, but often is

Evaluate e to a value, call it v

If pi is the first pattern to match v, then result is evaluation of ei in environment "extended by the match"

Patter Ci (x1, ..., xn) matches value Ci (v1, ..., vn) and extends the environment with x1 to v1 ... xn to vn
  - For "no data" constructors, pattern Ci matches value Ci
*)

(*
An exciting segment

Learn some deep thuths about "what is really going on"
  - Using much more syntactic sugar than we realized

- Every val-binding and function-binding uses pattern-matching

- Every function in ML takes exactly one argument
*)

(*
Each-of types

So far have used pattern-matching for one of types because we needed a way to acces the values

Pattern matching also works for records and tuples:
  - The pattern (x1, ..., xn)
    matches the tuple value (v1, ..., vn)
  - The pattern {f1=x1, ..., fn=xn}
    matches the record value {f1=v1, ..., fn=vn}
    (and fields can be reordered)


Example:
  This is poor style, works but poor style to have one-branch cases, only for demonstration purposes
*)
fun sum_triple triple =
  case triple of
    (x, y, z) => x + y + z

fun full_name r =
  case r of
    {first=x, middle=y, last=z} => x ^ " " ^ y ^ " " ^ z

(*
Val-binding patterns

New feature: A val-binding can use a pattern, not just a variable
  - (Turns out variables are just on e kind of pattern)
    val p = e

Great for getting (all) pieces out of an each-of  type
  - Can also get only parts out

Usually poor style to put a constructor patter nin a val-binding
  - Tests for the one variant and raises and exception if a different one is there (like hd, tl and valOf)


This is okay style
  - Though we will improve it again next
  - Semantically identical to one-branch case expressions
*)

fun sum_triple2 triple =
  let val (x, y, z) = triple
  in
    x + y + z
  end

fun full_name2 r =
  let val {first=x, middle=y, last=z} = r
  in
    x ^ " " ^ y ^ " " ^ z
  end

(*
Function-argument patterns

A function argument can also be a pattern
  - Match agains the argument in a function call

Examples (great style!):
*)
fun sum_triple3 (x, y, z) =
  x + y + z

fun full_name {first=x, middle=y, last=z} =
  x ^ " " ^ y ^ " " ^ z

(* A function that takes one triple of type int * int * int and return an int that is their sum: *)
fun sum_triple (x, y, z) =
  x + y + z

(* A function that takes three int arguments and return an int that is their sum: *)
fun sum_triple (x, y, z) =
  x + y + z

(*
There are no difference between the two functions.

In SML every function takes one parameter and uses patter-matching to assing variables defined in the function
scope. Example:
*)
fun hello () = print "Hello World!\n"
(*
In this case, the argument is of type unit and () is a pattern match the only value of type unit.

That we call multi-argument function are just functions taking one tuple argument, implemented with a tuple pattern in the function binding
  - Elegant and flexible language desing

Enables cute and useful things you cannot do in Java, e.g.
*)
fun rotate_left (x, y, z) = (y, z, x)
fun rotate_right t = rotate_left(rotate_left t)

(*"Zero arguments" is the unit pattern () matching the unit value () *)
