module Day03Tests

open Xunit

[<Fact>]
let ``Test Case First`` () : unit =
    let expected = 161

    let actual =
        Day03.first (@"xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))")

    Assert.Equal<int>(expected, actual)

[<Fact>]
let ``Test Case Second`` () : unit =
    let expected = 48

    let actual =
        Day03.second (@"xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))")

    Assert.Equal<int>(expected, actual)

// [<Fact>]
// let ```Test Real Data`` () : unit =
//     let expected = (169021493, 111762583)
//     let actual = Day03.solve ()

//     Assert.Equal<int * int>(expected, actual)
