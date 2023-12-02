import unittest

import day02

const testFile = staticRead("input/day02.txt")

suite "Day 02":
    test "Part One":
        check(solvePartOne(testFile) == 8)

    test "Part Two":
        check(solvePartTwo(testFile) == 2286)
