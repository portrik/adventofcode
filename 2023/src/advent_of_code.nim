import std/os
import std/strformat
import std/strutils

import day01 as day01
import day02 as day02
import day03 as day03
import day04 as day04
import day05 as day05

# To use with solutions that have side effects, mainly for usage of Option.
# https://forum.nim-lang.org/t/3318#20981
type Solution = proc (input: string): int{.nimcall, noSideEffect}

const days: seq[array[2, Solution]] = @[
    [day01.solvePartOne, day01.solvePartTwo],
    [day02.solvePartOne, day02.solvePartTwo],
    [cast[Solution](day03.solvePartOne), cast[Solution](day03.solvePartTwo)],
    [day04.solvePartOne,day04.solvePartTwo],
    [day05.solvePartOne,day05.solvePartTwo]]

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
