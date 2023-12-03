import std/os
import std/strformat
import std/strutils

import day01 as day01
import day02 as day02
import day03 as day03

const days = [
    [day01.solvePartOne, day01.solvePartTwo],
    [day02.solvePartOne, day02.solvePartTwo],
    [day03.solvePartOne, day03.solvePartTwo]]

when isMainModule:
    let parameter = paramStr(1)

    var index = high(int)
    try:
        index = parseInt(parameter) - 1
    except Exception: discard

    doAssert(index < days.len(), fmt"Unknown day '{parameter}'!")

    let input = readFile(fmt"src/input/{index + 1}.txt")

    echo fmt"Part one: {days[index][0](input)}"
    echo fmt"Part two: {days[index][1](input)}"
