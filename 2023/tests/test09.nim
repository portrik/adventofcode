import unittest

import day09

const testFile = staticRead("input/day09.txt")
const testFile2 = staticRead("input/day09_02.txt")

suite("Day 09"):
    test("Part One"):
        check(solvePartOne(testFile) == 114)

    test("Part Two"):
        check(solvePartTwo(testFile2) == 5)
