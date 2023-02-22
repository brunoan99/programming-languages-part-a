(* Signature Matching *)


(* Signature Matching

Have so far relied on an informal notion of, "does a module type-check given a signature?" As usual, theree are precise rules...

structure Foo :> BAR is allowed if:

- Every non-abstract type in BAR is provided in Foo, as specified
- Every abstract type in BAR is provided in Foo in some way
  - Can be a datatype or a type synonym
- Every val-binding in BAR is provided in Foo, possibly with a more general and/or less abstract internal type
- Every exception in BAR is provided in Foo

Of course Foo can have more bindings (implicit in above rules)

*)
