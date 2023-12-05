import std/algorithm
import std/sequtils
import std/strutils

type
    Mapper = seq[tuple[target: int, source: int, length: int]]

func parseMappers(input: seq[string]): seq[Mapper] =
    var mappers: seq[Mapper] = @[]

    var current: Mapper = @[]
    for line in input:
        if line.find("map") > -1:
            if current.len() > 0:
                mappers.add(current)

            current = @[]
            continue

        let numbers = line.split(" ").filterIt(not isEmptyOrWhitespace(it)).map(parseInt)
        current.add((target: numbers[0], source: numbers[1], length: numbers[2]))

    if current.len() > 0:
        mappers.add(current)

    return mappers

func mapSeed(seed: int, mappers: seq[Mapper]): int =
    var value = seed
    for mapper in mappers:
        for (target, source, length) in mapper:
            if source <= value and value <= source + length:
                value += target - source
                break

    return value

func solvePartOne*(input: string): int =
    let lines = input.splitLines().filterIt(not isEmptyOrWhitespace(it))
    let mappers = parseMappers(lines[1..^1])
    let seeds = lines[0].split(":")[^1].split(" ").filterIt(not isEmptyOrWhitespace(it)).map(parseInt).mapIt(mapSeed(it, mappers))

    return foldl(seeds, min(a, b))

func mapBackToSeed(value: int, mappers: seq[Mapper]): int =
    var seed = value
    for mapper in mappers.reversed():
        for (target, source, length) in mapper:
            if target <= seed and seed <= target + length:
                seed += source - target
                break

    return seed

func solvePartTwo*(input: string): int =
    let lines = input.splitLines().filterIt(not isEmptyOrWhitespace(it))
    let seeds = lines[0].split(":")[^1].split(" ").filterIt(not isEmptyOrWhitespace(it)).map(parseInt)
    let mappers = parseMappers(lines[1..^1])

    var ranges: seq[seq[int]] = @[]
    var index = 0
    while index < seeds.len() - 1:
        ranges.add(@[seeds[index], seeds[index] + seeds[index + 1]])
        index += 2

    var value = 0
    while true:
        let seed = mapBackToSeed(value, mappers)

        for seedRange in ranges:
            if seedRange[0] < seed and seed < seedRange[1]:
                # No idea why, but this works for the test input while failing for the real one.
                # The real input gets answer that is off-by-one. Not sure why that happens but here we are.
                return value

        value += 1
