(*
A Little Type Inference
*)

(* REPL type: val sum_triple = fn : int * int * int -> int *)
fun sum_triple (x, y, z) =
  x + y + z


(* REPL type: val full_name = fn : {first:string, last:string, middle:string} -> string *)
fun full_name {first=x, middle=y, last=z} =
  x ^ " " ^ y ^ " " ^ z

(*
The patterns told the Type checker how many or what will be, and the body shows the type.
*)

fun sum_triple2 triple =
  #1 triple + #2 triple + #3 triple

(* This function will not compile, cause of a compiler limitation of infer how many arguments a tuple will have,
in sum_triple2 the function use 3 arguments, but nothing say that triple cannot have more than 3 arguments, than
the compiler will not infer that

Cause this, if we want to write a function like that there are 2 options,

use (x, y, z) as argument
or type the argument(triple: int * int * int)

Somethimes type-checker is "smarter than you expect"
  - Types of some parts might be less constrained than you think
  - Example: If you do not use something it can have any type
*)
(* int * 'a * int -> int *)
fun partial_sum (x, y, z) =
  x + z

(*{first:string, last:string, middle:'a} -> string *)
fun full_name {first=x, middle=y, last=z} =
  x ^ " " ^ z

(*
This is okay!
  - A more general type than you need is always acceptable
  - Assuming your function is correct, of course
  - More precise definition of "more general type" next segment
*)
