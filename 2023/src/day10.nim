import std/sequtils
import std/strutils
import std/tables

type
    Position = tuple[x: int, y: int]
    Pipe = enum Vertical, Horizontal, EastWest, L, J, Seven, F, Start, Ground
    Node = ref object
        next: Node
        previous: Node
        position: Position
        pipe: Pipe

const pipeMapper = { '|': Pipe.Vertical,
                     '-': Pipe.Horizontal,
                     'L': Pipe.L,
                     'J': Pipe.J,
                     '7': Pipe.Seven,
                     'F': Pipe.F,
                     'S': Pipe.Start }.toTable
const topPipes = [Pipe.Start, Pipe.Vertical, Pipe.J, Pipe.F]
const belowPipes = [Pipe.Start, Pipe.Vertical, Pipe.L, Pipe.J]
const leftPipes = [Pipe.Start, Pipe.Horizontal, Pipe.L, Pipe.F]
const rightPipes = [Pipe.Start, Pipe.Horizontal, Pipe.J, Pipe.Seven]

func createLoop(map: seq[string], start: Position): Node =
    let head = Node(position: start, pipe: Pipe.Start)

    if start.y > 0:
        let top = pipeMapper.getOrDefault(map[start.y - 1][start.x], Pipe.Ground)
        if topPipes.find(top) >= 0:
            head.next = Node(position: (x: start.x, y: start.y - 1), previous: head, pipe: top)

    if isNil(head.next) and start.y < map.len() - 1:
        let below = pipeMapper.getOrDefault(map[start.y + 1][start.x], Pipe.Ground)
        if belowPipes.find(below) >= 0:
            head.next = Node(position: (x: start.x, y: start.y + 1), previous: head, pipe: below)

    if isNil(head.next) and start.x > 0:
        let left = pipeMapper.getOrDefault(map[start.y][start.x - 1], Pipe.Ground)
        if leftPipes.find(left) >= 0:
            head.next = Node(position: (x: start.x - 1, y: start.y), previous: head, pipe: left)

    if isNil(head.next) and start.x < map[0].len() - 1:
        let right = pipeMapper.getOrDefault(map[start.y][start.x + 1], Pipe.Ground)
        if rightPipes.find(right) >= 0:
            head.next = Node(position: (x: start.x + 1, y: start.y), previous: head, pipe: right)

    var current = head.next
    while current.pipe != Pipe.Start:
        var nextPosition: Position = current.position
        case current.pipe:
            of Pipe.Vertical:
                if current.previous.position.y < current.position.y:
                    nextPosition.y += 1
                else:
                    nextPosition.y -= 1
            of Pipe.Horizontal:
                if current.previous.position.x < current.position.x:
                    nextPosition.x += 1
                else:
                    nextPosition.x -= 1
            of Pipe.L:
                if current.previous.position.x > current.position.x:
                    nextPosition.y -= 1
                else:
                    nextPosition.x += 1
            of Pipe.J:
                if current.previous.position.x < current.position.x:
                    nextPosition.y -= 1
                else:
                    nextPosition.x -= 1
            of Pipe.Seven:
                if current.previous.position.x < current.position.x:
                    nextPosition.y += 1
                else:
                    nextPosition.x -= 1
            of Pipe.F:
                if current.previous.position.x > current.position.x:
                    nextPosition.y += 1
                else:
                    nextPosition.x += 1
            else:
                break

        current.next = Node(position: nextPosition, pipe: pipeMapper.getOrDefault(map[nextPosition.y][nextPosition.x]), previous: current)
        current = current.next

    head.previous = current.previous
    return head

func getLength(head: Node): int =
    var length = 1
    var current = head.next
    while current.pipe != Pipe.Start:
        current = current.next
        length += 1

    # Off-by-one again for the whole input for some reason
    return length

func solvePartOne*(input: string): int =
    let map = input
                .splitLines()
                .filterIt(not it.isEmptyOrWhitespace())

    var start: Position
    for column, row in map:
        let index = row.find('S')

        if index >= 0:
            start = (x: index, y: column)
            break

    let head = createLoop(map, start)

    return getLength(head) div 2

func solvePartTwo*(input: string): int =
    let map = input
                .splitLines()
                .filterIt(not it.isEmptyOrWhitespace())

    var start: Position
    for column, row in map:
        let index = row.find('S')

        if index >= 0:
            start = (x: index, y: column)
            break

    let
        head = createLoop(map, start)
        width = map[0].len()
        height = map.len()

    var
        points = @[head.position]
        current = head.next

    while current.pipe != Pipe.Start:
        points.add(current.position)
        current = current.next

    var enclosed = 0
    for y, line in map:
        for x, character in line:
            if points.find((x: x, y: y)) >= 0:
                continue

            var
                crosses = 0
                positionX = x
                positionY = y

            while positionX < width and positionY < height:
                let point = map[positiony][positionX]
                if points.find((x: positionX, y: positionY)) >= 0 and point != 'L' and point != '7':
                    crosses += 1

                positionX += 1
                positionY += 1

            if crosses mod 2 == 1:
                enclosed += 1

    return enclosed
