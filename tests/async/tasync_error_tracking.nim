import std/asyncdispatch

block:
  type MyError* = object of ValueError

  proc foo() {.async, raises: [MyError].} =
    try:
      echo "foo"
    except ValueError as err:
      raise newException(MyError, "myerr")

  proc main {.async.} =
    await foo()

  waitFor main()
