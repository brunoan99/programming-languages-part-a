(*
Abstract Data Types With Closures

Implementing an ADT

Closures can implement abstract data types
  - Can put multiple functions in a record
  - The functions can share the same private data
  - Private data can be mutable or immutable
  - Feels a lot like obbjects, emphasizing that OOP and functional programming have some deep similarities

See code for an implementation of immutable integer sets with operations insert, member, and size

The actual code is advanced/clever/tricky, but has no new features
  - Combines lexical scope, datatypes, records, closures, etc.
  - Client use is not so tricky
*)

datatype set = s of { insert : int -> set,
                      member : int -> bool,
                      size   : unit -> int }

val empty_set =
  let
    fun make_set xs =
      let
        fun contains i = List.exists (fn j => i=j) xs
      in
        s { insert  = fn i =>   if contains i
                                then make_set xs
                                else make_set (i::xs),
            member  = contains,
            size    = fn () => length xs }
      end
  in
    make_set []
  end

(* example client *)
fun use_sets () = (* unit -> int *)
  let val s s1 = empty_set
      val s s2 = (#insert s1) 34 (* s1.insert(34) *)
      val s s3 = (#insert s2) 34 (* s2.insert(34) *)
      val s s4 = #insert s3 19 (* s3.insert(19) *)
      (* s4 -> 19,34 *)
  in
    if (#member s4) 42
    then 99
    else if (#member s4) 19
    then 17 + (#size s3) ()
    else 0
  end
