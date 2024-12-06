module Day06Tests

open Xunit

[<Fact>]
let ``Test Case First`` () : unit =
    let expected = 41

    let actual =
        Day06.first (
            [ "....#....."
              ".........#"
              ".........."
              "..#......."
              ".......#.."
              ".........."
              ".#..^....."
              "........#."
              "#........."
              "......#..." ]
            |> List.map (fun value -> value |> List.ofSeq |> List.map string)
        )

    Assert.Equal<int>(expected, actual)

[<Fact>]
let ``Test Case Second`` () : unit =
    let expected = 6

    let actual =
        Day06.second (
            [ "....#....."
              ".........#"
              ".........."
              "..#......."
              ".......#.."
              ".........."
              ".#..^....."
              "........#."
              "#........."
              "......#..." ]
            |> List.map (fun value -> value |> List.ofSeq |> List.map string)
        )

    Assert.Equal<int>(expected, actual)

// [<Fact>]
// let ``Test Real Data`` () : unit =
//     let expected = (5242, 1424)

//     let actual = Day06.solve ()

//     Assert.Equal<int * int>(expected, actual)
