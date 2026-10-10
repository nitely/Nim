proc flat*(s: seq[seq[int]]): seq[int] =
  for x in s:
    result.add x & x[0 .. ^1]
  result.setLen 3
