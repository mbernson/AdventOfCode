import XCTest
@testable import AdventOfCode2019

final class Day4Tests: XCTestCase {
  func testDigitsNeverDecreasing() throws {
    XCTAssertTrue(Day4().digitsNeverDecrease(12345))
    XCTAssertTrue(Day4().digitsNeverDecrease(4689))
    XCTAssertFalse(Day4().digitsNeverDecrease(98457))
    XCTAssertFalse(Day4().digitsNeverDecrease(12341))
    XCTAssertFalse(Day4().digitsNeverDecrease(223450))
  }

  func testAdjacentDigits() throws {
    XCTAssertFalse(Day4().twoAdjacentDigitsAreTheSame(12345))
    XCTAssertTrue(Day4().twoAdjacentDigitsAreTheSame(122345))
  }

  func testAdjacentDigitsWithAdditionalRules() throws {
    XCTAssertEqual(Day4().adjacentNumbersGrouped([1, 1, 2, 3]), [[1, 1]])
    XCTAssertEqual(Day4().adjacentNumbersGrouped([3, 4, 5, 5, 6, 7, 7, 7, 8]), [
      [5, 5],
      [7, 7, 7],
    ])

    XCTAssertTrue(Day4().containsGroupOfTwoMatchingDigits(112233))
    XCTAssertFalse(Day4().containsGroupOfTwoMatchingDigits(123444))
    XCTAssertTrue(Day4().containsGroupOfTwoMatchingDigits(111122))
  }
}
