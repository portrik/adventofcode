import std/strutils
import std/sequtils

const colors = ["red", "green", "blue"]
const maxValues = [12, 13, 14]

proc isPossibleConfiguration(configuration: array[3, int]): bool =
    for index, value in maxValues:
        if configuration[index] > value:
            return false

    return true

proc gameToConfiguration(line: string): array[3, int] =
    let rounds = line.split(":")[1]
        .split(";")
        .mapIt(it
            .split(",")
            .mapit(it
                .split(" ")
                .filterIt(not isEmptyOrWhitespace(it))))

    var configuration = [0, 0, 0]
    for round in rounds:
        for value in round:
            let count = parseInt(value[0])
            let index = colors.find(value[1])

            if count > configuration[index]:
                configuration[index] = count

    return configuration

proc gameToId(game: string): int =
    return parseInt(game.split(":")[0].split(" ")[^1])

proc solvePartOne*(input: string): int =
    let numbers = splitLines(input)
        .filterIt(not isEmptyOrWhitespace(it))
        .filterIt(isPossibleConfiguration(gameToConfiguration(it)))
        .map(gameToId)

    return foldl(numbers, a + b, 0)

proc solvePartTwo*(input: string): int =
    let configurations = splitLines(input)
        .filterIt(not isEmptyOrWhitespace(it))
        .map(gameToConfiguration)

    let powers = configurations.mapIt(foldl(it, a * b, 1))

    return foldl(powers, a + b, 0)

