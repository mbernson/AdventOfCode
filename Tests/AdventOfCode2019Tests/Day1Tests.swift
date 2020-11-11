import XCTest
@testable import AdventOfCode2019

final class Day1Tests: XCTestCase {
  func testExample() throws {
    XCTAssertEqual(Day1().fuel(forMass: 1969), 654)
    XCTAssertEqual(Day1().fuel(forMass: 100756), 33583)
  }

  func testPuzzle1() throws {
    XCTAssertEqual(try Day1().run1(), 3308377)
  }

  func testTotalFuel() throws {
    XCTAssertEqual(Day1().totalFuel(forMass: 100756), 50346)
  }

  func testPuzzle2() throws {
    XCTAssertEqual(try Day1().run2(), 4959709)
  }
}
