(*
Lists

Despite nested tuples, the type of a variable still "commits" to a particular "amount" of data

In contrast, a list:
  - Can have any number of elements
  - But all list elements have the same type

Need ways to build lists and access the pieces of data

---

Building a List:

The empty list is a value:
  []

In general, a list of values is a value; elements separated by commans:
  [v1, v2, ..., vn]

If e1 evaluates to v and e2 evaluates to a list [v1, ..., vn]
then e1::e2 evaluates to [v, ...,vn]
  e1::e2 (* pronounced "cons" *)
*)

val a = []

val x = [7, 8, 9]

val y = 6::x (* -> [6, 7, 8, 9] *)

val z = 5::6::x (* -> [5, 6, 7, 8, 9] *)

(*
Accessing Lists

Untils we learn pattern-matching, we will use three standard-library functions

- 'null e', evaluates to true if and only if e evaluates to []

- if e evaluates to [v1, v2, ..., vn] then 'hd e' evaluates to v1
  - (raise exception if e evaluates to [])

- if e evaluates to [v1, v2, ..., vn] then 'tl e' evaluates to [v2, ..., vn]
  - (raise exception if e evaluates to [])
  - result is a list
*)

val acess1 = null a (* -> true *)

val acess2 = hd z (* -> 5 *)

val access3 = tl y (* -> [7, 8, 9] *)

val access4 = hd (tl (tl x)) (* -> 9 *)

(*
Type-checking list operations

Lots of new types: For any type t, the type t list describes lists where all elements have type t
  - Examples:
    - int list
    - bool list
    - int list list
    - (int * int) list
    - (int list * int) list

  So [] can have type 't list' list for any type
    - SML uses type 'a list to indicate this ('a or alpha)

  For e1::e2 to type-check, we need a t such that e1 has type t and e2 has type t list. Then the result type is t list

  null  : 'a list -> bool
  hd    : 'a list -> 'a
  tl    : 'a list -> 'a list

*)
