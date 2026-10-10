import fixtures/mforeign_hook

type Bar = object
  s: seq[string]

var barCalls {.compileTime.} = 0

proc useFoo(): int =
  var f = Foo(s: @[1, 2])
  f.s.len

proc useBar(): int =
  inc barCalls
  var b = Bar(s: @["a"])
  b.s.len

const n = useFoo() + useBar()

when barCalls != 1:
  {.error: "useBar ran " & $barCalls & " times".}

proc foo(): int = 1#[!]#

# rev 0

# `useFoo` lifts the hooks of `Foo`, a type of another module, so they get ids of
# this module. When this module is recompiled its ids start over, and the hooks
# must be dropped with it: otherwise `Foo` keeps the previous `=destroy`, the
# new compile does not lift it again, and `useBar` gets the id the old
# `=destroy` had. The VM finds procs by id, so destroying `f` then runs `useBar`.
discard """
$nimsuggest --tester --v4 $file
>chk $1
chk;;skUnknown;;;;Hint;;$file;;17;;6;;"\'n\' is declared but not used [XDeclaredButNotUsed]";;0
chk;;skUnknown;;;;Hint;;$file;;22;;5;;"\'foo\' is declared but not used [XDeclaredButNotUsed]";;0
!edit 'rev 0' 'rev 1'
>chk $1
chk;;skUnknown;;;;Hint;;$file;;17;;6;;"\'n\' is declared but not used [XDeclaredButNotUsed]";;0
chk;;skUnknown;;;;Hint;;$file;;22;;5;;"\'foo\' is declared but not used [XDeclaredButNotUsed]";;0
"""
