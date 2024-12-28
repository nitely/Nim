import std/asyncdispatch

type MyError = object of ValueError

proc err(throw: bool) =
  if throw:
    raise newException(MyError, "myerr")

block:
  proc foo() {.async, raises: [MyError].} =
    err(false)

  proc main {.async, raises: [MyError].} =
    await foo()

  waitFor main()

block:
  proc foo() {.async, raises: [MyError].} =
    err(false)

  proc bar(fut: FutureTracked[void, (MyError,)]) {.async, raises: [MyError].} =
    await fut

  proc main {.async, raises: [MyError].} =
    let fooFut = trackFuture foo()
    await bar(fooFut)

  waitFor main()
