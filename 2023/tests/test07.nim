import unittest

import day07

const testFile = staticRead("input/day07.txt")

suite("Day 07"):
    test("Part One"):
        check(solvePartOne(testFile) == 6440)

    test("Part Two"):
        check(solvePartTwo(testFile) == 5905)
