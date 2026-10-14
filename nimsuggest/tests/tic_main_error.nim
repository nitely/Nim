# The main module is loaded from the NIF `nim ns` built, but not after an
# include of it was saved with a compile error: the next nimsuggest compiles it
# from source and reports the error.

include micmain_body

discard foo()

discard """
!copy fixtures/micmain_body_v1.nim micmain_body.nim
$nimsuggest --v3 --tester $file
>def $file:7:9
def;;skProc;;tic_main_error.foo;;*;;*micmain_body.nim;;1;;5;;"";;100
!copy fixtures/micmain_body_v2.nim micmain_body.nim
!restart
>chk $file:1:1
chk;;skUnknown;;;;Error;;*micmain_body.nim;;1;;19;;"undeclared identifier: *";;0
!del micmain_body.nim
"""
