import unittest

import day11

const testFile = staticRead("input/day11.txt")

suite("Day 11"):
    test("Part One"):
        check(solvePartOne(testFile) == 374)

    test("Part Two"):
        check(solvePartTwo(testFile) == 82000210)
