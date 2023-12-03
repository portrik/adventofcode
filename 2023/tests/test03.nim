import unittest

import day03

const testFile = staticRead("input/day03.txt")

suite "Day 03":
    test "Part One":
        check(solvePartOne(testFile) == 387)

    test "Part Two":
        check(solvePartTwo(testFile) == 7838)


