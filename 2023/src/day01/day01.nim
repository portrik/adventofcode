import std/strutils

const puzzleInput = staticRead("input.txt")
const wordDigits = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]

proc solvePartOne*(input: string = puzzleInput): Natural =
    var sum: Natural = 0

    for line in splitLines(input):
        if line.isEmptyOrWhitespace():
            break

        var currentValue: string = ""
        for character in line:
            try:
                let digit = parseInt($character)
                currentValue.add($digit)
            except ValueError: discard

        sum += parseInt(currentValue[0] & currentValue[^1])

    return sum

proc solvePartTwo*(input: string = puzzleInput): Natural =
    var sum: Natural = 0

    for line in splitLines(input):
        if line.isEmptyOrWhitespace():
            break

        var currentValue: string = ""
        var index: Natural = 0
        while index < line.len():
            try:
                let digit = parseInt($line[index])
                currentValue.add($digit)
            except ValueError:
                for wordIndex, word in wordDigits:
                    if index + word.len() - 1 < line.len() and line[index..index + word.len() - 1] == word:
                        currentValue.add($(wordIndex + 1))
                        index += word.len() - 2
                        break
            finally:
                index += 1

        sum += parseInt(currentValue[0] & currentValue[^1])

    return sum
