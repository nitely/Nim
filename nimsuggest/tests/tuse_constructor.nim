# `use` of an object field lists where an object constructor sets it, at the
# field's name in the constructor.

type
  Foo = object
    bar: int

let f = Foo(#[!]#bar: 1)
echo f.#[!]#bar

discard """
$nimsuggest --tester $file
>use $1
def	skField	tuse_constructor.Foo.bar	int	$file	6	4	""	100
use	skField	tuse_constructor.Foo.bar	int	$file	8	12	""	100
use	skField	tuse_constructor.Foo.bar	int	$file	9	7	""	100
>use $2
def	skField	tuse_constructor.Foo.bar	int	$file	6	4	""	100
use	skField	tuse_constructor.Foo.bar	int	$file	8	12	""	100
use	skField	tuse_constructor.Foo.bar	int	$file	9	7	""	100
"""
