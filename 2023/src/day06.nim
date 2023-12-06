import std/sequtils
import std/strutils

func solvePartOne*(input: string): int =
    let numberRows = input
                        .splitLines()
                        .filterIt(not isEmptyOrWhitespace(it))
                        .mapIt(it.split(":")[^1])
                        .mapIt(it.split(" ").filterIt(not isEmptyOrWhitespace(it))
                                                            .map(parseInt))

    let races = toSeq(0..numberRows[0].len() - 1)
                    .mapIt((time: numberRows[0][it], distance: numberRows[1][it]))

    var total = 1
    for (time, distance) in races:
        var current = 0
        for holding in 0..time:
            if (time - holding) * holding > distance:
                current += 1

        if current > 0:
            total *= current

    return total

proc solvePartTwo*(input: string): int =
    let race = input
                .splitLines()
                .filterIt(not isEmptyOrWhitespace(it))
                .mapIt(it.split(":")[^1])
                .mapIt(it.replace(" ", ""))
                .map(parseInt)

    var total = 0
    for holding in 0..race[0]:
        if (race[0] - holding) * holding > race[1]:
            total += 1

    return total
