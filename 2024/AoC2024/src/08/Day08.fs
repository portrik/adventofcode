module Day08

open System.IO

let calculateAntiNodePositions ((leftX, leftY): int * int) ((rightX, rightY): int * int) : (int * int) list =
    let (vectorX, vectorY) = (rightX - leftX, rightY - leftY)
    let upper = (leftX - vectorX, leftY - vectorY)
    let lower = (rightX + vectorX, rightY + vectorY)

    [ upper; lower ]

let first (map: string list list) : int =
    // Not sure why F# parses the 1 in index + 1 as a function :shrug:
    let one = 1
    let rowCount = map |> List.length
    let columnCount = map |> List.item 0 |> List.length

    map
    |> List.mapi (fun row line ->
        line
        |> List.mapi (fun column value ->
            match value with
            | "." -> None
            | value -> Some((row, column), value)))
    |> List.collect id
    |> List.filter Option.isSome
    |> List.map Option.get
    |> List.groupBy (fun (_position, value) -> value)
    |> List.map (fun (_value, groupings) ->
        groupings
        |> List.mapi (fun index value -> List.allPairs [ value ] groupings[(index + one) ..])
        |> List.collect id)
    |> List.map (fun groupings ->
        groupings
        |> List.map (fun ((leftPosition, _value), (rightPosition, _value)) ->
            calculateAntiNodePositions leftPosition rightPosition)
        |> List.collect id)
    |> List.collect id
    |> Set.ofList
    |> Set.filter (fun (x, y) -> x >= 0 && x < rowCount && y >= 0 && y < columnCount)
    |> Set.count

let rec projectLine
    ((pointX, pointY): int * int)
    ((vectorX, vectorY): int * int)
    (direction: int)
    (antiNodes: (int * int) list)
    (maxX: int)
    (maxY: int)
    : (int * int) list =
    let newPoint = (pointX + (vectorX * direction), pointY + (vectorY * direction))

    match newPoint with
    | (x, y) when x >= 0 && x < maxX && y >= 0 && y < maxY ->
        projectLine (x, y) (vectorX, vectorY) direction (antiNodes |> List.append [ (x, y) ]) maxX maxY
    | _ -> antiNodes

let calculateAntiNodePositionsInfinite
    ((leftX, leftY): int * int)
    ((rightX, rightY): int * int)
    (maxX: int)
    (maxY: int)
    : (int * int) list =
    let vector = (rightX - leftX, rightY - leftY)

    projectLine (leftX, leftY) vector -1 [ (leftX, leftY) ] maxX maxY
    |> List.append (projectLine (leftX, leftY) vector 1 [] maxX maxY)

let second (map: string list list) : int =
    // Not sure why F# parses the 1 in index + 1 as a function :shrug:
    let one = 1
    let rowCount = map |> List.length
    let columnCount = map |> List.item 0 |> List.length

    map
    |> List.mapi (fun row line ->
        line
        |> List.mapi (fun column value ->
            match value with
            | "." -> None
            | value -> Some((row, column), value)))
    |> List.collect id
    |> List.filter Option.isSome
    |> List.map Option.get
    |> List.groupBy (fun (_position, value) -> value)
    |> List.map (fun (_value, groupings) ->
        groupings
        |> List.mapi (fun index value -> List.allPairs [ value ] groupings[(index + one) ..])
        |> List.collect id)
    |> List.map (fun groupings ->
        groupings
        |> List.map (fun ((leftPosition, _value), (rightPosition, _value)) ->
            calculateAntiNodePositionsInfinite leftPosition rightPosition rowCount columnCount)
        |> List.collect id)
    |> List.collect id
    |> Set.ofList
    |> Set.count

let solve () : (int64 * int64) =
    let input =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> Seq.map (fun line -> line |> List.ofSeq |> List.map string)
        |> List.ofSeq

    (first input, second input)
