(* Modules for Namespace Manageement *)

(* Modules

For larger programs, onee "top-level" sequence of bindings is poor
  - Especially because a binding can use all earlier (non-shadowed) bindings

So ML has structures to define modules
  structure MyModule = struct bindings end

Inside a module, can use earlier bindings as usual
  - Can have any kind of binding (val, datatype, exception, ...)

Outside a module, refer to earlier module's bindings via ModuleName.bindingName
  - Just like List.foldl and String.toUpper

*)

structure MyMathLib =
struct
  fun fact x =
    case x of
        0 => 1
      | x => x * fact (x-1)

  val half_pi = Math.pi / 2.0

  fun doubler y = y + y
end

val pi = MyMathLib.half_pi + MyMathLib.half_pi

val twenty_eight = MyMathLib.doubler 14

(* Namespace management

So far, this is just namespace management
  - Giving a hierarchy to names to avoid shadowing
  - Allows different modules to reuse names, e.g., map
  - Very important, but not very interesting

*)

(* Optional: Open

- Can use open ModuleName to get "direct" access to a module's bindings
  - Never necessary; just a convenience; often bad style;
  - Often better to create local val-bindings for just the bindings you use a lot, e.g., val map = List.map
    - But doesn't work for patterns
    - And open can be useful, e.g., for testing code in REPL

*)

(* Can't mix-and-match module bindings

Modules with the same signatures still define differeent types

So things like this do not type-check:
  - RationalA.toString(RationalB.make_frac(9,6))
  - RationalC.toString(RationalB.make_frac(9,6))

This is a crucial feeature for type system and module properties:
  - Different modules have different internal invariants!
  - In fact, they have different type definitions
    - RationalA.rational lookes like RationalB.rational but clients and the type-checker do not know that
    - RationalC.rational is int*int not a datatype

*)
