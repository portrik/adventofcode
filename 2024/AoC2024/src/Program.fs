namespace AoC2024

open System

module AoC2024 =
    let handleUnknownDay (day: string) : int =
        printfn $"Unknown day \"{day}\""

        1

    let handleMissingArguments () : int =
        printfn "The day argument is missing!"

        1

    let entryPoint (arguments: string array) : int =
        let arguments = List.ofArray (arguments)

        match arguments with
        | [] -> handleMissingArguments ()
        | unknown -> handleUnknownDay (String.Join(",", unknown))


    [<EntryPoint>]
    let main (arguments: string array) : int = entryPoint (arguments)
