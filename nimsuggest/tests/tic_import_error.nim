# An import saved with a compile error gets no new NIF: the next nimsuggest
# compiles it from source instead of loading the NIF of its previous version.

import micdep

discard foo()

discard """
!copy fixtures/micdep_v1.nim micdep.nim
$nimsuggest --v3 --tester $file
>def $file:6:9
def;;skProc;;micdep.foo;;*;;*micdep.nim;;1;;5;;"";;100
!copy fixtures/micdep_v3.nim micdep.nim
!restart
>def $file:6:9
def;;skProc;;micdep.foo;;*;;*micdep.nim;;2;;5;;"";;100
!del micdep.nim
"""
