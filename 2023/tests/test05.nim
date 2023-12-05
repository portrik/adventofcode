import unittest

import day05

const testFile = staticRead("input/day05.txt")

suite "Day 05":
    test "Part One":
        check(solvePartOne(testFile) == 35)

    test "Part Two":
        check(solvePartTwo(testFile) == 46)
