module Day03

open System.IO
open System.Text.RegularExpressions

type State = { enabled: bool; value: int32 }

let multiplyMatch (regexMatch: Match) : int =
    let left = regexMatch.Groups["left"].ToString() |> int32
    let right = regexMatch.Groups["right"].ToString() |> int32

    left * right

let first (instructions: string) : int =
    let pattern = @"mul\((?<left>\d{1,3}),(?<right>\d{1,3})\)"

    Regex.Matches(instructions, pattern) |> Seq.map multiplyMatch |> Seq.sum

let handleInstruction (state: State) (regexMatch: Match) : State =
    match regexMatch.Value with
    | "do()" -> { enabled = true; value = state.value }
    | "don't()" -> { enabled = false; value = state.value }
    | _ ->
        match state.enabled with
        | false -> state
        | true ->
            { enabled = true
              value = state.value + multiplyMatch regexMatch }

let second (instructions: string) : int =
    let pattern = @"(do\(\)|don't\(\)|mul\((?<left>\d{1,3}),(?<right>\d{1,3})\))"

    Regex.Matches(instructions, pattern)
    |> Seq.fold handleInstruction { enabled = true; value = 0 }
    |> (fun state -> state.value)


let solve () : (int64 * int64) =
    let instructions =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt") |> File.ReadAllText

    (first instructions, second instructions)
