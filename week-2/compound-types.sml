(*
Building Compound Types

Already know:
  - Have various base types like int bool unit char
  - Ways to build (nested) compound types: tuples, lists, options

First: 3 most important type building-blocks in any language
  - "Each of": A t value contains value of each of t1 t2 ... tn
  - "One of": A t value contains value of one of t1 t2 ... tn
  - "Self reference": A t value can refer to other t value

Remarkable: A lot of data can be described with just these building blocks

Examples:
  Tuples build each-of types
    - int * bool contains an int and a bool

  Options build one-of types
    - int option contains and int or it contains no data

  List use all three building blocks
    - int list contains an int and another int list or it contains no data

  And of course we can nest compound tyeps
    - (( int * int) option * (int list list)) option

Another way to build each-of types in ML
  - Records: have named fields
  - Connection to tuples and idea of syntatic sugar

*)
