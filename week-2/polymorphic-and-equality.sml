(*
Polymorphic Types and Equality Types

"Write a function that appends two string lists"
*)
fun append (xs, ys) =
  case xs of
      [] => ys
    | x::xs' => x :: append(xs', ys)

(*
You expect string list * string list -> string list
Implementation says 'a list * 'a list -> 'a list
This is okay: why?
*)

val ok1 = append(["h1", "bye"], ["programming", "language"])

val ok2 = append([1, 2], [3, 4])

(*
val not_ok = append([1, 2], ["programming", "language"])
Error: operator and operand do not agree [overload - bad instantiation]
*)

(*
The type
  'a list * 'a list -> 'a list

is more general than the type
  string list * string list -> string list

It "can be used" as any less general type, such as
  int list * int list -> int list

But it is not more general than the type
  int list * string list -> int list
  it cannot replace 'a with int and string at same time
*)

(*
The "more general" rule

Easy rule you (and the type-checker) can apply without thinking:

  A type t1 is more geeneral than the type t2 if you can take t1, replace its type variables consistentyle, and get t2

  Examples:
    - Replace each 'a with int * int
    - Replace each 'a with bool and each 'b with bool
    - Replace each 'a with bool and each 'b with int
    - Replace each 'b with   'a and each 'a with 'a

Can combine the "more general" rule with rules for equivalence
  - Uses of type synonyms does not matter
  - Order of field names does not matter

Example, given
  type foo = int * int

the type
  { quux : 'b, bar: int * 'a, baz : 'b }
is more general than
  { quux : string, bar : foo, baz : string }
which is equivalent to
  { bar : int*int, baz : string, quuz :string }
*)

(*
Equality types

You might also see type variabes with a second "quote"
  - Example: ''a list * ''a -> bool

These are "equality types" that arise from using the = operator
  - The = operator works on lots of types: int, string, tuples containing all equality types, ...
  - But not all types: function types, real...

The rules for more general are exactly the same except you have to replace an equality-type variable with a type that can be used with =
  - A "strange" feature of ML because = is special
*)

(* ''a * ''a -> string *)
fun same_thing (x, y) =
  if x=y then "yes" else "no"
(* These will generate a warning polyEqual, but it can be ignored *)


(* int -> string *)
fun is_three x =
  if x=3 then "yes" else "no"
(* This function don't produce a double quoted type cause the body shows to type-checker that x was beeing compareed to a integer and the equality only can be checked for elements of same type. Than the type-checker knows x need to bee a int*)
