import std/options
import std/sequtils
import std/strutils

type Ratio = tuple[value: int, x: int, y: int]

proc toEnginePart(schema: seq[string], startX: int, startY: int,
        value: string): int =
    let minX = (if startX > 0: startX - 1 else: startX)
    let maxX = (if startX < schema.len() - 1: startX + 1 else: startX)
    let minY = (if startY > 0: startY - 1 else: startY)
    let maxY = (if (startY + value.len()) < schema[startX].len(): startY +
            value.len() else: startY + value.len() - 1)

    for x in minX..maxX:
        for y in minY..maxY:
            if schema[x][y] != '.' and not isDigit(schema[x][y]):
                return parseInt(value)

    return 0

proc solvePartOne*(input: string): int =
    var sum: int = 0

    let schema: seq[string] = splitLines(input)
        .filterIt(not isEmptyOrWhitespace(it))

    for row in 0..schema.len() - 1:
        var currentValue: string = ""

        for column in 0..schema[row].len() - 1:
            if isDigit(schema[row][column]):
                currentValue.add($schema[row][column])

            if (not isDigit(schema[row][column]) or
                    column == schema[row].len() - 1) and currentValue != "":
                sum += toEnginePart(schema, row, column - currentValue.len(), currentValue)
                currentValue = ""

    return sum

proc toGearRatio(schema: seq[string], startX: int, startY: int,
        value: string): Option[Ratio] =
    let minX = (if startX > 0: startX - 1 else: startX)
    let maxX = (if startX < schema.len() - 1: startX + 1 else: startX)
    let minY = (if startY > 0: startY - 1 else: startY)
    let maxY = (if (startY + value.len()) < schema[startX].len(): startY +
            value.len() else: startY + value.len() - 1)

    for x in minX..maxX:
        for y in minY..maxY:
            if schema[x][y] == '*':
                return some((value: parseInt(value), x: x, y: y))

    return none(Ratio)

proc solvePartTwo*(input: string): int =
    var sum: int = 0

    let schema: seq[string] = splitLines(input)
        .filterIt(not isEmptyOrWhitespace(it))

    var ratios: seq[Ratio] = @[]
    for row in 0..schema.len() - 1:
        var currentValue: string = ""

        for column in 0..schema[row].len() - 1:
            if isDigit(schema[row][column]):
                currentValue.add($schema[row][column])

            if (not isDigit(schema[row][column]) or
                    column == schema[row].len() - 1) and currentValue != "":
                let possibleRatio = toGearRatio(schema, row, column -
                        currentValue.len(), currentValue)
                currentValue = ""

                if possibleRatio.isNone():
                    continue

                let ratio = possibleRatio.get()
                let match = ratios.filterIt(it.x == ratio.x and it.y == ratio.y)

                if match.len() < 1:
                    ratios.add(ratio)
                    continue

                let index = ratios.find(match[0])
                sum += ratio.value * ratios[index].value
                ratios.delete(index)

    return sum
