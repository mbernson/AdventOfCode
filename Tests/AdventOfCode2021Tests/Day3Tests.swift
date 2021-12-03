import XCTest
@testable import AdventOfCode2021

final class Day3Tests: XCTestCase {
  let input = [
    "00100",
    "11110",
    "10110",
    "10111",
    "10101",
    "01111",
    "00111",
    "11100",
    "10000",
    "11001",
    "00010",
    "01010",
  ]
  let day3 = Day3()

  func testParsing() throws {
    XCTAssertEqual(day3.mostCommonDigit(row: 0, in: input), 1)
    XCTAssertEqual(day3.mostCommonDigit(row: 1, in: input), 0)
    XCTAssertEqual(day3.mostCommonDigit(row: 2, in: input), 1)
    XCTAssertEqual(day3.mostCommonDigit(row: 3, in: input), 1)
    XCTAssertEqual(day3.mostCommonDigit(row: 4, in: input), 0)

    XCTAssertEqual(day3.leastCommonDigit(row: 0, in: input), 0)
    XCTAssertEqual(day3.leastCommonDigit(row: 1, in: input), 1)
    XCTAssertEqual(day3.leastCommonDigit(row: 2, in: input), 0)
    XCTAssertEqual(day3.leastCommonDigit(row: 3, in: input), 0)
    XCTAssertEqual(day3.leastCommonDigit(row: 4, in: input), 1)
  }

  func testRates() throws {
    XCTAssertEqual(day3.gammaRate(input: input), 22)
    XCTAssertEqual(day3.epsilonRate(input: input), 9)
  }
}
