import XCTest
@testable import AdventOfCode2021

final class Day9Tests: XCTestCase {
  let input: [[Int]] = [
    [2,1,9,9,9,4,3,2,1,0],
    [3,9,8,7,8,9,4,9,2,1],
    [9,8,5,6,7,8,9,8,9,2],
    [8,7,6,7,8,9,6,7,8,9],
    [9,8,9,9,9,6,5,6,7,8],
  ]
  let day9 = Day9()

  typealias Point = Day9.Point

  func testNeighbors() throws {
    XCTAssertEqual(day9.neighbors(x: 0, y: 0, input: input).map(\.value), [1, 3])
    XCTAssertEqual(day9.neighbors(x: 1, y: 1, input: input).map(\.value), [1, 3, 8, 8])
    XCTAssertEqual(day9.neighbors(x: 5, y: 2, input: input).map(\.value), [9, 7, 9, 9])
    XCTAssertEqual(day9.neighbors(x: 5, y: 2, input: input), [
      Point(x: 5, y: 1, value: 9),
      Point(x: 4, y: 2, value: 7),
      Point(x: 6, y: 2, value: 9),
      Point(x: 5, y: 3, value: 9),
    ])
  }

  func testLowPoints() throws {
    XCTAssertEqual(day9.lowPoints(in: input), [1, 0, 5, 5])
  }
}
