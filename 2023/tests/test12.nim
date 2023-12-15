import unittest

import day12

const testFile = staticRead("input/day12.txt")

suite("Day 12"):
    test("Part One"):
        check(solvePartOne(testFile) == 21)

    test("Part Two"):
        check(solvepartTwo(testFile) == 525152)
