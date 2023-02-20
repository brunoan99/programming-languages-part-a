(*
Closures and Recomputation

When Things Evaluate

  Things we know:
    - A function body is not evaluated until the function is called
    - A function body is evaluated every time the function is called
    - A variable binding evaluates its expression when the binding is evaluated, not every time the variable is used

  With closures, this means we can avoid repeating computations that do not depend on function arguments
    - Not so worried about performance, but good example to emphasize the semantics of functions
*)

(* ('a -> boll) * 'a list -> 'a list *)
fun filter (f, xs) =
  case xs of
      [] => []
    | x'::xs' =>  if f x'
                  then x'::(filter(f, xs'))
                  else filter(f, xs')

(* ( string list * string) -> string list *)
fun allShorterThan1 (xs, s) = filter(fn x => String.size x < String.size s, xs)
(* In this example the filter recursive call the computation String.size s will be done *)
fun allShorterThan1' (xs, s) =
  filter(fn x => (print "!"; String.size x < String.size s), xs)
(* verify in REPL using this version *)

(* ( string list * string) -> string list *)
fun allShorterThan2 (xs, s) =
  let
    val i = String.size s
  in
    filter(fn x => String.size x < i, xs)
  end
(* In this example defining i as string 's' size, and passing it to function in filter call, we use the variable property of being evaluated just one time to avoid recomputate String.size s in each filter recursive call *)
