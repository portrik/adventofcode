import std/sequtils
import std/strutils

func getRows(startRow: seq[int]): seq[seq[int]] =
    var rows = @[startRow]

    while foldl(rows[^1], a + b, 0) != 0:
        var newRow: seq[int] = @[]

        for index, value in rows[^1][0..^2]:
            newRow.add(rows[^1][index + 1] - value)

        rows.add(newRow)

    for index in countdown(rows.len() - 1, 1):
        rows[index - 1].add(rows[index - 1][^1] + rows[index][^1])
        rows[index - 1].insert(rows[index - 1][0] - rows[index][0], 0)

    return rows

func solvePartOne*(input: string): int =
    let series = input
                    .splitLines()
                    .filterIt(not isEmptyOrWhitespace(it))
                    .mapIt(it
                            .split(" ")
                            .filterIt(not isEmptyOrWhitespace(it))
                            .map(parseInt)
                    )
                    .map(getRows)

    return foldl(series, a + b[0][^1], 0)

func solvePartTwo*(input: string): int =
    let series = input
                    .splitLines()
                    .filterIt(not isEmptyOrWhitespace(it))
                    .mapIt(it
                            .split(" ")
                            .filterIt(not isEmptyOrWhitespace(it))
                            .map(parseInt)
                    )
                    .map(getRows)

    return foldl(series, a + b[0][0], 0)
