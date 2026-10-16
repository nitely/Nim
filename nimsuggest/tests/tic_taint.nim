# Code from an unsaved buffer is never written to the NIF cache, and a query only
# sees the unsaved buffer it names: other files are read as saved, before and
# after a restart.

import mictaint, mictaintuser

discard getX(Foo())

discard """
$nimsuggest --v3 --tester $file
>def $file:7:9
def;;skProc;;mictaintuser.getX;;proc (f: Foo): int*;;*mictaintuser.nim;;3;;5;;"";;100
>def $path/mictaint.nim;$path/fixtures/mictaint_dirty.nim:3:4
def;;skField;;mictaint.Foo.x;;string;;*mictaint.nim;;3;;4;;"";;100
>def $file:7:9
def;;skProc;;mictaintuser.getX;;proc (f: Foo): int*;;*mictaintuser.nim;;3;;5;;"";;100
!restart
>def $file:7:9
def;;skProc;;mictaintuser.getX;;proc (f: Foo): int*;;*mictaintuser.nim;;3;;5;;"";;100
"""
