import unittest

import day01/day01

const testFile = staticRead("input/day01.txt")
const testFileTwo = staticRead("input/day01_02.txt")

suite "Day 01":
    test "Part One":
        check(solvePartOne(testFile) == 142)

    test "Part Two":
        check(solvePartTwo(testFileTwo) == 443)
