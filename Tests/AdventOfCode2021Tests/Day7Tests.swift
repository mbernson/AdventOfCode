import XCTest
@testable import AdventOfCode2021

final class Day7Tests: XCTestCase {
  let input = [16,1,2,0,4,2,7,1,2,14]
  let day7 = Day7()

  func testCheapestPosition() throws {
    XCTAssertEqual(day7.cheapestPositionFuelCost(input: input), 37)
  }
}
