module Day02

open System
open System.IO

let isSafeLevel (level: int list) : bool =
    let differences =
        level |> List.windowed 2 |> List.map (fun window -> window[0] - window[1])

    let isAscending = differences |> List.forall (fun value -> value >= 1 && value <= 3)

    let isDescending =
        differences |> List.forall (fun value -> value <= -1 && value >= -3)

    isAscending || isDescending

let first (levels: int list list) : int =
    levels
    |> List.map isSafeLevel
    |> List.filter (fun value -> value = true)
    |> List.length


let isSafeLevelWithTolerance (level: int list) : bool =
    let safeLevels =
        level
        |> List.mapi (fun index _value -> level |> List.removeAt index)
        |> List.map isSafeLevel
        |> List.filter (fun value -> value = true)
        |> List.length

    safeLevels > 0

let second (levels: int list list) : int =
    levels
    |> List.map isSafeLevelWithTolerance
    |> List.filter (fun value -> value = true)
    |> List.length

let solve () : (int * int) =
    let levels =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> Seq.filter (fun line -> not (String.IsNullOrWhiteSpace(line)))
        |> Seq.map (fun line -> line.Split(" ") |> Array.map int |> List.ofArray)
        |> List.ofSeq

    (first levels, second levels)
