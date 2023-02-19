(*
What is functional programming?

"Functional programming" can mean a few different things:

1. Avoiding mutation in most/all cases (done and ongoing)

2. Using functions as values

- Style encouraging recursion and recursive data structures
- Style closer to mathematical definitions
- Programming idioms using laziness

Not sure a definition of "functional language" exists beyond "makes functional programming easy / the default / required"
  - No clear yes/no for a particular language
*)

(*
First-class functions

Can use them wherever we use values
  - Functions are values too
  - Arguments, results, parts of tuples, bound to variables, carried by datatype constructors or exceptions, ...

*)

fun double x = 2 * x

fun incr x = x + 1

val a_tuple = (double, incr, double(incr 7))

(*
Most common use is as an argument / result of another function
  - Other function is called a high-order function
  - Powerful way to factor out common functionality
*)
