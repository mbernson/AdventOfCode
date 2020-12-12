import XCTest
@testable import AdventOfCode2020

final class Day10Tests: XCTestCase {
  func testArrangements() throws {
    let input: [Int] = [16, 10, 15, 5, 1, 11, 7, 19, 6, 12, 4]
    XCTAssertEqual(Day10().arrangements(for: input), 8)
  }

  func testArrangementsExtended() throws {
    let input: [Int] = [28, 33, 18, 42, 31, 14, 46, 20, 48, 47, 24, 23, 49, 45, 19, 38, 39, 11, 1, 32, 25, 35, 8, 17, 7, 9, 4, 2, 34, 10, 3]
    XCTAssertEqual(Day10().arrangements(for: input), 19208)
  }
}
