module Day02Tests

open Xunit

[<Fact>]
let ``Test Case First`` () : unit =
    let expected = 2

    let actual =
        Day02.first (
            [ [ 7; 6; 4; 2; 1 ]
              [ 1; 2; 7; 8; 9 ]
              [ 9; 7; 6; 2; 1 ]
              [ 1; 3; 2; 4; 5 ]
              [ 8; 6; 4; 4; 1 ]
              [ 1; 3; 6; 7; 9 ] ]
        )

    Assert.Equal<int>(expected, actual)

[<Fact>]
let ``Test Case Second`` () : unit =
    let expected = 4

    let actual =
        Day02.second (
            [ [ 7; 6; 4; 2; 1 ]
              [ 1; 2; 7; 8; 9 ]
              [ 9; 7; 6; 2; 1 ]
              [ 1; 3; 2; 4; 5 ]
              [ 8; 6; 4; 4; 1 ]
              [ 1; 3; 6; 7; 9 ] ]
        )

    Assert.Equal<int>(expected, actual)

// [<Fact>]
// let ``Test Real Data`` () : unit =
//     let expected = (639, 674)
//     let actual = Day02.solve ()

//     Assert.Equal<int * int>(expected, actual)
