import XCTest
@testable import AdventOfCode2020

final class Day1Tests: XCTestCase {

  func testFindMultiples() {
    let input: [Int] = [
      1721,
      979,
      366,
      299,
      675,
      1456,
    ]
    XCTAssertEqual(Day1().findMultiples(addingUpTo: 2020, in: input), [1721, 299])
  }

}
