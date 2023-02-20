(*
Lexical Scope

Very important concept

We know function bodies can use any bindings in scope

But now that functions can be passed around: In scope where?
  Where the function was defined (not where it was called)

This semantics is called lexical scope

There are lots of good for this semantics (why)
  - Discussed after explaining what the semantics is (what)
  - Later in course: implementation it (how)

Example:
*)

(* 1 *) val x = 1
        (*  x maps to 1 *)
(* 2 *) val f y = x + y
        (*  f maps to a function that adds 1 to its argument *)
(* 3 *) val x = 2
        (*  x maps to 2 *)
(* 4 *) val y = 3
        (*  y maps to 3 *)
(* 5 *) val z = f (x + y)
        (*  call the function defined on line 2 with 5,
            cause x maps to 2 and y mapts to 3 *)
        (*  z maps to 6 *)

(*
Closures

How can functions be evaluated in old environments that aren't around anymore?
  - The language implementation keeps them around as necessary

Can define the semantics of functions as follows:
  - A function value has two parts
    - The code (obvioulsy)
    - Then environment that was current when the function was defined
  - This is a "pair" but unlike ML pairs, you cannot access the pieces
  - All you can do is call this "pair"
  - This pair is called a function closure
  - A call evaluates the code part in the environment part (extended with the function argument)
*)
