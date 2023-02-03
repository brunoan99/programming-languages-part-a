(*
Syntax:
  if e1 then e2 else e3
  where if, then and else are keywords and
  e1, e2, and e3 are subexpressions

Type-checking:
  First e1 must have type bool
  e2 and e3 can have any type (let's call it t),
  but they must have the same type t
  the type of the entire expression is also t

Evaluation:
  First evaluate e1 to a value call it v1
  If v1 it's true, evalueate e2 and that result is the whole expression's result
  Else, evalueate e3 and that result is the whole expression's result
*)
