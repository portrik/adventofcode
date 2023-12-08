import std/math
import std/sequtils
import std/strutils

type
    NodeParts = tuple[id: string, left: string, right: string]
    Node = ref object
        left: Node
        right: Node
        id: string

func find(source: seq[Node], id: string): Node =
    for node in source:
        if node.id == id:
            return node

func lineToStrings(line: string): NodeParts =
    let split = line.split("=").filterIt(not isEmptyOrWhitespace(it))
    let id = split[0].strip()
    let directions = split[^1]
                        .split(",")
                        .filterIt(not isEmptyOrWhitespace(it))
                        .mapIt(it.strip().strip(chars={'(', ')'}))

    return (id: id, left: directions[0], right: directions[1])

func getNodes(definitions: seq[string]): seq[Node] =
    let formatted = definitions.map(lineToStrings)
    let nodes = formatted.mapIt(Node(id: it.id))

    for index, node in nodes:
        node.left = find(nodes, formatted[index].left)
        node.right = find(nodes, formatted[index].right)

    return nodes

proc distanceToEnd(node: Node, instructions: string, isEnd: proc (id: string): bool): int =
    var distance = 0

    var current = node
    while not isEnd(current.id):
        for instruction in instructions:
            distance += 1

            if instruction == 'R':
                current = current.right
                continue

            current = current.left

    return distance

proc solvePartOne*(input: string): int =
    let split = input.splitLines().filterIt(not isEmptyOrWhitespace(it))
    let instructions = split[0].strip()
    let start = find(getNodes(split[1..^1]), "AAA")

    return distanceToEnd(start, instructions, proc (id: string): bool = id == "ZZZ")


proc solvePartTwo*(input: string): int =
    let split = input.splitLines().filterIt(not isEmptyOrWhitespace(it))
    let instructions = split[0].strip()

    let ghostNodes = getNodes(split[1..^1])
                        .filterIt(it.id[^1] == 'A')
                        .mapIt(distanceToEnd(it, instructions, proc (id: string): bool = id[^1] == 'Z'))

    return lcm(ghostNodes)
