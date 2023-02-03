(*
The REPL


REPL:

Read-Eval-Print-Loop is well named

Cand just treat it as a strange/convenient way to run programs
  - But more convenient for quick try-something-out
  - Then move things over to a testing file for easy reuse

use "foo.sml" is an unusual expression
It enters bindings from the file foo.sml
Result is () bound to variable it
  - Ignorable

For reasons discussed in next segment, do not use use without restarting the REPL session
  - But using it for multiple files at beginning of session is okay.

Errors:

Mistakes could be:

Syntax: What you wrote means nothing or not the construct you intended

Type-checking: What you wrote does not type-check

Evaluation: It runs but produces wrong answer, or an exception, or an infinite loop

*)
