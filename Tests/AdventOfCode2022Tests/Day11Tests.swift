import XCTest
@testable import AdventOfCode2022

final class Day11Tests: XCTestCase {
    func testPart1() throws {
        let day11 = Day11()
        let monkeys = day11.makeExampleInput()
        XCTAssertEqual(day11.solve(input: monkeys, rounds: 20), 10605)
    }
}
