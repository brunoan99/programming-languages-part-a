(*
Moral of tail recursion

Where reasonably elegant, feasible, and important, rewriting function to be tail-recursion can be much more efficient
  - Tail-recursive: recursive calls are tail-calls

There is a methodology that can be often guide this transformation:
  - Create a helper function that takes an accumulator
  - Old base case becomes initial accumulator
  - New base case becomes final accumulator

Methodology already seen
*)

fun old_fact n =
  if n = 0
  then 1
  else n * old_fact (n - 1)

(*
To refactor that to a function tail-call optimized

1. Create a helper function that takes an accumulator
  fun aux created an takes an aux variable that will be the accumulator

2. Old base case becomes initial accumulator
  in old_fact base case is '1'
  in new_fact initial accumulator is '1'

3. New base case becomes final accumulator
  in aux function the base case is 'acc'
*)

fun new_fact n =
  let fun aux (n, acc) =
    if n = 0
    then acc
    else aux (n-1, acc*n)
  in
    aux(n, 1)
  end

(* Another example *)

fun old_sum ([])     = 0
  | old_sum (x::xs') = x + old_sum xs'

fun new_sum xs =
    let fun aux(xs, acc) =
          case xs of
              [] => acc
            | x::xs' => aux(xs', x+acc)
    in
      aux(xs, 0)
    end

(* And Another *)

fun old_rev xs =
  case xs of
      [] => []
    | x::xs' => (rev xs) @ [x]

fun new_rev xs =
  let fun aux(xs, acc) =
    case xs of
        [] => acc
      | x::xs' => aux(xs',x::acc)
    in
      aux(xs, [])
    end

(*
For fact and sum, tail-recursive is faster but both ways linear time
Non-tail recursive rev is quadratic because each recursive call uses append, which must traverse the first list
  - And 1+2+...+(length-1) is almost length*length/2
  - Moral: beware list-append, especially within outer recursion
Cons constant-time (and fast), so accumulator version much better
*)
