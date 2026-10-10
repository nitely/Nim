import fixtures/[mreexp_user, mreexp_foo, mbox]

var b: Box[Foo]
echo b.v.x

proc bar(): int = 0#[!]#

# `mreexp_user` sees `Foo` only through `mreexp`, which re-exports
# `mreexp_foo`, and instantiates `Box[Foo]`. Editing `mreexp_foo` must recompile
# `mreexp_user` as well, which drops that instance; otherwise this module reuses
# it and its `Foo` has no field `y`.
discard """
$nimsuggest --tester --v4 $file
>chk $1
chk;;skUnknown;;;;Hint;;$file;;6;;5;;"\'bar\' is declared but not used [XDeclaredButNotUsed]";;0
!edit 'x*: int' 'x*, y*: int' fixtures/mreexp_foo.nim
!edit 'echo b.v.x' 'echo b.v.y'
>changed $path/fixtures/mreexp_foo.nim:1:1
>chk $1
chk;;skUnknown;;;;Hint;;$file;;6;;5;;"\'bar\' is declared but not used [XDeclaredButNotUsed]";;0
!edit 'x*, y*: int' 'x*: int' fixtures/mreexp_foo.nim
"""
