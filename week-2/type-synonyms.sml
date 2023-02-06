(*
Type Synonyms

Creating new types

- A datatype binding introduces a new type name
  - Distinact from all existing types
  - Only way to create values of the new type is the constructors

- A type synonym is a new kind of binding
  type aname = t

  - Just creates another name for a type
  - The type and the name are interchangeable in every way
  - Do not worry about what REPL prints: picks what it wants just like it picks the order of record field names

*)

datatype suit = Club | Diamond | Heart | Spade
datatype rank = Jack | Queen | King | Ace | Num of int

type card = suit * rank

type name_record = {
  student_num    : int option,
  first          : string,
  middle         : string option,
  last           : string
}

fun is_Queen_of_Spades (c :card) =
  #1 c = Spade andalso #2 c = Queen

fun is_Queen_of_Spades2 c =
  case c of
      (Spade, Queen) => true
    | _ => false

val c1 : card = (Diamond, Ace)
val c2 : suit * rank = (Heart, Ace)
val c3 = (Spade, Ace)

(*
Why have this?

For now, type synonyms just a convenience for talking about types
  - Example (where suit and rank already definexd):
    type card = suit * rank

  - Write a function of type
    card -> bool

  - Okay if REPL says your function has type
    suit * rank -> bool

Convenient, but does not let us "do" anything new

Later in course will see another use related to modularity
*)
