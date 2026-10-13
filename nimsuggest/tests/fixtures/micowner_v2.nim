import micgen

proc shift() =
  var a: Box[(char, int)]
  var b: Box[(string, char, int)]
  discard (a, b)

proc ownerVal*(): Box[(int, string)] = Box[(int, string)]()
