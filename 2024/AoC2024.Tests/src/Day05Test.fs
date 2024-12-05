module Day05Tests

open Xunit

[<Fact>]
let ``Test Case First`` () : unit =
    let expected = 143

    let actual =
        Day05.first
            [ (47, 53)
              (97, 13)
              (97, 61)
              (75, 29)
              (61, 13)
              (75, 29)
              (29, 13)
              (97, 29)
              (53, 29)
              (61, 53)
              (97, 53)
              (61, 29)
              (47, 13)
              (75, 47)
              (97, 75)
              (47, 61)
              (75, 61)
              (47, 61)
              (75, 61)
              (47, 29)
              (75, 13)
              (53, 13) ]
            [ [ 75; 47; 61; 53; 29 ]
              [ 97; 61; 53; 29; 13 ]
              [ 75; 29; 13 ]
              [ 75; 97; 47; 61; 53 ]
              [ 61; 13; 29 ]
              [ 97; 13; 75; 29; 47 ] ]

    Assert.Equal<int>(expected, actual)

[<Fact>]
let ``Test Case Second`` () : unit =
    let expected = 123

    let actual =
        Day05.second
            [ (47, 53)
              (97, 13)
              (97, 61)
              (75, 29)
              (61, 13)
              (75, 29)
              (29, 13)
              (97, 29)
              (53, 29)
              (61, 53)
              (97, 53)
              (61, 29)
              (47, 13)
              (75, 47)
              (97, 75)
              (47, 61)
              (75, 61)
              (47, 61)
              (75, 61)
              (47, 29)
              (75, 13)
              (53, 13) ]
            [ [ 75; 47; 61; 53; 29 ]
              [ 97; 61; 53; 29; 13 ]
              [ 75; 29; 13 ]
              [ 75; 97; 47; 61; 53 ]
              [ 61; 13; 29 ]
              [ 97; 13; 75; 29; 47 ] ]

    Assert.Equal<int>(expected, actual)

// [<Fact>]
// let ``Test Real Data`` () : unit =
//     let expected = (4957, 6938)
//     let actual = Day05.solve ()

//     Assert.Equal<int * int>(expected, actual)
