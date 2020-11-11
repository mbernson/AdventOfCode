import XCTest
@testable import AdventOfCode2019

final class Day2Tests: XCTestCase {
  func testPuzzle1() throws {
    XCTAssertEqual(try Day2().run1(), 3765464)
  }

  func testPuzzle2() throws {
    XCTAssertEqual(try Day2().run2(desiredOutput: 19690720), 7610)
  }
}
