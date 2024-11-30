module Tests

open Xunit
open AoC2024

[<Fact>]
let ``Fails Gracefully for Missing Day Number`` () : unit =
    let expected = 1
    let actual = AoC2024.entryPoint (Array.ofList ([]))

    Assert.Equal<int>(expected, actual)

[<Fact>]
let ``Fails Gracefully for Unknown Day Number`` () : unit =
    let expected = 1
    let actual = AoC2024.entryPoint (Array.ofList ([ "34" ]))

    Assert.Equal<int>(expected, actual)
