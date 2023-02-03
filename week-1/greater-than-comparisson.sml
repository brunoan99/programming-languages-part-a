(*
Syntax:
  e1 > e2
  where e1 and e2 are expressions

Type-checking:
  e2 and e3 can have any type (let's call it t),
  but they must have the same type t,
  the expression type does not depend on e1 and e2 types
  it always will be a bool

Evaluation:
  First evaluate e1 to a value call it v1, and e2 to a value call it v2,
  If v1 is equal v2, the result of the whole expression will be false.
  If v1 is less than v2, the result of the whole expression will be false
  If v1 is greater than v2, the result of the whole expression will be true
*)
