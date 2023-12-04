import std/tables
import std/sequtils
import std/strutils

type Card = tuple[winning: seq[int], has: seq[int], value: int, id: int]

func pow(value: int, exponent: int): int =
    var powed: int = value
    for index in 0..exponent - 1:
        powed *= value

    return powed

func lineToCard(line: string): Card =
    let id = parseInt(line.split(":")[0].split(" ")[^1]) - 1
    let numbers = line.split(":")[1].split("|")
    let winning = numbers[0].split(" ").filterIt(not isEmptyOrWhitespace(it)).map(parseInt)
    let has = numbers[1].split(" ").filterIt(not isEmptyOrWhitespace(it)).map(parseInt)

    var value: int = 0
    for winner in winning:
        if has.find(winner) > -1:
            value += 1

    return (winning: winning, has: has, value: value, id: id)

func solvePartOne*(input: string): int =
    let cards = input.splitLines().filterIt(not isEmptyOrWhitespace(it)).map(lineToCard)
    let values = cards.mapIt((if it.value < 2: it.value else: pow(2, it.value - 2)))

    return foldl(values, a + b, 0)

func solvePartTwo*(input: string): int =
    let cards = input.splitLines().filterIt(not isEmptyOrWhitespace(it)).map(lineToCard)

    var lookup = initTable[int, int]()
    for card in cards.filterIt(it.value == 0):
        lookup[card.id] = 1

    var sum = 0

    var toCheck: seq[Card] = cards
    while toCheck.len() > 0:
        var value = 1
        var hasAll = true
        let current = toCheck.pop()

        for index in current.id + 1..current.id + current.value:
            if lookup.hasKey(index):
                value += lookup[index]
                continue

            hasAll = false
            toCheck.insert(cards[index], 0)

        if not hasAll:
            toCheck.insert(current, 0)
            continue

        lookup[current.id] = value
        sum += value

    return sum
