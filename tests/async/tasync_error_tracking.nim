import std/asyncdispatch

type MyError = object of ValueError

proc err =
  raise newException(MyError, "myerr")

block:
  proc foo() {.async, raises: [MyError].} =
    err()

  proc main {.async.} =
    await foo()

  waitFor main()

block:
  proc foo() {.async, raises: [MyError].} =
    err()

  proc bar(fut: FutureTracked[void, (MyError,)]) {.async, raises: [MyError].} =
    await fut

  proc main {.async.} =
    let fooFut = trackFuture foo()
    await bar(fooFut)

  waitFor main()
