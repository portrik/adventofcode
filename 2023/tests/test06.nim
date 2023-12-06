import unittest

import day06

const testFile = staticRead("input/day06.txt")

suite "Day 06":
    test "Part One":
        check(solvePartOne(testFile) == 288)

    test "Part Two":
        check(solvePartTwo(testFile) == 71503)
