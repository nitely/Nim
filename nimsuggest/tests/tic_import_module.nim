# A module loaded from its NIF has no AST: `def` and `highlight` on its name in
# an import must report the module's file instead of crashing. No cursor marker:
# it would split the import, and the module would not come from its NIF.

import std/strutils

discard """
$nimsuggest --v3 --tester $file
>def $file:5:12
def;;skModule;;strutils;;;;*/pure/strutils.nim;;1;;0;;*;;100
>highlight $file:5:12
def;;skModule;;strutils;;;;*/pure/strutils.nim;;1;;0;;*;;100
"""
