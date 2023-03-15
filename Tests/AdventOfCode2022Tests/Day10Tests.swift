import XCTest
@testable import AdventOfCode2022

final class Day10Tests: XCTestCase {
    var day10: Day10!

    override func setUpWithError() throws {
        day10 = Day10()
    }

    func testSolveExample() throws {
        XCTAssertEqual(try day10.runPart1(inputURL: day10.exampleInputURL), 13140)
    }
}
