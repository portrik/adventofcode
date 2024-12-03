module Day02

open System
open System.IO

let isSafeLevel (level: int seq) : bool =
    let differences =
        level |> Seq.windowed 2 |> Seq.map (fun window -> window[0] - window[1])

    let isAscending = differences |> Seq.forall (fun value -> value >= 1 && value <= 3)

    let isDescending =
        differences |> Seq.forall (fun value -> value <= -1 && value >= -3)

    isAscending || isDescending

let first (levels: int seq seq) : int =
    levels
    |> Seq.map isSafeLevel
    |> Seq.filter (fun value -> value = true)
    |> Seq.length


let isSafeLevelWithTolerance (level: int seq) : bool =
    let safeLevels =
        level
        |> Seq.mapi (fun index _value -> level |> Seq.removeAt index)
        |> Seq.map isSafeLevel
        |> Seq.filter (fun value -> value = true)
        |> Seq.length

    safeLevels > 0

let second (levels: int seq seq) : int =
    levels
    |> Seq.map isSafeLevelWithTolerance
    |> Seq.filter (fun value -> value = true)
    |> Seq.length

let solve () : (int * int) =
    let levels =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> Seq.filter (fun line -> not (String.IsNullOrWhiteSpace(line)))
        |> Seq.map (fun line -> line.Split(" ") |> Array.map int |> Seq.ofArray)

    (first levels, second levels)
