module Day06

open System.IO

exception AbsolutePanic of string

type direction =
    | UP
    | DOWN
    | RIGHT
    | LEFT

let directionToCharacter (direction: direction) : string =
    match direction with
    | UP -> "^"
    | RIGHT -> ">"
    | DOWN -> "v"
    | LEFT -> "<"

let replaceAtPosition (map: string list list) (x: int) (y: int) (value: string) : (string list list) =
    map
    |> List.mapi (fun xIndex row ->
        if xIndex = x then
            row |> List.mapi (fun yIndex column -> if yIndex = y then value else column)
        else
            row)

let checkDirection (map: string list list) (x: int) (y: int) (direction: direction) : direction option =
    let isOutOfBounds =
        (x < 0 || x >= (List.length map)) || (y < 0 || y >= (List.length map[0]))

    let value =
        match isOutOfBounds with
        | true -> None
        | false -> Some((map |> List.item x |> List.item y).Equals("#"))

    match value with
    | None -> None
    | Some isBlocked ->
        match isBlocked with
        | false -> Some direction
        | true ->
            (match direction with
             | UP -> RIGHT
             | RIGHT -> DOWN
             | DOWN -> LEFT
             | LEFT -> UP)
            |> Some


let getPosition (map: string list list) : (((int * int) * direction) option) =
    let row =
        map
        |> List.tryFindIndex (fun row ->
            row
            |> List.tryFindIndex (fun value -> not (value.Equals(".") || value.Equals("#")))
            |> Option.isSome)

    let column =
        match row with
        | Some row ->
            map
            |> List.item row
            |> List.findIndex (fun value -> not (value.Equals(".") || value.Equals("#")))
            |> Some
        | None -> None

    let position =
        match row, column with
        | Some row, Some column -> Some(row, column)
        | _ -> None

    let direction =
        match position with
        | Some(row, column) ->
            (match map |> List.item row |> List.item column with
             | "^" -> UP
             | "v" -> DOWN
             | "<" -> LEFT
             | ">" -> RIGHT
             | _ -> raise (AbsolutePanic "invalid position index"))
            |> Some
        | None -> None

    match position, direction with
    | Some position, Some direction -> Some(position, direction)
    | _ -> None

let handleMovement
    (map: string list list)
    (visited: (int * int) list)
    (position: int * int)
    (direction: direction)
    : (string list list option * (int * int) list) =
    let (x, y) = position
    let newVisited = visited |> List.append [ position ]

    let removedGuardMap = replaceAtPosition map x y "."

    let (newX, newY) =
        match direction with
        | UP -> (x - 1, y)
        | DOWN -> (x + 1, y)
        | LEFT -> (x, y - 1)
        | RIGHT -> (x, y + 1)

    let newMap =
        match (checkDirection map newX newY direction) with
        | None -> None
        | Some newDirection ->
            (if direction = newDirection then
                 (replaceAtPosition removedGuardMap newX newY (directionToCharacter newDirection))
             else
                 (replaceAtPosition removedGuardMap x y (directionToCharacter newDirection)))
            |> Some

    (newMap, newVisited)

let rec moveGuard
    (map: string list list option)
    (visited: (int * int) list)
    : (string list list option * (int * int) list) =
    let position =
        match map with
        | None -> None
        | Some map -> getPosition map

    let (newMap, newVisited) =
        match position with
        | None -> (None, visited)
        | Some(position, direction) -> handleMovement (Option.get map) visited position direction

    match newMap with
    | None -> (None, newVisited)
    | Some newestMap -> moveGuard (Some newestMap) newVisited

let first (input: string list list) : int =
    let (_empty_map, visited) = moveGuard (Some input) []

    visited |> Set.ofList |> Set.count

let handleMovementInfinite
    (map: string list list)
    (visited: Set<int * int * direction>)
    (position: int * int)
    (direction: direction)
    : (string list list option * Set<int * int * direction>) =
    let (x, y) = position
    let newVisited = visited |> Set.add (x, y, direction)

    let removedGuardMap = replaceAtPosition map x y "."

    let (newX, newY) =
        match direction with
        | UP -> (x - 1, y)
        | DOWN -> (x + 1, y)
        | LEFT -> (x, y - 1)
        | RIGHT -> (x, y + 1)

    let newMap =
        match (checkDirection map newX newY direction) with
        | None -> None
        | Some newDirection ->
            (if direction = newDirection then
                 (replaceAtPosition removedGuardMap newX newY (directionToCharacter newDirection))
             else
                 (replaceAtPosition removedGuardMap x y (directionToCharacter newDirection)))
            |> Some

    (newMap, newVisited)

let rec moveGuardInfinite
    (map: string list list option)
    (visited: Set<int * int * direction>)
    : (string list list option * Set<int * int * direction> * bool) =
    let position =
        match map with
        | None -> None
        | Some map -> getPosition map

    let isLoop =
        match position with
        | None -> false
        | Some((x, y), direction) -> visited |> Set.contains (x, y, direction)

    let (newMap, newVisited) =
        match position with
        | None -> (None, visited)
        | Some(position, direction) -> handleMovementInfinite (Option.get map) visited position direction

    match (newMap, isLoop) with
    | (_, true) -> (None, newVisited, true)
    | (None, false) -> (None, newVisited, false)
    | (Some newestMap, false) -> moveGuardInfinite (Some newestMap) newVisited

let moveInfiniteWithPrint (index: int) (value: string list list) (length: int) : bool =
    let result = moveGuardInfinite (Some value) (Set [])

    let percent = float (index) / float (length) * 100.0 |> round
    // printfn $"{percent} Percent ({index}/{length})"

    match result with
    | (_, _, false) -> false
    | (_, _, true) -> true

let createCombination (map: string list list) (x: int) (y: int) : (string list list option) =
    let replacedValue = map |> List.item x |> List.item y

    match replacedValue with
    | "." -> (Some(replaceAtPosition map x y "#"))
    | _ -> None

let second (input: string list list) : int =
    let (_empty_map, visited) = moveGuard (Some input) []

    let combinations =
        visited
        |> Set.ofList
        |> List.ofSeq
        |> List.map (fun (x, y) -> createCombination input x y)
        |> List.filter Option.isSome
        |> List.map Option.get

    let length = combinations |> List.length

    combinations
    |> List.mapi (fun index value -> moveInfiniteWithPrint index value length)
    |> List.filter (fun value -> value = true)
    |> List.length

let solve () : (int64 * int64) =
    let input =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> List.ofArray
        |> List.map (fun line -> line |> List.ofSeq |> List.map string)

    (first input, second input)
