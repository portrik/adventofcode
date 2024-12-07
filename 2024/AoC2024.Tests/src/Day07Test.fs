module Day07Tests

open Xunit

[<Fact>]
let ``Test Case First`` () : unit =
    let expected = 3749

    let actual =
        Day07.first
            [ (190, [ 10; 19 ])
              (3267, [ 81; 40; 27 ])
              (83, [ 17; 5 ])
              (156, [ 15; 6 ])
              (7290, [ 6; 8; 6; 15 ])
              (161011, [ 16; 10; 13 ])
              (192, [ 17; 8; 14 ])
              (21037, [ 9; 7; 18; 13 ])
              (292, [ 11; 6; 16; 20 ]) ]

    Assert.Equal<int64>(expected, actual)

[<Fact>]
let ``Test Case Second`` () : unit =
    let expected = 11387

    let actual =
        Day07.second
            [ (190, [ 10; 19 ])
              (3267, [ 81; 40; 27 ])
              (83, [ 17; 5 ])
              (156, [ 15; 6 ])
              (7290, [ 6; 8; 6; 15 ])
              (161011, [ 16; 10; 13 ])
              (192, [ 17; 8; 14 ])
              (21037, [ 9; 7; 18; 13 ])
              (292, [ 11; 6; 16; 20 ]) ]

    Assert.Equal<int64>(expected, actual)

// [<Fact>]
// let ``Test Real Data`` () : unit =
//     let expected = (1298103531759L, 140575048428831L)
//     let actual = Day07.solve ()

//     Assert.Equal<int64 * int64>(expected, actual)
