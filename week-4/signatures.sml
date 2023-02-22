(* Signatures and Hiding Things *)

(* Signatures

A sinature is a type for a module
  - What bindings does it have and what are their types

Can define a signature and ascribe it to modules - example:
*)
signature MATHLIB =
sig
  val fact : int -> int
  val half_pi : real
  val doubler : int -> int
end

structure MyMathLib :> MATHLIB =
struct
  fun fact x =
    case x of
        0 => 1
      | x => x * fact (x - 1)

  val half_pi = Math.pi / 2.0

  fun doubler x = x * 2
end

val pi = MyMathLib.half_pi + MyMathLib.half_pi

val twenty_eight = MyMathLib.doubler 14

(* In general

Signatures
  signature SIGNAME =
  sig types-for-bindings end

  - Can include variables, types, datatypes, and exceptions defined in module

- Ascribing a signature to a module
  structure MyModule :> SIGNAME =
  struct bindings end

  - Module will not type-check unless it matches the signature meaning it has all the bindings at the right types
*)

(* Hiding things

Real value of signatures is to hide bindings and type definitions
  - So far, just documenting and checking the types

Hiding implementation details is the most important strategy for writing correct, robust, reusable software

So first remind ourselves that functions already do well for some forms of hiding...

These three function are totally equivalent: no client can tell which we are using (so we can change our choice later):
*)
fun double1 x = x * 2
fun double2 x = x + x
val y = 2
fun double3 x = x * y
(*
Defining helper functions locally is also powerful
  - Can change/remove functions later and know it affects no other code

Would be conveninet to have "private" top-level function too
  - So two functions could easily share a helper function
  - ML does this via signatures that omit bindings
*)

(* Example

Outside the module, MyMathLib.doubler is simply unbound
  - So cannot be used [directly]
  - Fairly powerful, very simple idea
*)


signature MATHLIB' =
sig
  val fact : int -> int
  val half_pi : real
end

structure MyMathLib' :> MATHLIB' =
struct
  fun fact x =
    case x of
        0 => 1
      | x => x * fact (x - 1)

  val half_pi = Math.pi / 2.0

  fun doubler x = x * 2
end
