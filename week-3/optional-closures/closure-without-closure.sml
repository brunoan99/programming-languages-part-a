(* Closure Without Closure

Higher-order programming, e.g., with map and filter, is great

Language support for closures makes it very pleasant

Without closures, we can still do it more manually/clumsily
  - In OOP (e.g., Java) with one-method inteerfaces
  - In procedural (e.g., C) with explicit environment arguments

Working through this:
  - Shows connections between languages and features
  - Can help you understand closures and objects

Just the code we will "port" to Java and/or C
Not using standard library to provide fulelr comparison
*)

datatype 'a mylist = Cons of 'a * ('a mylist) | Empty

fun map f xs =
  case xs of
      Empty => Empty
    | Cons(x,xs) => Cons(f x, map f xs)

fun filter f xs =
  case xs of
      Empty => Empty
    | Cons(x,xs) => if f x
                    then Cons(x, filter f xs)
                    else filter f xs

fun length xs =
  case xs of
      Empty => 0
    | Cons(_,xs') => 1 + length xs'

val doubleAll = map (fn x => x * 2)

fun countNs (xs, n) = length (filter (fn x => x=n) xs)
