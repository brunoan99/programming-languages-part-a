(*
Datatypes

A way to make one-of types:
  - A datatype binding
*)

datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza

(*
Adds a new type mytype to the environment
Adds constructors to the environment: TwoInts, Str, and Pizza
A constructor is (among other things), a function that makes values of the new type (or is a value of the new type):
  - TwoInts : int * int -> mytype
  - Str : string -> mytype
  - Pizza : mytype

Any Value of type mytype is made from one of the constructors
The Value contains
  - A "tag" for "which constructor" (e.g., TwoInts)
  - The corresponding data (e.g., (7,9))

Examples:
  - TwoInts (3+4, 5+4) evaluates to TwoInts (7,9)
  - Str (if true then "hi" else "bye") evaluates to Str("hi")
  - Pizza is a value
*)

(*
Using them

So we know how to build datatype values; need to access them

There are two aspects to accessing a datatype value
1. Check what variant it is (what constructor made it)
2. Extract the data (if that variant has any)

Notice how our other one-of types used functions for this:
- null and isSome check variants
- hd, tl, and valOf extract data (raise exception on wrong variant)

ML could have done the same for datatype bindings
  - For example, functions like "isStr" and "getStrData"
  - Instead it did something better
*)

(* Useful examples *)

(* Enumerations, including carrying other data *)
datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int

(*Alternate ways of identifying real-world things *)
datatype id = StudentNum of int
            | Name of string

(*
Unfortunatelty, bad training and languages that make one-of types inconvenient lead to common bad style where each-of types are use where one-of types are the right tools
*)

(* use the student_num and ignore tother fields unless the student_num is ~1
{ student_num   : int,
  first         : string,
  middle        : string option,
  last          : string }

Approach gives up all the benefits of the language enforcing every value is one variant, you don't forget branches, etc.

And it makes it less clear what you are doing

But instead, the point is that every "person" in your proggram has a name and maybe a student number, then each-of is the way to go:
{ student_num   : int option,
  first         : string,
  middle        : string option,
  last          : string }
*)

(*
Expression Trees

A example of a datatyper, using self-reference
*)

datatype exp = Constant   of int
             | Negate     of exp
             | Add        of exp * exp
             | Multiply   of exp * exp

(* An expression in ML of type exp:
Add (Constant (10 + 9), Negate (Constant 4))

How to picture the resulting value in your head:

             Add
            /   \
    Constant     Negate
        |           |
        19       Constant
                    |
                    4
*)

(*
Not surprising:
  Functions over recursive datatypes are usually recursive
*)

fun eval e =
  case e of
       Constant i         => i
    |  Negate e2          => ~ (eval e2)
    |  Add(e1, e2)        => (eval e1) + (eval e2)
    |  Multiply(e1, e2)    => (eval e1) * (eval e2)

fun number_of_adds e =
  case e of
       Constant _       => 0
    |  Negate e2        => number_of_adds e2
    |  Add (e1, e2)      => 1 + number_of_adds e1 + number_of_adds e2
    |  Multiply(e1, e2)  => number_of_adds e1 + number_of_adds e2

(*
Polymorphic datatype

Claimed built-in options and lists are not needed/special
  - Other than special syntax for list constructors

But these datatype bindings are polymmorphic type constructors
  - int list and string list and int list list are all types, not list

  - Functions might or might not be polymorphic
    - val sum_list : int list -> int
    - val append : 'a list * 'a list -> 'a list

Good language design: Can define new polymorphic datatypes.

Syntax: put one or more type variables before datatype name
  Examples:
    datatype 'a options = NONE | SOME of 'a

    datatype 'a mylist = Empty | Cons of 'a * 'a mylist

    datatype ('a, 'b) tree = Node of 'a * ('a, 'b) tree * ('a, 'b) tree
                           | Leaf of 'b

Can use these type variables in constructor definitions

Binding then introduces a type constructor, not a type
  - Must say int mylist or string mylist or 'a mylist
  - Not "plain" mylist
*)

(* type is int list -> int *)
fun sum_list xs =
  case xs of
      [] => 0
    | x::xs' => x + sum_list xs'

(* type is 'a list * 'a list -> 'a list *)
fun append (xs, ys) =
  case xs of
      [] => ys
    | x::xs' => x::append(xs', ys)


datatype ('a, 'b) tree = Node of 'a * ('a, 'b) tree * ('a, 'b) tree
                        | Leaf of 'b

(* type is (int,int) tree -> int *)
fun sum_tree tr =
  case tr of
      Leaf i => i
    | Node (i, lft, rgt) => i + sum_tree lft + sum_tree rgt

(* type is ('a,int) tree -> int *)
fun sum_leaves tr =
  case tr of
      Leaf i => i
    | Node (_, lft, rgt) => sum_leaves lft + sum_leaves rgt

(* type is ('a,'b) tree -> int *)
fun count_leaves tr =
  case tr of
      Leaf _ => 1
    | Node (_, lft, rgt) => count_leaves lft + count_leaves rgt

(*
Nothing else changes

Use constructors and case expressions as usual

- No change to evaluation rules

- Type-checking will make sure types are used consistently
  - Example: cannot mix element types of list

- Functions will be polymorphic or not based on how data is used



*)
