import XCTest
@testable import AdventOfCode2021

final class Day1Tests: XCTestCase {
  func testPart1() throws {
    XCTAssertEqual(try Day1().runPart1(), 42)
  }

  func testPart2() throws {
    XCTAssertEqual(try Day1().runPart2(), 84)
  }
}
