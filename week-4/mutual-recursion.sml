(* Mutual Recursion *)

(*
Allow f to call g and g to call f

Useful?
  - Implementing state machines

The problem: ML's bindings-in-order rule for environment
  - Fix #1: Special new language construct
  - Fix #2: Workaround using higher-order functions

*)

(*
New language features - Fix #1

Mutually recursive function (the and keyword)

  fun f1 p1 = e1
  and f2 p2 = e2
  and f3 p3 = e3

- Each function defined in this mutually recursive functions can call each other, all added to the environment for all of the others.

Similarly, mutually recursive datatype bindings

  datatype t1 = ...
      and t2 = ...
      and t3 = ...

Everything in "mutual recursion bundle" type-check together and can refer to each other
*)

(* State-machine example

Each "state of the computation" is a function
  - "State transition" is "call another function" with "rest of input"
  - Generalizes to any finite-state-machine example

  fun state1 input_left = ...

  and state2 input_left = ...

  and ...
*)
(* Process a list starting with 1 and ending with 2, all 1's need to be followed by 2 and all 2's need to be followed by 1 except the last. *)
fun match xs = (* [1,2,1,2,1,2] -> true | [1,2,2] -> false | [1,2,1] -> false *)
  let fun s_need_one xs =
          case xs of
              [] => true
            | 1::xs' => s_need_two xs'
            | _ => false
      and s_need_two xs =
          case xs of
              [] => false
            | 2::xs' => s_need_one xs'
            | _ => false
  in
    s_need_one xs
  end

datatype t1 = Foo of int | Bar of t2
and t2 = Baz of string | Quux of t1

fun no_zeros_or_empty_strings_t1 x =
  case x of
      Foo i => i <> 0
    | Bar y => no_zeros_or_empty_strings_t2 y
and no_zeros_or_empty_strings_t2 x =
  case x of
      Baz s => String.size s > 0
    | Quux y => no_zeros_or_empty_strings_t1 y

(*
The above code uses special mutual recursion definition to let two functions call each other
*)

(* Using higher-order function - Fix #2

This second way uses higher-order functions to leet two functions call each other, cause in moment of function1 definition it don't need the definition of the function2 than function2 can be defined lately and function1 call with function2 as argument.

This works but using built-in mutual recursion definition is a better style and provide more efficient implementation.
*)

fun no_zeros_or_empty_strings_t1_alternate(f,x) =
  case x of
      Foo i => i <> 0
    | Bar y => f y

fun no_zeros_or_empty_strings_t2_alternate x =
  case x of
      Baz s => String.size s > 0
    | Quux y => no_zeros_or_empty_strings_t1_alternate(
                  no_zeros_or_empty_strings_t2_alternate, y)

(*
Suppose we did not have support for mutually recursive functions
  - Or could not put functions next to each other

Can have the "later" function pass itself to the "earlier" one
  - Yet another higher-order function idiom

Like done above

  fun earlier (f, x) = ... f y ...

  ...

  fun later x = ... earlier(later,y) ...

*)
