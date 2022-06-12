import XCTest

@testable import AOC2015

class Problem03Tests: XCTestCase {
    let solution = Problem03()

    func testFirst() {
        let combinations = [(">", 2), ("^>v<", 4), ("^v^v^v^v^v", 2)]

        for combo in combinations {
            solution.input = combo.0
            XCTAssertEqual(solution.first(), String(combo.1))
        }
    }

    func testSecond() {
        let combinations = [("^v", 3), ("^>v<", 3), ("^v^v^v^v^v", 11)]

        for combo in combinations {
            solution.input = combo.0
            XCTAssertEqual(solution.second(), String(combo.1))
        }
    }
}
