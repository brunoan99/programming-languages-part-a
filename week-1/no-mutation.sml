(*
A valuable non-feature: no mutation

Now learn a very important non-feature
  - When it lets you know thiings other code will not do with your code and the results your code produces

A major aspect and contribution of function programming:
  Not being able to assing to variables or parts of tuples and lists
  "Big Deal"

*)

fun sort_pair1 (pr: int * int) =
  if #1 pr < #2 pr
  then pr
  else (#2 pr, #1 pr)

fun sort_pair2 (pr: int * int) =
  if #1 pr < #2 pr
  then (#1 pr, #2 pr)
  else (#2 pr, #1 pr)

(*
In ML, these two implementations of sort_pair are indistinguishable
  - But only because tuples are immutable
  - The first is better style: simpler and avoids making a new pair in the then-branch
  - In languages with mutable compound data, these are different!
*)

val x = (3, 4)
val y = sort_pair1 x

(* somehow mutate #1 x to hold 5 *)

val z = #1 y

(*
What is z?
  - Would depend on how we implemented sort_pair
    - Would have to decide carefully and document sort_pair
  - But without mutation, we can implement "either way"
    - No code can ever distinguish aliasing vs identical copies
    - No need to thinks about aliasing: focus on other things
    - Can use aliasing, wich saves space, without danger
*)

fun append (xs : int list, ys : int list) =
  if null xs
  then ys
  else hd (xs) :: append (tl (xs), ys)

val x = [2, 4]
val y = [5, 3, 0]
val z = append (x, y)

(*

x = 2 -> 4 |
y = 5 -> 3 - 0 |
z = 2 -> 4 -> y

or

x = 2 -> 4 |
y = 5 -> 3 -> 0 |
z = 2 -> 4 -> 5 -> 3 -> 0 |

*)

(*
ML vs. Imperative Languages

In Ml, we create aliases all the time without thinking about it because it is impossible to tell where there is aliasing
  - Example: tl is constant time; does not copy rest of the list
  - So don't worry and focus on your algorithm

In languages with mutable data (e.g., Java), programmers are obsessed with aliasing and object identity
  - They have to be (!) so that subsequent assignments affect the right parts of the program
  - often crucial to make copies in just the right places
*)
