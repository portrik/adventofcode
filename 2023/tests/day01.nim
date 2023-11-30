import day01/day01

doAssert solvePartOne() == 1
doAssert solvePartTwo() == 2

doAssertRaises(ValueError):
  raise newException(ValueError, "specific errors")
