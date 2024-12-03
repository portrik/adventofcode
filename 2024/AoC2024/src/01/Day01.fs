module Day01

open System
open System.IO

let first (left: int seq) (right: int seq) : int =
    Seq.fold2
        (fun accumulated first second -> accumulated + Int32.Abs(first - second))
        0
        (Seq.sort left)
        (Seq.sort right)

let second (left: int seq) (right: int seq) : int =
    left
    |> Seq.sort
    |> Seq.fold
        (fun accumulated current ->
            accumulated
            + (current
               * (right |> Seq.filter (fun value -> current.Equals value) |> Seq.length)))
        0

let valueFolder (accumulator: int seq * int seq) (current: int * int) : int seq * int seq =
    let (left, right) = accumulator
    let (leftValue, rightValue) = current

    let newLeft = left |> Seq.append ([ leftValue ])
    let newRight = right |> Seq.append ([ rightValue ])

    (newLeft, newRight)

let solve () : (int * int) =
    let (left, right) =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> Seq.filter (fun line -> not (String.IsNullOrWhiteSpace(line)))
        |> Seq.map (fun line -> line.Split("  ") |> Array.map int |> (fun line -> (line[0], line[1])))
        |> Seq.fold valueFolder ([], [])

    (first left right, second left right)
