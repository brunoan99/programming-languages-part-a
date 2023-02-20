(* Mutable References *)

(*
ML has (separate) mutation

- Mutable data strucutres are okay in some situations
  - When "update to state of world" is appropriate model
  - But want most language constructs truly immutable

- ML does this with a separate construct: references
*)

(*
References

- New types t ref where t is a type

- New Expressions
  - ref e to createe a reference with initial content e
  - e1 := e2 to update contents
  - !e to retrieve contents (not negation)
*)

val x = ref 42
val y = ref 42
val z = x
val _ = x := 43
val w = (!y) + (!z) (* 85 *)

(*
- A variable bound to a reference (e.g., x) is still immutable: it will always refer to the same reference
- But the contents of the reference may change via :=
- And there may be aliases to the reference, which matter a lot
- Reference are first-class values
- Like a one-field mutable object, so := and ! don't specify the field

*)
