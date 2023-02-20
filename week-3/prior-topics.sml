(*
Generalizing Prior Topics

Our examples of first-class functions so far have all:
  - Taken one function as an argument to another function
  - Processed a number or a list

But first-class functions are useful anywhere for any kind of data
  - Can pass several functions as arguments
  - Can put functions in data structures (tuples, lists, etc.)
  - Can return functions as results
  - Can write higher-order functions that traverse your own data structures

Useful whenever you want to abstract over "what to compute with" functions
  - No new language features

Functions are first-class values
  - For example, can return them from functions

Silly example:
*)

(* (int -> bool) -> (int -> int) *)
fun double_or_triple f =
  if f 7
  then fn x => 2 * x
  else fn x => 3 * x

val double = double_or_triple (fn x => x - 3 = 4)
val nine = (double_or_triple (fn x => x = 42)) 3

(*
Higher-order functions are not just for numbers and lists

They work great for common recursive traversals over your own data structures (datatype bindings) too

Example of a higher-order predicate:
  - Are all constants in an arithmeetic expression even numbers

  - Use a more general function of type
    (int -> bool) * exp -> bool

  - And call it with (fn x => x mod 2 = 0)

*)

datatype exp = Contant of int
             | Negate of exp
             | Add of exp * exp
             | Multiply of exp * exp

(* (int -> bool) * exp -> bool *)
fun true_of_all_constant(f, e) =
  case e of
      Contant i => f i
    | Negate e1 => true_of_all_constant (f,e1)
    | Add (e1,e2) => true_of_all_constant (f,e1)
                        andalso true_of_all_constant (f,e2)
    | Multiply (e1,e2) => true_of_all_constant (f,e1)
                        andalso true_of_all_constant (f,e2)

(* exp -> bool *)
fun all_even e = true_of_all_constant((fn x => x mod 2 = 0),e)

