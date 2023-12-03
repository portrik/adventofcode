import std/strutils
import std/sequtils

const wordDigits = ["one", "two", "three", "four", "five", "six", "seven",
        "eight", "nine"]

func solvePartOne*(input: string): int =
    let numbers = splitLines(input)
        .filterIt(not isEmptyOrWhitespace(it))
        .mapIt(it.filter(isDigit))
        .mapIt(parseInt(it[0] & it[^1]))

    return foldl(numbers, a + b, 0)

func mapLineToNumbers(line: string): int =
    var digits = ""

    var index = 0
    while index < line.len():
        if isDigit(line[index]):
            digits.add(line[index])
            index += 1
            continue

        for wordIndex, word in wordDigits:
            if index + word.len() - 1 >= line.len() or line[index..(index +
                    word.len() - 1)] != word:
                continue

            digits.add($(wordIndex + 1))
            index += word.len() - 2
            break

        index += 1

    return parseInt(digits[0] & digits[^1])

func solvePartTwo*(input: string): int =
    let numbers = splitLines(input)
        .filterIt(not isEmptyOrWhitespace(it))
        .map(mapLineToNumbers)

    return foldl(numbers, a + b, 0)
