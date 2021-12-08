import XCTest
@testable import AdventOfCode2021

final class Day7Tests: XCTestCase {
  let input = [16,1,2,0,4,2,7,1,2,14]
  var day7 = Day7()

  override func setUp() {
    day7 = Day7()
  }

  func testCheapestPosition() throws {
    XCTAssertEqual(day7.cheapestPositionFuelCost(input: input), 37)
  }

  func testCheapestPositionLinear() throws {
    XCTAssertEqual(day7.cheapestPositionFuelCostLinearRate(input: input), 168)
  }

  func testMoveFrom() {
    XCTAssertEqual(day7.moveFrom(16, to: 5), 66)
    XCTAssertEqual(day7.moveFrom(1, to: 5), 10)
    XCTAssertEqual(day7.moveFrom(2, to: 5), 6)
    XCTAssertEqual(day7.moveFrom(0, to: 5), 15)
    XCTAssertEqual(day7.moveFrom(4, to: 5), 1)
    XCTAssertEqual(day7.moveFrom(2, to: 5), 6)
    XCTAssertEqual(day7.moveFrom(7, to: 5), 3)
    XCTAssertEqual(day7.moveFrom(1, to: 5), 10)
    XCTAssertEqual(day7.moveFrom(2, to: 5), 6)
    XCTAssertEqual(day7.moveFrom(14, to: 5), 45)
  }
}
