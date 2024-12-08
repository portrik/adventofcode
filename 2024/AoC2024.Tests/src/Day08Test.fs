module Day08Test

open Xunit

[<Fact>]
let ``Test Case First`` () : unit =
    let expected = 14

    let actual =
        Day08.first (
            [ "............"
              "........0..."
              ".....0......"
              ".......0...."
              "....0......."
              "......A....."
              "............"
              "............"
              "........A..."
              ".........A.."
              "............"
              "............" ]
            |> List.map (fun line -> line |> List.ofSeq |> List.map string)
        )

    Assert.Equal<int>(expected, actual)

[<Fact>]
let ``Test Case Second`` () : unit =
    let expected = 34

    let actual =
        Day08.second (
            [ "............"
              "........0..."
              ".....0......"
              ".......0...."
              "....0......."
              "......A....."
              "............"
              "............"
              "........A..."
              ".........A.."
              "............"
              "............" ]
            |> List.map (fun line -> line |> List.ofSeq |> List.map string)
        )

    Assert.Equal<int>(expected, actual)

// [<Fact>]
// let ``Test Real Data`` () : unit =
//     let expected = (289L, 1030L)
//     let actual = Day08.solve ()

//     Assert.Equal<int64 * int64>(expected, actual)
