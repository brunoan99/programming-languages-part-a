(* Equivalence Versus Performance *)

(* What about performance

According to our definition of equivalence, these two functions are equivalent
*)

fun max xs =
  case xs of
      [] => raise Empty
    | x::[] => x
    | x::xs' => if x > max xs'
                then x
                else max xs'

fun max xs =
    case xs of
        [] => raise Empty
      | x::[] => x
      | x::xs' => let val y = max xs'
                  in
                    if x > y then x else y
                  end

(*
The first function compute max xs' two times for each call. Its awful to use that function for larger lists.

But in terms of equivalence they do the same thing
*)

(* Different definitions for different jobs

- PL Equivalence: given same inputs, same outputs and effects
  - Good: Let us replace bad max with good max
  - Bad: Ignores performance in the extreme

- Asymptotic Equivalence: Ignore constant factors
  - Good: Focus on algorithm and efficiency for large inputs
  - Bad: Ignores "four times faster"

- System Equivalence: Account for constant overheads performance tune
  - Good: Faster means different and better
  - Bad: Beware overtuning on "wrong" (e.g., small) inputs;
    definition does not let you "swap in a different algorithm"

*)
