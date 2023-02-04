(*
Boolean Operations

## And Operations
Syntax:
  e1 andalso e2
  where andalso is a keyword
  e1 and e2 are expressions

Type-checking:
  e1 and e2 must have type bool

Evaluation:
  If result of e1 is false then false else result of e2
  If result of e1 is false the e2 will not be evaluated


## Or Operations
Syntax:
  e1 orelse e2
  where orelse is a keyword
  e1 and e2 are expressions


Type-checking
  e1 and e2 must have type bool

Evaluation:
  If result of e1 is true then true else result of e2
  If result of e1 is true then e2 will not be evaluated


## Not Operations
Syntax:
  not e1
  where not is a keyword
  e1 is a expression

Type-checking:
  e1 must have type bool

Evaluation:
  If result of e1 is true then false else true

---

"Short-circuiting" evaluation means andalso and orelse are not functions, but not is just a pre-defined function

In many languages is e1 && e2, e1 || e2, !e - && and || don't exist in ML and ! means something different

*)

(*
Languagee does not need andalso, orelse, not. It can be implemented

e1 andalso e2
  if e1
  then e2
  else false

e1 orelse e2
  if e1
  then true
  else e2

not e1
  if e1
  then false
  else true

Using more concise forms generally much better style

*)
