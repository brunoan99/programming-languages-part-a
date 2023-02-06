(*
Records

Record types are “each-of” types where each component is a named field. For example, the type
{foo : int, bar : int*bool, baz : bool*int} describes records with three fields named foo, bar, and
baz

Record values have fields (any name) holding values
  {f1 = v1, ..., fn = vn}

Record types gave fields (and name) holding types
  {f1 : t1, ..., fn : tn}

The order of fields in a record value or type never matters
  - REPL alphabetizes fields just for consistency

Building records:
  {f1 = e1, ..., fn = en}

Acessing pieces:
  #myfieldname e

Evaluation:
  {name = "Amelia", id = 41123 -12}
  Evaluates to -> {id = 41111, name = "Amelia"}
  And has type -> {id : int, name = string}

If some expression such as a variable x has this type, then get fields with
  #id x | #name x

Note we did not have to declare any record types
  - The same program could also make a
    {id=true,ego=false} of type {id:bool, ego:bool}

Little difference between (4,7,9) and {f=4,g=7,h=9}
  - Tuples a little shorter
  - Records aa little easier to remember "what is where"
  - Generally a matter of taste, but for many (6? 9? 12?) fields, a record is usually a better choice

A common decision for a construct's syntax is whether to refer to things by position (as in tuples) or by some (field) name (as with records)
  - A common hybrid is like with Java methods arguments (and ML functions as uses so far):
    - Caller uses positions
    - Calle uses variables
*)
