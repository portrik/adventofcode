import std/sequtils
import std/strutils

type Position = tuple[x: int, y: int]

func getPositions(map: seq[string], expansion: int): seq[Position] =
    var
        positions: seq[Position] = @[]
        heightExpansion = 0

    for x, row in map:
        if row.strip(chars = { '.' }).len() < 1:
            heightExpansion += 1
            continue

        var widthExpansion = 0
        for y, character in row:
            var isEmpty = true
            for line in map:
                if line[y] != '.':
                    isEmpty = false
                    break

            if isEmpty:
                widthExpansion += 1
                continue

            if character == '#':
                positions.add((x: x + (expansion * heightExpansion), y: y + (expansion * widthExpansion)))

    return positions

func getDistances(positions: seq[Position]): seq[int] =
    var distances: seq[int] = @[]
    for index, first in positions:
        for second in positions[index..^1]:
            distances.add(abs(first.x - second.x) + abs(first.y - second.y))

    return distances

func solvePartOne*(input: string): int =
    let positions = getPositions(input.splitLines().filterIt(not it.isEmptyOrWhitespace()), 1)
    let distances = getDistances(positions)

    return foldl(distances, a + b, 0)

func solvePartTwo*(input: string): int =
    let positions = getPositions(input.splitLines().filterIt(not it.isEmptyOrWhitespace()), 999_999)
    let distances = getDistances(positions)

    return foldl(distances, a + b, 0)
