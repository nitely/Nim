import std/str#[!]#utils

type Color = enum
  re#[!]#d
  green

discard ord(Color.red) + ord(green)
export toUpp#[!]#erAscii
discard "x".toUpperAscii

discard """
$nimsuggest --tester --v4 $file
>highlight $1
def;;skModule;;strutils;;;;*/tv4_highlight.nim;;1;;11;;*
>highlight $2
def;;skEnumField;;tv4_highlight.Color.red;;*;;*/tv4_highlight.nim;;4;;2;;*
def;;skEnumField;;tv4_highlight.Color.red;;*;;*/tv4_highlight.nim;;4;;2;;*
use;;skEnumField;;tv4_highlight.Color.red;;*;;*/tv4_highlight.nim;;7;;18;;*
>highlight $3
use;;skFunc;;strutils.toUpperAscii;;*;;*/tv4_highlight.nim;;8;;7;;*
use;;skFunc;;strutils.toUpperAscii;;*;;*/tv4_highlight.nim;;9;;12;;*
"""
