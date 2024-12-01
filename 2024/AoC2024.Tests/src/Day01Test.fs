module Day01Tests

open Xunit
open Day01

[<Fact>]
let ``Test Case First`` () : unit =
    let expected = 11
    let actual = Day01.first [ 3; 4; 2; 1; 3; 3 ] [ 4; 3; 5; 3; 9; 3 ]

    Assert.Equal<int>(expected, actual)

[<Fact>]
let ``Test Case Second`` () : unit =
    let expected = 31
    let actual = Day01.second [ 3; 4; 2; 1; 3; 3 ] [ 4; 3; 5; 3; 9; 3 ]

    Assert.Equal<int>(expected, actual)

// [<Fact>]
// let ``Test Real Data`` () : unit =
//     let expected = (2164381, 20719933)
//     let actual = Day01.solve ()

//     Assert.Equal<(int * int)>(expected, actual)
