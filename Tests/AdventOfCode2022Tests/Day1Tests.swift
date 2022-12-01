import XCTest
@testable import AdventOfCode2022

final class Day1Tests: XCTestCase {
  func testPart1() throws {
    XCTAssertEqual(try Day1().runPart1(), 68775)
  }
}
