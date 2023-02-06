(*
Tuples and Syntatic Sugar
*)

val a_pair = (3+1,4+2);
(* val a_pair = (4, 6) : int * int *)
val a_record = {second=4+2, first=3+1};
(* val a_record = {first=4,second=6} : {first:int, second:int} *)
val another_pair = {2=5, 1=6};
(* val another_pair = (6,5) : int * int *)

(*
In ML there is no Tuples, are just Records

Tuples are just another way to write Records, tuples are just
syntatic sugar for records.
*)

(*
Tuple syntax is just a different way to write certain records
  (e1, ..., en) is another way of writing { 1=e1, ..., n=en }
  t1 * ... * tn is another way of writing { 1 : t1, ..., n : tn }
  In other words, records with field names 1, 2, ...

In fact, this is how ML actually defines tuples
  - Other than special syntax in programs and printing, they don't exist
  - You really can writh {1=4, 2=7, 3=9}, but it's bad style

Another example: andalso and orelse vs if then else
*)
