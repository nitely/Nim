import fixtures/mcached_body

const n = flat(@[@[1], @[2, 3]]).len

when n != 3:
  {.error: "flat returned " & $n & " items".}

proc foo(): int = 1#[!]#

# rev 0

# The VM caches the transformed body of `flat`. The locals the transformation
# adds (the inlined `items` loop counter) get ids of the module that ran the VM,
# this one. When this module is recompiled its ids start over, so a cached body
# from the previous VM must be dropped with that VM: otherwise the destructor
# temporaries the new VM injects into `flat` get the same ids as those locals,
# share their slots, and the loop never ends.
discard """
$nimsuggest --tester --v4 $file
>chk $1
chk;;skUnknown;;;;Hint;;$file;;8;;5;;"\'foo\' is declared but not used [XDeclaredButNotUsed]";;0
!edit 'rev 0' 'rev 1'
>chk $1
chk;;skUnknown;;;;Hint;;$file;;8;;5;;"\'foo\' is declared but not used [XDeclaredButNotUsed]";;0
"""
