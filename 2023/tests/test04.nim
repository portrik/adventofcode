import unittest

import day04

const testFile = staticRead("input/day04.txt")

suite "Day 03":
    test "Part One":
        check(solvePartOne(testFile) == 13)

    test "Part Two":
        check(solvePartTwo(testFile) == 30)


