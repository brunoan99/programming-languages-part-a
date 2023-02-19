(*
Map and Filter
*)

fun map (f,xs) =
  case xs of
      [] => []
    | x'::xs' => (f x')::map(f,xs')

val x1 = map((fn x => x + 1), [4,8,12,16])
val x2 = map(hd, [[1,2],[3,4],[5,6,7]])

(*
val map : ('a -> 'b) * 'a list -> 'b list

Map is, without doubt, in the "higher-order function hall-of-fame"
  - The name is standard (for any data structure)
  - It is used all the time once you know it: saves a little space, but more importantly, communicates what you are doing
  - Similar predefined function: List.map
    - But it uses currying

*)

fun filter (f,xs) =
  case xs of
      [] => []
    | x'::xs' =>  if f(x')
                  then x'::filter(f,xs')
                  else filter(f,xs')

fun is_even v = v mod 2 = 0

fun all_even xs = filter(is_even, xs)

fun all_even_snd xs = filter((fn (_,v) => is_even v), xs)

(*
val filter : ('a -> bool) * 'a list -> 'a list

Filter is also in the hall of fame
  - So use it whenever ytour computation is a filter
  - Similar predefined function: List.filter
    - But it uses currying

*)
