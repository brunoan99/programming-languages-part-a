(* Combine Function *)

(* ('a -> 'b) * ('c -> 'a) -> 'c -> 'b *)
fun compose(f,g) = fn x => f(g(x))

(* int -> real *)
fun sqrt_of_abs i = Math.sqrt (Real.fromInt(abs i))

fun sqrt_of_abs' i = (Math.sqrt o Real.fromInt o abs) i

val sqrt_of_abs'' = Math.sqrt o Real.fromInt o abs


(* Left-to-right or right-to-left

As in math, function composition is "right-to-left"
  - "take absolute value, convert to realm and take square root"
  - "square root of the conversion to real of absolute value"

"Pipelines" of functions are common in functional programming and many programers prefer left-to-right
  - Can define our own infix operator
  - This one is very popular (and predefined) in F#

  infix |>
  fun x |> f = f x

  fun sqrt_of_abs i =
    i |> abs |> Real.fromInt |> Math.sqrt

*)

infix |>

fun x |> f = f x

fun sqrt_of_abs''' i = i |> abs |> Real.fromInt |> Math.sqrt

(* ('a -> 'b option) * ('a -> 'b) -> 'a -> 'b *)
fun backup1 (f, g) = fn x => case f x of
                                NONE => g x
                              | SOME y => y

(* ('a -> 'b) * ('a -> 'b) -> 'a -> 'b *)
fun backup2 (f, g) = fn x => f x handle _ => g x
