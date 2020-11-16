import XCTest
@testable import AdventOfCode2019

final class Day2Tests: XCTestCase {
  func testPuzzle1() throws {
    XCTAssertEqual(try Day2().runPart1(), 3765464)
  }

  func testPuzzle2() throws {
    XCTAssertEqual(try Day2().runPart2(desiredOutput: 19690720), 7610)

    XCTAssertThrowsError(try Day2().runPart2(desiredOutput: 42), "No solution possible") { error in
      XCTAssertEqual(error.localizedDescription, "No solution was found")
    }
  }
}
