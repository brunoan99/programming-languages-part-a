(*
Recursion

Should now be confortable with recursion:
  - No harder than using a loop

  - Often much easier than a loop
    - When processing a tree (e.g., evaluate an arithmetic expression)
    - Examples like appending lists
    - Avoids mutation even for local variables

  - Now:
    - How to reason about efficiency of recursion
    - The importance of tail recursion
    - Using an accumulator to achieve tail recursion
    - No new language features
*)

(*
Call-stacks

While a program runs, there is a call stack of function calls that have started but not yet returned
  - Calling a function f pushes an instance of f on the stack
  - When a call to f finishes, it is popped from the stack

These stack-frames store information like the value of local variables and "what is left to do" in the function

Due to recursion, multiple stack-frames may be calls to the same function

Example:
*)

fun fact n = if n = 0 then 1 else n * fact (n - 1)

val x = fact 3

(*
In this example each box | exp | in a block is a stack in call-stack

Function call
fact 3

--- fact 3 call fact 2

| fact 3: 3 * _   |
| fact 2          |

--- fact 2 call fact 1

| fact 3: 3 * _   |
| fact 2: 2 * _   |
| fact 1          |

--- fact 1 call fact 0

| fact 3: 3 * _   |
| fact 2: 2 * _   |
| fact 1: 1 * _   |
| fact 0          |

--- fact 0 return 1

| fact 3: 3 * _   |
| fact 2: 2 * _   |
| fact 1: 1 * _   |
| fact 0: 1       |

--- call stack pop fact 0

| fact 3: 3 * _   |
| fact 2: 2 * _   |
| fact 1: 1 * 1   |

--- call stack pop fact 1

| fact 3: 3 * _   |
| fact 2: 2 * 1   |

--- call stack pop fact 2

| fact 3: 3 * 2   |

--- call stack reach result

fact 3: 6
*)

fun fact_aux n =
  let fun aux(n, acc) =
    if n 0
    then acc
    else aux(n-1, acc*n)
  in aux(n,1)
  end

val x = fact 3

(*
Still recursive, more complicated, but the result of recursive calls is the result for the caller (no remaining multiplication)
*)

(*
In this example each box | exp | in a block is a stack in call-stack

Function call
fact_aux 3

This is what appears to happens in call-stack when then function fact_aux is called

--- fact_aux 3 call aux(3,1)

| fact_aux 3: _ |
| aux(3,1)      |

--- aux(3,1) call aux(2,3)

| fact_aux 3: _ |
| aux(3,1): _   |
| aux(2,3)      |

--- aux(2,3) call aux(1, 6)

| fact_aux 3: _ |
| aux(3,1): _   |
| aux(2,3): _   |
| aux(1,6)      |


--- aux(1,6) call aux(0, 6)

| fact_aux 3: _ |
| aux(3,1): _   |
| aux(2,3): _   |
| aux(1,6): _   |
| aux(0,6)      |

-- aux(1,6) return 6

| fact_aux 3: _ |
| aux(3,1): _   |
| aux(2,3): _   |
| aux(1,6): _   |
| aux(0,6): 6   |

--- call stack pop aux(0,6)

| fact_aux 3: _ |
| aux(3,1): _   |
| aux(2,3): _   |
| aux(1,6): 6   |

--- call stack pop aux(1,6)

| fact_aux 3: _ |
| aux(3,1): _   |
| aux(2,3): 6   |

--- call stack pop aux(2,3)

| fact_aux 3: _ |
| aux(3,1): 6   |

--- call stack pop aux(3,1)

| fact_aux 3: 6 |

--- call stack reach result

fact_aux 3: 6

But this is what really happens in call-stack when when then function fact_aux is called

| fact_aux 3: 6 |

--- fact_aux 3 call aux(3,1) and stack is reused to aux(3,1)

| aux(3,1)      |

--- aux(3,1) call aux(2,3) and stack is reused to aux(2,3)

| aux(2,3)      |

--- aux(2,3) call aux(1,6) and stack is reused to aux(1,6)

| aux(1,6)      |

--- aux(1,6) call aux(0,6) and stack is reused to aux(0,6)

| aux(0,6)      |

--- aux(1,6) return 6

| aux(0,6): 6   |

--- call-stach reach the result

fact_aux 3: 6

*)

(*
An optimization

It is unnecessary to keeep around a stack-frame just so it can get a callee's result and return it without any further evaluation

ML recognizes these tail calls in the compiler and treats them differently:
  - Pop the caller before the call, allowing calee to reuse the same stack space
  - (Along with other optimizations,) as efficient as a loop

Reasonable to assume all functional-language implementations do tail-call optiomization
*)
