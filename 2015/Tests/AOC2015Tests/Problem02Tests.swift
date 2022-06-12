import XCTest

@testable import AOC2015

class Problem02Tests: XCTestCase {
    let solution = Problem02()

    func testFirst() {
        let combinations = [([2, 3, 4], "58"), ([1, 1, 10], "43")]

        for combo in combinations {
            solution.dimensions = [combo.0]
            XCTAssertEqual(solution.first(), String(combo.1))
        }
    }

    func testSecond() {
        let combinations = [([2, 3, 4], "34"), ([1, 1, 10], "14")]

        for combo in combinations {
            solution.dimensions = [combo.0]
            XCTAssertEqual(solution.second(), String(combo.1))
        }
    }
}
