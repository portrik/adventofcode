import std/algorithm
import std/sequtils
import std/strutils

type
    Hand = enum FiveOfAKind, FourOfAKind, FullHouse, ThreeOfAKind, TwoPair, OnePair, HighCard
    CardHand = tuple[cards: string, bid: int, handType: Hand]

const handStrength = [Hand.FiveOfAKind, Hand.FourOfAKind, Hand.FullHouse,
                        Hand.ThreeOfAKind, Hand.TwoPair, Hand.OnePair, Hand.HighCard]
const cardStrength = ['A', 'K', 'Q', 'J', 'T', '9', '8', '7', '6', '5', '4', '3', '2']
const jokerCardStrength = ['A', 'K', 'Q', 'T', '9', '8', '7', '6', '5', '4', '3', '2', 'J']

func cardCounstToHand(counts: seq[int]): Hand =
    if counts[0] == 5:
        return Hand.FiveOfAKind

    if counts[0] == 4:
        return Hand.FourOfAKind

    if counts[0] == 3:
        if counts[1] == 2:
            return Hand.FullHouse

        return Hand.ThreeOfAKind

    if counts[0] == 2:
        if counts[1] == 2:
            return Hand.TwoPair

        return Hand.OnePair

    return Hand.HighCard

func compareHands(left: CardHand, right: CardHand, cardStrengths: array[0..12, char]): int =
    let
        leftStrength = handStrength.find(left.handType)
        rightStrength = handStrength.find(right.handType)

    if leftStrength < rightStrength:
        return 1
    elif rightStrength < leftStrength:
        return 0

    for index, card in left.cards:
        let
            leftCard = cardStrengths.find(card)
            rightCard = cardStrengths.find(right.cards[index])

        if leftCard == rightCard:
            continue

        if leftCard < rightCard:
            return 1

        return 0

func getHandType(cards: string): Hand =
    var replaceable = cards
    var counts: seq[int] = @[]

    for character in cards:
        let count = replaceable.count(character)
        if count < 1:
            continue

        counts.add(count)
        replaceable = replaceable.replace($character)

    counts.sort(SortOrder.Descending)

    return cardCounstToHand(counts)

func getJokerHandType(cards: string): Hand =
    var replaceable = cards
    var counts: seq[int] = @[]

    for character in cards:
        let count = replaceable.count(character)
        if count < 1:
            continue

        counts.add(count)
        replaceable = replaceable.replace($character)

    counts.sort(SortOrder.Descending)

    let jokers = cards.count('J')
    if jokers > 0 and jokers < 5:
        counts.delete(counts.find(jokers))
        counts[0] += jokers

    return cardCounstToHand(counts)

func solvePartOne*(input: string):int =
    let cardHands: seq[CardHand] = input
                            .splitLines()
                            .filterIt(not isEmptyOrWhitespace(it))
                            .mapIt(it.split(" ").filterIt(not isEmptyOrWhitespace(it)))
                            .mapIt((cards: it[0], bid: parseInt(it[1]), handType: getHandType(it[0])))
                            .sorted(proc (left: CardHand, right: CardHand): int = compareHands(left, right, cardStrength))

    var winnings = 0
    for index, hand in cardHands:
        winnings += (index + 1) * hand.bid

    return winnings

func solvePartTwo*(input: string): int =
    let cardHands: seq[CardHand] = input
                            .splitLines()
                            .filterIt(not isEmptyOrWhitespace(it))
                            .mapIt(it.split(" ").filterIt(not isEmptyOrWhitespace(it)))
                            .mapIt((cards: it[0], bid: parseInt(it[1]), handType: getJokerHandType(it[0])))
                            .sorted(proc (left: CardHand, right: CardHand): int = compareHands(left, right, jokerCardStrength))

    var winnings = 0
    for index, hand in cardHands:
        winnings += (index + 1) * hand.bid

    return winnings
