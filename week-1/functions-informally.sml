(*
Function

Functions: the most important building block in the whole course
  - Like Java methods, have arguments and result
  - But no classes, this, return, etc.

Example function binding:
*)
fun pow (x: int, y: int) =
  if y = 0 then 1 else x * pow(x, y-1)

fun cube (x: int) =
  pow (x, 3)

val sixtyfour = cube(4)

val fortytwo = pow(2, pow(2, 2)) + pow(pow(2, 2), 2) + cube(2) + 2

(*
Three common "gotchas"

- Bad error messages if you mess up function-argument syntax

- The us of * in type syntax is not multiplication
  - Example: int * int -> int
  - In expressions, * is multiplication: x * pow (x, y - 1)

- Cannot refer to later functions bindings
  - That's simply ML's rule
  - Helper functions must come before their uses
  - Need special construct for mutual recursion
*)
