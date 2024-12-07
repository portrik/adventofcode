module Day07

open System.IO
open System

let rec getAllCombinations (values: int64 list) (results: int64 list) : int64 list =
    let current = values |> List.tryItem 0

    let values =
        match current with
        | None -> []
        | Some _ -> values |> List.removeAt 0

    let results =
        match current with
        | None -> results
        | Some value ->
            if (results |> List.length) < 1 then
                [ value ]
            else
                (List.append
                    (results |> List.map (fun result -> result + value))
                    (results |> List.map (fun result -> result * value)))

    match current with
    | None -> results
    | Some _ -> getAllCombinations values results

let first (input: (int64 * int64 list) list) : int64 =
    input
    |> List.map (fun (result, values) ->
        if (getAllCombinations values []) |> List.exists (fun value -> value = result) then
            result
        else
            0)
    |> List.sum

let appendToResults (results: int64 list) (value: int64) : int64 list =
    let addition = results |> List.map (fun result -> result + value)
    let multiplication = results |> List.map (fun result -> result * value)

    let concatenation =
        results
        |> List.map (fun result -> String.Join("", [ result.ToString(); value.ToString() ]) |> Int64.Parse)

    addition |> List.append multiplication |> List.append concatenation

let rec getAllCombinationsWithConcat (values: int64 list) (results: int64 list) : int64 list =
    let current = values |> List.tryItem 0

    let values =
        match current with
        | None -> []
        | Some _ -> values |> List.removeAt 0

    let results =
        match current with
        | None -> results
        | Some value ->
            if (results |> List.length) < 1 then
                [ value ]
            else
                appendToResults results value

    match current with
    | None -> results
    | Some _ -> getAllCombinationsWithConcat values results

let second (input: (int64 * int64 list) list) : int64 =
    input
    |> List.map (fun (result, values) ->
        if
            (getAllCombinationsWithConcat values [])
            |> List.exists (fun value -> value = result)
        then
            result
        else
            0)
    |> List.sum

let mapInput (value: string list) : (int64 * int64 list) =
    let result = value |> List.item 0 |> Int64.Parse

    let rest =
        value
        |> List.item 1
        |> (fun value -> value.Split(" ") |> List.ofArray)
        |> List.filter (fun value -> not (String.IsNullOrWhiteSpace(value)))
        |> List.map Int64.Parse

    (result, rest)

let solve () : (int64 * int64) =
    let input =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> Seq.map (fun line -> line.Split(":") |> List.ofArray)
        |> Seq.map mapInput
        |> List.ofSeq

    (first input, second input)
