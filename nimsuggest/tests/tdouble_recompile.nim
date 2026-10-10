import fixtures/[mtwice_count, mtwice, mtwice_user]

proc foo(): int = twice() + user()#[!]#

when compileCount > 1:
  {.error: "mtwice was compiled more than once".}

# Editing `mtwice_leaf` makes `mtwice`, `mtwice_user` and this module dirty.
# The `chk` must recompile each of them once: recompiling `mtwice_leaf` must not
# mark `mtwice` dirty again after it was already recompiled in the same pass,
# or `mtwice_user` would recompile it a second time.
discard """
$nimsuggest --tester --v4 $file
>chk $1
chk;;skUnknown;;;;Hint;;$file;;3;;5;;"\'foo\' is declared but not used [XDeclaredButNotUsed]";;0
!edit 'Leaf* = int' 'Leaf* = int16' fixtures/mtwice_leaf.nim
>changed $path/fixtures/mtwice_leaf.nim:1:1
>chk $1
chk;;skUnknown;;;;Hint;;$file;;3;;5;;"\'foo\' is declared but not used [XDeclaredButNotUsed]";;0
!edit 'Leaf* = int16' 'Leaf* = int' fixtures/mtwice_leaf.nim
"""
