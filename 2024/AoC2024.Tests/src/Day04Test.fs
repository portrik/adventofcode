module Day04Tests

open Xunit

[<Fact>]
let ``Test Case First`` () : unit =
    let expected = 18

    let actual =
        Day04.first (
            [ "MMMSXXMASM"
              "MSAMXMSMSA"
              "AMXSXMAAMM"
              "MSAMASMSMX"
              "XMASAMXAMM"
              "XXAMMXXAMA"
              "SMSMSASXSS"
              "SAXAMASAAA"
              "MAMMMXMMMM"
              "MXMXAXMASX" ]
            |> List.map (fun value -> value |> List.ofSeq |> List.map string)
        )

    Assert.Equal<int>(expected, actual)

[<Fact>]
let ``Test Case Second`` () : unit =
    let expected = 9

    let actual =
        Day04.second (
            [ "MMMSXXMASM"
              "MSAMXMSMSA"
              "AMXSXMAAMM"
              "MSAMASMSMX"
              "XMASAMXAMM"
              "XXAMMXXAMA"
              "SMSMSASXSS"
              "SAXAMASAAA"
              "MAMMMXMMMM"
              "MXMXAXMASX" ]
            |> List.map (fun value -> value |> List.ofSeq |> List.map string)
        )

    Assert.Equal<int>(expected, actual)

// [<Fact>]
// let ``Test Real Data`` () : unit =
//     let expected = (2514, 1888)
//     let actual = Day04.solve()

//     Assert.Equal<int * int>(expected, actual)
