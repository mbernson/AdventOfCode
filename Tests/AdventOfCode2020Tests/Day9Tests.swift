@testable import AdventOfCode2020
import XCTest

final class Day9Tests: XCTestCase {
  func testSimple() throws {
    let preamble: [Int] = Array(1...25)
    XCTAssertTrue(Day9().isValid(number: 26, in: preamble))
    XCTAssertTrue(Day9().isValid(number: 49, in: preamble))
    XCTAssertFalse(Day9().isValid(number: 100, in: preamble))
    XCTAssertFalse(Day9().isValid(number: 50, in: preamble))
  }
}
