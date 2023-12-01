import std/os
import std/strformat

import day01/day01


when isMainModule:
    let day = paramStr(1)

    case day:
        of "1":
            echo fmt"Part One: {solvePartOne()}"
            echo fmt"Part Two: {solvePartTwo()}"
        else:
            echo fmt"Day {day} is not implemented."
