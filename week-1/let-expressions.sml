(*
Let expressions

The big thing we need: local bindings
  - For style and convenience

This segment:
  - Basic let-expressions

The construct to introduce local bindings is just an expression, so we can use it anywhere an expression can go.

Syntax:
  let b1 b2 ... bn in e end
  Where let, in and end are keywords
  Each bi is binding and e is any expression

Type-checking:
  Type-check each bi and e in a static environment that includes the previous bindings.
  Type of whole let-expression is the type of e.

Evaluation:
  Evaluate each bi and e in a dynamic environment that includes the previous bindings.
  Result of whole let-expressions is result of evaluating e.
*)

fun silly1 (z: int) =
  let
    val x = if z > 0 then z else 34
    val y = x + z + 9
  in
    if x > y then x * 2 else y * y
  end

fun silly2 () =
  let
    val x = 1
  in
    (* x = 2 in x + 1 -> 2 + 1 -> 3 *)
    (let val x = 2 in x + 1 end ) +
    (* x = 1, y = 1 + 2 -> y = 3 in y + 1 -> 3 + 1 -> 4 *)
    (let val y = x + 2 in y + 1 end)
    (* 3 + 4 -> 7 *)
  end

(* silly2() -> 7 *)

fun silly3 () =
  let
    val x = (let val x = 5 in x + 10 end);
  in
    (x,
    let val x = 2 in x end,
    let val x = 10 in let val x = 2 in x end end)
  end

(*
Scope

What's new is scope: where a binding is in the environment
  In later bindings and body of the let expressions
    Unless a later or nested binding shadows it

  Only in later bindings and body of the let expression
*)
