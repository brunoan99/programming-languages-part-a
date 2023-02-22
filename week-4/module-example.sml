(* A Module Example *)

(* A larger example [mostly see the code]

Now consider a module that defines an Abstract Data Type (ADT)
  - A type of data and operations on it
Our example: rational numbers supporting add and toString

*)

structure Rational1 =
struct
  datatype rational = Whole of int | Frac of int * int
  exception BadFrac

  (* gcd and reduce help keep fractions reduced *)
  fun gcd (x,y) =
    if x=y
    then x
    else if x < y
    then gcd(x,y-x)
    else gcd(y,x)

  fun reduce r =
    case r of
        Whole _ => r
      | Frac(x,y) =>
        if x=0
        then Whole 0
        else  let val d = gcd(abs x, y) in
                  if d=y
                  then Whole(x div d)
                  else Frac(x div d, y div d)
              end

  (* when making a frac, we ban zero denominators *)
  fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then reduce(Frac(~x,~y))
    else reduce(Frac(x,y))

  (* using math properties, both invariants hold of the result assuming they hold of the arguments *)
  fun add (r1, r2) =
    case (r1,r2) of
        (Whole(i),Whole(j))   => Whole(i+j)
      | (Whole(i),Frac(j,k))  => Frac(j+k*i,k)
      | (Frac(j,k),Whole(i))  => Frac(j+k*i,k)
      | (Frac(a,b),Frac(c,d)) => reduce (Frac(a*d + b*c, b*d))

  (* given invariant, returns in reduced form *)
  fun toString r =
      case r of
          Whole i => Int.toString i
        | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b)
end

(* Library spec and invariants

Properties [externally visible guarantees, up to library writer]
  - Disallow denominators of 0
  - Return strings in reduced form ("4" not "4/1", "3/2" not "9/6")
  - NO infinite loops or exceptions

Invariants [part of the implementations, not the module's spec]
  - All denominators are greater than 0
  - All rational values returned from functions are reduced
*)

(* More on invariants

Our code maintains the invariants and relies on them

Maintain:
  - make_frac disallows 0 denominators, removes negative denominator, and reduces result
  - add assumes invariants on inputs, calls reduce if needed

Rely:
  - gcd does not work with negative arguments, but denominator can be negative
  - add uses math properties to avoid calling reduce
  - toString assumes its arguments is already reduced

*)

(* A first signature

With what we know so far, this signature makes sense:
  - gcd and reduce not visible outside the module
*)

signature RATIONAL_A =
sig
  datatype rational = Whole of int | Frac of int*int
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

structure RationalA :> RATIONAL_A =
struct
  datatype rational = Whole of int | Frac of int * int
  exception BadFrac

  (* gcd and reduce help keep fractions reduced *)
  fun gcd (x,y) =
    if x=y
    then x
    else if x < y
    then gcd(x,y-x)
    else gcd(y,x)

  fun reduce r =
    case r of
        Whole _ => r
      | Frac(x,y) =>
        if x=0
        then Whole 0
        else  let val d = gcd(abs x, y) in
                  if d=y
                  then Whole(x div d)
                  else Frac(x div d, y div d)
              end

  (* when making a frac, we ban zero denominators *)
  fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then reduce(Frac(~x,~y))
    else reduce(Frac(x,y))

  (* using math properties, both invariants hold of the result assuming they hold of the arguments *)
  fun add (r1, r2) =
    case (r1,r2) of
        (Whole(i),Whole(j))   => Whole(i+j)
      | (Whole(i),Frac(j,k))  => Frac(j+k*i,k)
      | (Frac(j,k),Whole(i))  => Frac(j+k*i,k)
      | (Frac(a,b),Frac(c,d)) => reduce (Frac(a*d + b*c, b*d))

  (* given invariant, returns in reduced form *)
  fun toString r =
      case r of
          Whole i => Int.toString i
        | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b)
end

(* The problem

By revealing the datatype definition, we let clients violate our invariants by directly creating values of type RationalA.rational
  - At best a comment saying "must use RationalA.make-frac"

Any of these would lead to exception, infinite loops, or wrong results, which is why the module's code would never return them
  - RationalA.Frac(1,0)
  - RationalA.Frac(3,~2)
  - RationalA.Frac(9,6)
*)

