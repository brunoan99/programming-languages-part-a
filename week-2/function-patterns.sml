(*


*)

datatype exp = Constant of int
             | Negate of exp
             | Add of exp * exp
             | Muliply of exp * exp

fun old_eval e =
  case e of
      Constant i => i
    | Negate e1 => ~ (old_eval e1)
    | Add(e1, e2) => (old_eval e1) + (old_eval e2)
    | Multiply(e1, e2) => (old_eval e1) + (old_eval e2)

fun eval (Constant i) = i
  | eval (Negate e1) = ~ (eval e1)
  | eval (Add(e1, e2)) = (eval e1) + (eval e2)
  | eval (Multiply(e1, e2)) = (eval e1) * (eval e2)

fun append ([], xs) = xs
  | append (x::xs', ys) = x :: append(xs', ys)

(*
The function pattern is just a syntatic sugar for using case expressions.
But it add so much readability to code
*)

(*
In general

fun f x =
  case x of
      p1 => e1
    | p2 => e2

Can be written as

fun f p1 = e1
  | f p2 = e2
  ...
  | f pn = en

This assumes that you don't need x in any branch
*)
