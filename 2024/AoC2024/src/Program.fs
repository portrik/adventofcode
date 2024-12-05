namespace AoC2024

open System

module AoC2024 =
    let entryPoint (arguments: string array) : int =
        let arguments = List.ofArray (arguments)

        let solution =
            match arguments with
            | [ "1" ]
            | [ "01" ] -> Day01.solve () |> Some
            | [ "2" ]
            | [ "02" ] -> Day02.solve () |> Some
            | [ "3" ]
            | [ "03" ] -> Day03.solve () |> Some
            | [ "4" ]
            | [ "04" ] -> Day04.solve () |> Some
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