(* So hide more

Key idea: An ADT must hid the concrete type definition so clients cannot create invariant-violating values of the type directly

This attempt doesn't work because the signature now usees a type rational that is not know to exist:

*)

(* Abstract types

So ML has a feature for exactly this situation:

In a signature:
    type foo
means the type exists, but clients do not know its definition

*)

signature RATIONAL_B =
sig
  type rational
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end


structure RationalB :> RATIONAL_B =
struct
  datatype rational = Whole of int | Frac of int * int
  exception BadFrac

  (* gcd and reduce help keep fractions reduced *)
  fun gcd (x,y) =
    if x=y
    then x
    else if x < y
    then gcd(x,y-x)
    else gcd(y,x)

  fun reduce r =
    case r of
        Whole _ => r
      | Frac(x,y) =>
        if x=0
        then Whole 0
        else  let val d = gcd(abs x, y) in
                  if d=y
                  then Whole(x div d)
                  else Frac(x div d, y div d)
              end

  (* when making a frac, we ban zero denominators *)
  fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then reduce(Frac(~x,~y))
    else reduce(Frac(x,y))

  (* using math properties, both invariants hold of the result assuming they hold of the arguments *)
  fun add (r1, r2) =
    case (r1,r2) of
        (Whole(i),Whole(j))   => Whole(i+j)
      | (Whole(i),Frac(j,k))  => Frac(j+k*i,k)
      | (Frac(j,k),Whole(i))  => Frac(j+k*i,k)
      | (Frac(a,b),Frac(c,d)) => reduce (Frac(a*d + b*c, b*d))

  (* given invariant, returns in reduced form *)
  fun toString r =
      case r of
          Whole i => Int.toString i
        | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b)
end

(* This works

Nothing a client can do to violate invariants and properties:
  - Only way to make first rational is RationalB.make_frac
  - After that can use only RationalB.make_frac, RationalB.add and RationalB.toString
  - Hides constructors and patteerns - don't even know whether or not RationalB.rational is a datatype
  - But clients can still pass around fractions in any way

*)

(* Two key restrictions

So we have two powerful ways to use signatures for hiding:

1. Deny bindings exist (val-bindings, fun-bindings, constructors)

2. Make types abstract (so clients cannot createe values of them or access their pieces directly)

*)

signature RATIONAL_C =
sig
  type rational
  exception BadFrac
  val Whole : int -> rational
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

structure RationalC :> RATIONAL_C =
struct
  datatype rational = Whole of int | Frac of int * int
  exception BadFrac

  (* gcd and reduce help keep fractions reduced *)
  fun gcd (x,y) =
    if x=y
    then x
    else if x < y
    then gcd(x,y-x)
    else gcd(y,x)

  fun reduce r =
    case r of
        Whole _ => r
      | Frac(x,y) =>
        if x=0
        then Whole 0
        else  let val d = gcd(abs x, y) in
                  if d=y
                  then Whole(x div d)
                  else Frac(x div d, y div d)
              end

  (* when making a frac, we ban zero denominators *)
  fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then reduce(Frac(~x,~y))
    else reduce(Frac(x,y))

  (* using math properties, both invariants hold of the result assuming they hold of the arguments *)
  fun add (r1, r2) =
    case (r1,r2) of
        (Whole(i),Whole(j))   => Whole(i+j)
      | (Whole(i),Frac(j,k))  => Frac(j+k*i,k)
      | (Frac(j,k),Whole(i))  => Frac(j+k*i,k)
      | (Frac(a,b),Frac(c,d)) => reduce (Frac(a*d + b*c, b*d))

  (* given invariant, returns in reduced form *)
  fun toString r =
      case r of
          Whole i => Int.toString i
        | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b)
end

(*
In our example, exposing the Whole constructor is no problem

In SML we can expose it as a function since the datatype binding in the module does create such a function
  - Still hiding the rest of the datatype
  - Still does not allow using Whole as a pattern

*)
