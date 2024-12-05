module Day04

open System.IO
open System

let matchesVertical (input: string list list) (row: int) (column: int) (count: int) (value: string list) : bool =
    let vertical =
        seq { (row - count + 1) .. row }
        |> Seq.map (fun value -> input[value][column])
        |> List.ofSeq

    vertical.Equals(value) || List.rev(vertical).Equals(value)

let matchesLeftDiagonal (input: string list list) (row: int) (column: int) (count: int) (value: string list) : bool =
    let rows = seq { (row - count + 1) .. row }
    let columns = seq { (column - count + 1) .. column } |> Seq.rev

    let diagonal =
        Seq.map2 (fun row column -> input[row][column]) rows columns |> List.ofSeq

    diagonal.Equals(value) || List.rev(diagonal).Equals(value)

let matchesRightDiagonal (input: string list list) (row: int) (column: int) (count: int) (value: string list) : bool =
    let rows = seq { (row - count + 1) .. row }
    let columns = seq { (column) .. (column + count - 1) }

    let diagonal =
        Seq.map2 (fun row column -> input[row][column]) rows columns |> List.ofSeq

    diagonal.Equals(value) || List.rev(diagonal).Equals(value)

let getMatchCount (input: string list list) (row: int) (column: int) (patternLength: int) (pattern: string list) : int =
    let horizontal =
        match column with
        | column when column < (patternLength - 1) -> 0
        | column ->
            if
                (input[row][column - patternLength + 1 .. column]).Equals(pattern)
                || List.rev(input[row][column - patternLength + 1 .. column]).Equals(pattern)
            then
                1
            else
                0

    let vertical =
        match row with
        | row when row < (patternLength - 1) -> 0
        | row ->
            if matchesVertical input row column patternLength pattern then
                1
            else
                0

    let leftDiagonal =
        match row, column with
        | row, column when row < (patternLength - 1) || column < (patternLength - 1) -> 0
        | row, column ->
            if matchesLeftDiagonal input row column patternLength pattern then
                1
            else
                0

    let rightDiagonal =
        match row, column with
        | row, column when row < (patternLength - 1) || column > (List.length (input[row]) - patternLength) -> 0
        | row, column ->
            if matchesRightDiagonal input row column patternLength pattern then
                1
            else
                0

    horizontal + vertical + leftDiagonal + rightDiagonal

let first (input: string list list) : int =
    let pattern = "XMAS" |> List.ofSeq |> List.map string
    let patternLength = pattern |> List.length

    input
    |> List.mapi (fun rowIndex row ->
        row
        |> List.mapi (fun columnIndex _column -> getMatchCount input rowIndex columnIndex patternLength pattern))
    |> List.collect id
    |> List.sum

let matchesCross (input: string list list) (row: int) (column: int) (pattern: string list) : bool =
    let center = input |> List.item row |> List.item column
    let bottomRight = input |> List.item (row - 1) |> List.item (column - 1)
    let bottomLeft = input |> List.item (row - 1) |> List.item (column + 1)
    let topRight = input |> List.item (row + 1) |> List.item (column - 1)
    let topLeft = input |> List.item (row + 1) |> List.item (column + 1)

    let left = [ topLeft; center; bottomRight ]
    let right = [ topRight; center; bottomLeft ]

    (left.Equals(pattern) || left.Equals(List.rev(pattern))) && (right.Equals(pattern) || right.Equals(List.rev(pattern)))

let getCrossCount (input: string list list) (row: int) (column: int) (patternLength: int) (pattern: string list) : int =
    let canBeCross =
        (input |> List.item row |> List.item column).Equals("A")
        && row > 0
        && row < (List.length (input) - 1)
        && column > 0
        && column < (List.length (input[row]) - 1)

    let isMatch =
        match canBeCross with
        | false -> false
        | true -> matchesCross input row column pattern

    if isMatch then 1 else 0

let second (input: string list list) : int =
    let pattern = "MAS" |> List.ofSeq |> List.map string
    let patternLength = pattern |> List.length

    input
    |> List.mapi (fun rowIndex row ->
        row
        |> List.mapi (fun columnIndex _column -> getCrossCount input rowIndex columnIndex patternLength pattern))
    |> List.collect id
    |> List.sum

let solve () : int * int =
    let input =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> Seq.map (fun value -> value |> List.ofSeq |> List.map string)
        |> List.ofSeq

    (first input, second input)
