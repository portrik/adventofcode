module Day01

open System
open System.IO

let first (left: int list) (right: int list) : int =
    List.fold2
        (fun accumulated first second -> accumulated + Int32.Abs(first - second))
        0
        (List.sort left)
        (List.sort right)

let second (left: int list) (right: int list) : int =
    left
    |> List.sort
    |> List.fold
        (fun accumulated current ->
            accumulated
            + (current
               * (right |> List.filter (fun value -> current.Equals value) |> List.length)))
        0

let valueFolder (accumulator: int list * int list) (current: int * int) : int list * int list =
    let (left, right) = accumulator
    let (leftValue, rightValue) = current

    let newLeft = left |> List.append ([ leftValue ])
    let newRight = right |> List.append ([ rightValue ])

    (newLeft, newRight)

let solve () : (int * int) =
    let (left, right) =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> Seq.filter (fun line -> not (String.IsNullOrWhiteSpace(line)))
        |> Seq.map (fun line -> line.Split("  ") |> Array.map int |> (fun line -> (line[0], line[1])))
        |> Seq.fold valueFolder ([], [])

    (first left right, second left right)
