namespace AoC2024

open System
open Day01
open Day02

module AoC2024 =
    let entryPoint (arguments: string array) : int =
        let arguments = List.ofArray (arguments)

        let solution =
            match arguments with
            | [ "1" ]
            | [ "01" ] -> Day01.solve () |> Some
            | [ "2" ]
            | [ "02" ] -> Day02.solve () |> Some
            | [] -> printfn "The day argument is missing!" |> fun _ -> None
            | unknown ->
                unknown
                |> fun unknown -> (String.Join(",", unknown))
                |> fun day -> printfn $"Unknown day \"{day}\""
                |> fun _ -> None

        match solution with
        | Some(first, second) -> printfn $"First: {first}\nSecond: {second}" |> fun _ -> 0
        | None -> 1


    [<EntryPoint>]
    let main (arguments: string array) : int = entryPoint (arguments)
