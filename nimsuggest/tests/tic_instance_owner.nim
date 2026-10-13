# `micowner` and `micuser` both use `Box[(int, string)]`, and `micowner`
# instantiates it first. After `micowner` changes, `micuser` still has
# `Box[(int, string)]`, not whatever instance takes its place in `micowner`.

import micowner, micuser

discard ownerVal()
discard userVal()

discard """
!copy fixtures/micowner_v1.nim micowner.nim
$nimsuggest --v3 --tester $file
>def $file:8:9
def;;skProc;;micuser.userVal;;proc (): Box[(int, string)]*;;*micuser.nim;;3;;5;;"";;100
!copy fixtures/micowner_v2.nim micowner.nim
!restart
>def $file:8:9
def;;skProc;;micuser.userVal;;proc (): Box[(int, string)]*;;*micuser.nim;;3;;5;;"";;100
!del micowner.nim
"""
