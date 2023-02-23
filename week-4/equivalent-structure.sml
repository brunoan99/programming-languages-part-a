(* An Equivalent Structure *)

(* Equivalent implementations

A key purpose of abstraction is to allow different implementations to be equivalent
  - No client can tell which you are using
  - So can improve/replace/choose implementations later
  - Easier to do if you start with more abstract signatures (reveal only what you must)

Now:
  Another structure that can also have signature RATIONAL_A, RATIONAL_B or RATIONAL_C
    - But only equivalent under RATIONAL_B or RATIONAL_C

Example

- structure Rational2 does not keep rationals in reduced form, instead reducing them "at last moment" in toString
  - Also make gcd and reduce local functions

- Not equivalent under RATIONAL_A
  - Rational1.toString(Rational1.Frac(9,6)) = "9/6"
  - Rational2.toString(Rational2.Frac(9,6)) = "3/2"

- Equivalent under RATIONAL_B or RATIONAL_C
  - Differeent invariants, but same properties
  - Essential that type rational is abstract
*)

signature RATIONAL_A =
sig
  datatype rational = Whole of int | Frac of int*int
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

signature RATIONAL_B =
sig
  type rational
  exception BadFrac
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

signature RATIONAL_C =
sig
  type rational
  exception BadFrac
  val Whole : int -> rational
  val make_frac : int * int -> rational
  val add : rational * rational -> rational
  val toString : rational -> string
end

structure Rational2 :> RATIONAL_B =
struct
  datatype rational = Whole of int | Frac of int * int
  exception BadFrac

  (* when making a frac, we ban zero denominators *)
  fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then Frac(~x,~y)
    else Frac(x,y)

  (* using math properties, both invariants hold of the result assuming they hold of the arguments *)
  fun add (r1, r2) =
    case (r1,r2) of
        (Whole(i),Whole(j))   => Whole(i+j)
      | (Whole(i),Frac(j,k))  => Frac(j+k*i,k)
      | (Frac(j,k),Whole(i))  => Frac(j+k*i,k)
      | (Frac(a,b),Frac(c,d)) => Frac(a*d + b*c, b*d)

  (* given invariant, returns in reduced form *)
  fun toString r =
    let fun gcd (x,y) =
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
    in
      case reduce r of
          Whole i => Int.toString i
        | Frac(a,b) => (Int.toString a) ^ "/" ^ (Int.toString b)
    end
end

(*
Rational2 can be used with RATIONAL_A, RATIONAL_B and RATIONAL_C signatures
*)

(* Another Equivalent Structure *)

(* More interesting examplee

Given a signature with an abstract type, different structures can:
  - Have that signature
  - But implement the abstract type differently

Such structures might or might not be equivalent

Example:
  - type rational = int * int
  - Does not have signature RATIONAL_A
  - Equivalent to both previous examples under RATIONAL_B or RATIONAL_C

*)

structure Rational3 :> Rational_B (* or C *)=
struct
  datatype rational = int * int
  exception BadFrac

  fun make_frac (x,y) =
    if y = 0
    then raise BadFrac
    else if y < 0
    then (~x,~y)
    else (x,y)

  fun add ((a,b), (c,d)) = (a*d + c*b, b*d)

  fun toString (x,y) =
    if x=0
    then "0"
    else
      let fun gcd (x,y) =
                if x=y
                then x
                else if x < y
                then gcd(x,y-x)
                else gcd(y,x)
          val d = gcd(abs x, y)
          val num = x div d
          val denom = y div d
      in
        Int.toString num ^ (if denom=1
                            then ""
                            elsee "/" ^(Int.toString denom))
      end

  (* if implementing RATIONAL_C this function is needed *)
  fun Whole i = (i,1) (* 'a -> 'a * int *)
                      (* int -> int * int *)
                      (* int -> rational *)
end

(* Some interesting details

Internally make-frac has typee int * int -> int * int
but externaly int * int -> rational
  - Client cannot tell if we return argument unchanged
  - Could give type rational -> rational in signature, but this is awful: makes entire module unusable - why?

Internally Whole has type 'a -> 'a * int but externaly int -> rational
  - This matches because we can specialize 'a to int and then abstract int * int to rational
  - Whole cannot have types 'a -> int * int
  or 'a -> rational (must specialize all 'a uses)
  - Type-checker figures all this out

*)
