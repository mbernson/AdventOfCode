import XCTest
@testable import AdventOfCode2019

final class Day4Tests: XCTestCase {
  func testExample() throws {
    XCTAssertTrue(Day4().digitsNeverDecrease(12345))
    XCTAssertTrue(Day4().digitsNeverDecrease(4689))
    XCTAssertFalse(Day4().digitsNeverDecrease(98457))
    XCTAssertFalse(Day4().digitsNeverDecrease(12341))

    XCTAssertFalse(Day4().digitsNeverDecrease(223450))


    XCTAssertFalse(Day4().twoAdjacentDigitsAreTheSame(12345))
    XCTAssertTrue(Day4().twoAdjacentDigitsAreTheSame(122345))

    XCTAssertEqual(Day4().passcodesMatchingRequirements(inRange: 124075...580769).count, 2150)
  }
}
