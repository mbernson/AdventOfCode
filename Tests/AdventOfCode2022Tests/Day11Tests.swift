import XCTest
@testable import AdventOfCode2022

final class Day11Tests: XCTestCase {
    func testPart1() {
        let day11 = Day11()
        let monkeys = day11.makeExampleInput()
        XCTAssertEqual(day11.solve(input: monkeys, rounds: 20, isRound2: false), 10605)
    }

    func testPart2() {
        let day11 = Day11()
        let monkeys = day11.makeExampleInput()
        XCTAssertEqual(day11.solve(input: monkeys, rounds: 10_000, isRound2: true), 2713310158)
    }
}
