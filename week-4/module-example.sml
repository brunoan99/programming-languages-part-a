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
