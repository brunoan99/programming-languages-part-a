(*
Case

ML combines the two aspects of accessing a one-of value with a case expression and patter-matching
  - Pattern-matching much more general/powerful

Example:
*)

datatype mytype = TwoInts of int * int
                | Str of string
                | Pizza

fun f x =
  case x of
      Pizza => 3
    | Str s => String.size s
    | TwoInts(i1, i2) => i1 + i2

(*
A multi-branch conditional to pick branch base on variant
Extracts data and binds to variables local to that branch
Type-cghecking: all branches must have same type
Evaluation: evaluate between case ... of and the right branch
*)

(*
Patterns

Syntax:
  case e0 of
       p1 => e1
     | p2 => e2
        ...
     | pn => en

Each Pattern is a constructor name followeb by the right number of variables(i.e, C or C x or C (x, y) or ...)
  - Syntatically most patterns (all today) look like expressions
  - But patterns are not expressions
    - We do not evaluate them
    - We see if the reesult of e0 matches them

Why this way is better

0. You can use pattern-matching to write your own testing and data-extractions functions if you must
1. You cannot forget a case (inexhaustive pattern-match warning)
2. You cannot duplicate a case (a type-checking error)
3. You will not forget to test the variant correctly and get an expretion (like hd [])
4. Pattern-matching can be generalized and made more powerful, leading to elegant and concise code

*)
