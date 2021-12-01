import XCTest
@testable import AdventOfCode2021

final class Day1Tests: XCTestCase {
  
  func testIncreasingNumbers() {
    let input: [Int] = [
      199, 200, 208, 210, 200, 207, 240, 269, 260, 263
    ]
    XCTAssertEqual(Day1().numbersThatIncrease(array: input), 7)
  }
  
  func testPart1() throws {
    XCTAssertEqual(try Day1().runPart1(), 1228)
  }

  func testPart2() throws {
    XCTAssertEqual(try Day1().runPart2(), 84)
  }
}
