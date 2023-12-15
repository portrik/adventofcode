import unittest

import day10

const testFile = staticRead("input/day10.txt")
const testFile2 = staticRead("input/day10_02.txt")

suite("Day 10"):
    test("Part One"):
        check(solvePartOne(testFile) == 8)

    test("Part Two"):
        check(solvePartTwo(testFile2) == 4)
