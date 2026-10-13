# An import whose included file was saved with a compile error gets no new NIF:
# the next nimsuggest compiles it from source instead of loading the NIF of its
# previous version.

import micinc

discard foo()

discard """
!copy fixtures/micinc_body_v1.nim micinc_body.nim
$nimsuggest --v3 --tester $file
>def $file:7:9
def;;skProc;;micinc.foo;;*;;*micinc_body.nim;;1;;5;;"";;100
!copy fixtures/micinc_body_v3.nim micinc_body.nim
!restart
>def $file:7:9
def;;skProc;;micinc.foo;;*;;*micinc_body.nim;;2;;5;;"";;100
!del micinc_body.nim
"""
