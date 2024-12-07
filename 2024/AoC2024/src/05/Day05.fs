module Day05

open System.IO
open System

type Page =
    { value: int
      mutable previous: Page list
      mutable next: Page list }

let foldLinkedPages (accumulator: Map<int, Page>) ((preceding, next): int * int) : Map<int, Page> =
    let precedingPage =
        match (Map.containsKey preceding accumulator) with
        | false ->
            { value = preceding
              previous = []
              next = [] }
        | true -> accumulator[preceding]

    let nextPage =
        match (Map.containsKey next accumulator) with
        | false ->
            { value = next
              previous = []
              next = [] }
        | true -> accumulator[next]

    precedingPage.next <- [ nextPage ] |> List.append (precedingPage.next)
    nextPage.previous <- [ precedingPage ] |> List.append (nextPage.previous)

    let accumulatorWithPreceding =
        accumulator |> Map.change preceding (fun _current -> Some(precedingPage))

    let accumulatorWithNext =
        accumulatorWithPreceding |> Map.change next (fun _current -> Some(nextPage))

    accumulatorWithNext

let validatePrint (print: int list) (rules: Map<int, Page>) : bool =
    print
    |> List.mapi (fun index value ->
        match rules |> Map.containsKey (value) with
        | false -> true
        | true ->
            print[0 .. (index - 1)]
            |> List.forall (fun previous ->
                not (List.exists (fun innerValue -> previous = innerValue.value) rules[value].next)))
    |> List.forall (fun value -> value = true)

let first (rules: (int * int) list) (printOrder: int list list) : int =
    let ordering = rules |> List.fold foldLinkedPages (Map [])

    printOrder
    |> List.filter (fun print -> validatePrint print ordering)
    |> List.map (fun print -> print |> List.item (List.length (print) / 2))
    |> List.sum

let fixComparer (left: Page) (right: Page) : int =
    let leftIsPrevious =
        right.previous |> List.exists (fun value -> value.value = left.value)

    let rightIsPrevious =
        left.previous |> List.exists (fun value -> value.value = right.value)

    match (leftIsPrevious, rightIsPrevious) with
    | (false, false)
    | (true, true) -> 0
    | (true, false) -> -1
    | (false, true) -> 1

let fixPrint (print: int list) (ordering: Map<int, Page>) : int list =
    print
    |> List.map (fun value ->
        match ordering |> Map.containsKey (value) with
        | false ->
            { value = value
              previous = []
              next = [] }
        | true -> ordering[value])
    |> List.sortWith fixComparer
    |> List.map (fun page -> page.value)

let second (rules: (int * int) list) (printOrder: int list list) : int =
    let ordering = rules |> List.fold foldLinkedPages (Map [])

    printOrder
    |> List.filter (fun print -> not (validatePrint print ordering))
    |> List.map (fun print -> fixPrint print ordering)
    |> List.map (fun print -> print |> List.item (List.length (print) / 2))
    |> List.sum

let solve () : (int64 * int64) =
    let input =
        Path.Combine(__SOURCE_DIRECTORY__, "input.txt")
        |> File.ReadAllLines
        |> List.ofSeq

    let emptyLineIndex =
        input |> List.findIndex (fun value -> String.IsNullOrWhiteSpace(value))

    let (rules, printOrder) = input |> List.splitAt emptyLineIndex

    let rules =
        rules
        |> List.map (fun line ->
            line.Split("|")
            |> (fun numbers -> (Int32.Parse(numbers[0]), Int32.Parse(numbers[1]))))

    let printOrder =
        printOrder
        |> List.filter (fun line -> not (String.IsNullOrWhiteSpace(line)))
        |> List.map (fun order -> order.Split(",") |> List.ofArray |> List.map Int32.Parse)

    (first rules printOrder, second rules printOrder)
