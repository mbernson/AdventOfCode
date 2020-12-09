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

  func testFindContiguousSet() throws {
    let ns: [Int] = [35, 20, 15, 25, 47, 40, 62, 55, 65, 95, 102, 117, 150, 182, 127, 219, 299, 277, 309, 576]
    XCTAssertEqual(Day9().contiguousSetAddingUpTo(result: 127, in: ns), [15, 25, 47, 40])
  }
}
