import std/sequtils
import std/strutils
import std/tables

type Record = tuple[map: string, groups: seq[int]]

var cache = initTable[string, Table[int, int]]()

func normalizeLine(line: string): Record =
    let split = line
                    .split(" ")
                    .filterIt(not it.isEmptyOrWhitespace())

    let groups = if split.len() == 1: @[] else: split[^1]
                                                    .split(",")
                                                    .filterIt(not it.isEmptyOrWhitespace())
                                                    .map(parseInt)

    return (map: split[0], groups: groups)

proc getSolutions(record: Record, alreadyFinished: int = 0): int =
    if cache.hasKey($record) and cache.getOrDefault($record).hasKey(alreadyFinished):
        return cache.getOrDefault($record).getOrDefault(alreadyFinished)

    if record.map.len() < 1:
        return if record.groups.len() < 1 and alreadyFinished < 1: 1 else: 0

    var solutions = 0
    let posibilities = if record.map[0] == '?': @['.', '#'] else: @[record.map[0]]
    for character in posibilities:
        if character == '#':
            solutions += getSolutions((map: record.map[1..^1], groups: record.groups), alreadyFinished + 1)
            continue

        if alreadyFinished < 1:
            solutions += getSolutions((map: record.map[1..^1], groups: record.groups))
            continue

        if record.groups.len() > 0 and record.groups[0] == alreadyFinished:
            solutions += getSolutions((map: record.map[1..^1], groups: record.groups[1..^1]))

    if not cache.hasKey($record):
        cache[$record] = initTable[int, int]()

    cache[$record][alreadyFinished] = solutions

    return solutions

proc solvePartOne*(input: string): int =
    let counts = input
                    .splitLines()
                    .filterIt(not it.isEmptyOrWhitespace())
                    .map(normalizeLine)
                    .mapIt((map: it.map & ".", groups: it.groups))
                    .mapIt(getSolutions(it))

    return foldl(counts, a + b, 0)

proc solvePartTwo*(input: string): int =
    var records = input
                    .splitLines()
                    .filterIt(not it.isEmptyOrWhitespace())
                    .map(normalizeLine)

    for index in 0..<records.len():
        let
            group = records[index].groups
            map = records[index].map

        for step in 0..<4:
            records[index].map.add("?" & map)
            records[index].groups.add(group)

        records[index].map.add('.')

    let counts = records.mapIt(getSolutions(it))

    return foldl(counts, a + b, 0)
