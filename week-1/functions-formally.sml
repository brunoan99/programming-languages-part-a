(*
Function

Syntax:
  fun x0 (x1 : t1, ..., xn : tn) = e

Evaltuation:
  A function is a value! (No evaluation yet)
  Adds x0 to environment so later expressions can call it
  (AFunction-call semantics will also allow recursion)

Type-checking:
  Adds binding x0 : (t1 * ... t*n ) -> t if:
  Can type-check body e to have type t in the static environment containing:
    - "Enclosing" static environment      (earlier bindings)
    - x1 : t1, ..., xn : tn               (arguments with their types)
    - x0 : (t1 * ... * tn) -> t           (for recursion)

  New kind of type: (t1 * ... tn) -> t
    - Result type on right
    - The overall type-checking result is to give x0 thios type in rest of program
    - Arguments can be used only in e

  Because evaluation of a call to x0 will return result of evaluating e,
  the return type of x0 is the type of e

  The type-checker "magically" figures out t if such a t exists
*)

(*
Function calls

Syntax:
  e0 (e1, ..., en)
    Parentheses optional if there is exactly one argument

Type-checking:
  If:
    - e0 has tome type (t1 * ... * tn ) -> t
    - e1 has type t1, ..., en has type tn
  Then:
    - e0 (e1, ..., en) has type t

Evaluation:
  1. (Under current dynamic environment) evaluate e0 to a function
  fun x0 (x1 : t1, ..., xn : tn) = e
    - Since call type-checked, result will be a function

  2. (Under current dynamic environment) evaluate arguments to values v1, ..., vn

  3. Result is evaluation of e in a environment extended to map x1 to v1, ..., xn to vn
    - ("An environment" is actually the environment where the function was defined,
       and includes x0 for recursion)
*)
