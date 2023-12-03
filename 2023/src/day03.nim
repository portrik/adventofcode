import sugar

import std/options
import std/sequtils
import std/strutils

type
    Position = tuple[x: int, y: int]
    Gear = tuple[value: int, position: Position]
    Schema = seq[string]
    Condition = (character: char) -> bool

proc isEnginePart(character: char): bool =
    return character != '.' and not isDigit(character)

proc isRatiodGear(character: char): bool =
    return character == '*'

proc getEnginePart(schema: Schema, position: Position, part: string, condition: Condition): Option[Gear] =
    var
        minX = position.x
        maxX = position.x
        minY = position.y
        maxY = position.y + part.len() - 1

    if position.x > 0:
        minX -= 1

    if position.x < schema.len() - 1:
        maxX += 1

    if position.y > 0:
        minY -= 1

    if (position.y + part.len()) < schema[position.x].len():
        maxY += 1

    for x in minX..maxX:
        for y in minY..maxY:
            if condition(schema[x][y]):
                return some((value: parseInt(part), position: (x: x, y: y)))

    return none(Gear)

proc solvePartOne*(input: string): int =
    var sum: int = 0

    let schema: seq[string] = splitLines(input).filterIt(not isEmptyOrWhitespace(it))

    for row in 0..schema.len() - 1:
        var currentValue: string = ""

        for column in 0..schema[row].len() - 1:
            if isDigit(schema[row][column]):
                currentValue.add($schema[row][column])

            let isEndOfNumber = not isDigit(schema[row][column])
            let isEndOfLine = column == schema[row].len() - 1
            if (isEndOfNumber or isEndOfLine) and currentValue != "":
                let part = getEnginePart(schema, (x: row, y: column - currentValue.len()), currentValue, isEnginePart)
                sum += (if part.isSome(): part.get().value else: 0)
                currentValue = ""

    return sum

proc solvePartTwo*(input: string): int =
    var sum: int = 0

    let schema: seq[string] = splitLines(input).filterIt(not isEmptyOrWhitespace(it))

    var ratios: seq[Gear] = @[]
    for row in 0..schema.len() - 1:
        var currentValue: string = ""

        for column in 0..schema[row].len() - 1:
            if isDigit(schema[row][column]):
                currentValue.add($schema[row][column])

            let isEndOfNumber = not isDigit(schema[row][column])
            let isEndOfLine = column == schema[row].len() - 1
            if (isEndOfNumber or isEndOfLine) and currentValue != "":
                let possibleRatio = getEnginePart(schema, (x: row, y: column - currentValue.len()), currentValue, isRatiodGear)
                currentValue = ""

                if possibleRatio.isNone():
                    continue

                let ratio = possibleRatio.get()
                let match = ratios.filterIt(it.position == ratio.position)

                if match.len() < 1:
                    ratios.add(ratio)
                    continue

                let index = ratios.find(match[0])
                sum += ratio.value * ratios[index].value
                ratios.delete(index)

    return sum
