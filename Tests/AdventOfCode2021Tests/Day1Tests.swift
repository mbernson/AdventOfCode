import XCTest
@testable import AdventOfCode2021

final class Day1Tests: XCTestCase {
  let input: [Int] = [199, 200, 208, 210, 200, 207, 240, 269, 260, 263]
  
  func testIncreasingNumbers() {
    XCTAssertEqual(Day1().numbersThatIncrease(input), 7)
  }
  
  func testPart1() throws {
    XCTAssertEqual(try Day1().runPart1(), 1228)
  }
  
  func testIncreasingNumbersWindow() {
    XCTAssertEqual(Day1().windowedSums(input, window: 3), [607, 618, 618, 617, 647, 716, 769, 792])
    XCTAssertEqual(Day1().numbersThatIncrease(input, window: 3), 5)
  }

  func testPart2() throws {
    XCTAssertEqual(try Day1().runPart2(), 1257)
  }
}
