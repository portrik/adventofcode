import XCTest

@testable import AOC2015

class Problem01Tests: XCTestCase {
    let solution = Problem01(name: "01")

    func testFirst() {
        let combinations = [("(())", 0), ("()()", 0), ("(((", 3), ("(()(()(", 3),
                            ("))(((((", 3), ("())", -1), ("))(", -1), (")))", -3), (")())())", -3)]

        for combo in combinations {
            solution.input = combo.0
            XCTAssertEqual(solution.first(), String(combo.1))
        }
    }

    func testSecond() {
        let combinations = [(")", 1), ("()())", 5)]

        for combo in combinations {
            solution.input = combo.0
            XCTAssertEqual(solution.second(), String(combo.1))
        }
    }
}
