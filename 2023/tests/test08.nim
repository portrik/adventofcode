import unittest

import day08

const testFile = staticRead("input/day08.txt")
const testFile2 = staticRead("input/day08_02.txt")

suite("Day 08"):
    test("Part One"):
        check(solvePartOne(testFile) == 2)

    test("Part Two"):
        check(solvePartTwo(testFile2) == 6)
