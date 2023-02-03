(*
Nested Functions

According to rules for let-expressions, we can define functions inside any let-expression:

let b1 b2 ... bn in e end

This is a natural idea, and often good style
*)

fun count(from: int, to: int) =
  if from=to
  then to::[]
  else from :: count(from + 1, to)

fun countup_from1(x: int) = count(1, x)

(*
Without the use of nested functions the count function is able to be called for another function

Nested functions are methods to abstract some implementations and only show the methods that was wanted
*)

fun countup_nested(x: int) =
  let
    fun count (from: int) =
      if from=x
      then x::[]
      else from :: count(from + 1)
  in
    count(1, x)
  end


(*
This shows how to use a local function binding, but:

Functions can use bindings int the environment where they are defined:
  - Bindings from "outer" environments
    - Such as parameters to the outer function
  - Earlier bindings in the let-expression

Unnecessary parameters are usually bad style


Nested functions are good style to definer helper functions inside the functions they help if they are:
  - Unlikely to be useful elsewhere
  - Likely to be misused if available elsewhere
  - Likely to be changed or removed later

A fundamental trade-off in code design: reusing code saves effort and avoids bugs, but makes the reused code harder to change later
*)
