import fixtures/mmid_middle

let x: int = middle()

# `mmid_leaf` is imported only through `mmid_middle`. Changing it must mark this
# module dirty as well, so that a `chk` from the project root recompiles it.
discard """
$nimsuggest --tester --v4 $file
>chk $file:1:1
chk;;skUnknown;;;;Hint;;$file;;3;;4;;"\'x\' is declared but not used [XDeclaredButNotUsed]";;0
!edit 'Leaf* = int' 'Leaf* = string' fixtures/mmid_leaf.nim
>changed $path/fixtures/mmid_leaf.nim:1:1
>chk $file:1:1
chk;;skUnknown;;;;Error;;$file;;3;;19;;"type mismatch: got \'Leaf\' for \'middle()\' but expected \'int\'";;0
!edit 'Leaf* = string' 'Leaf* = int' fixtures/mmid_leaf.nim
"""
