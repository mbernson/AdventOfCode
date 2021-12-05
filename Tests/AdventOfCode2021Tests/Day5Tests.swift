import XCTest
@testable import AdventOfCode2021

final class Day5Tests: XCTestCase {
  let input = [
    "0,9 -> 5,9",
    "8,0 -> 0,8",
    "9,4 -> 3,4",
    "2,2 -> 2,1",
    "7,0 -> 7,4",
    "6,4 -> 2,0",
    "0,9 -> 2,9",
    "3,4 -> 1,4",
    "0,0 -> 8,8",
    "5,5 -> 8,2",
  ]
  let day5 = Day5()
  
  func testParsing() throws {
    let vents = input.compactMap(day5.parseLine)
    XCTAssertEqual(vents[0].start, Day5.Coordinate(x: 0, y: 9))
    XCTAssertEqual(vents[0].end, Day5.Coordinate(x: 5, y: 9))
  }
  
  func testVentLineVertical() throws {
    let vent = Day5.Vent(start: .init(x: 1, y: 1), end: .init(x: 1, y: 3))
    XCTAssertEqual(vent.line, [
      .init(x: 1, y: 1), .init(x: 1, y: 2), .init(x: 1, y: 3),
    ])
  }
  
  func testVentLineHorizontal() throws {
    let vent = Day5.Vent(start: .init(x: 9, y: 7), end: .init(x: 7, y: 7))
    // XCTAssertEqual(vent.line, [
    //   .init(x: 9, y: 7), .init(x: 8, y: 7), .init(x: 7, y: 7),
    // ])
    XCTAssertEqual(vent.line, [
      .init(x: 9, y: 7),
      .init(x: 8, y: 7),
      .init(x: 7, y: 7),
    ])
  }
  
  func testVentLineDiagonal1() throws {
    let vent = Day5.Vent(start: .init(x: 1, y: 1), end: .init(x: 3, y: 3))
    XCTAssertEqual(vent.lineIncludingDiagonals, [
      .init(x: 1, y: 1),
      .init(x: 2, y: 2),
      .init(x: 3, y: 3),
    ])
  }
  
  func testVentLineDiagonal2() throws {
    let vent = Day5.Vent(start: .init(x: 9, y: 7), end: .init(x: 7, y: 9))
    XCTAssertEqual(vent.lineIncludingDiagonals, [
      .init(x: 9, y: 7),
      .init(x: 8, y: 8),
      .init(x: 7, y: 9),
    ])
  }
  
  func testOverlap() throws {
    let vents = input.compactMap(day5.parseLine)
    XCTAssertEqual(day5.overlappingCoordinates(in: vents, includingDiagonals: false).count, 5)
    XCTAssertEqual(day5.overlappingCoordinates(in: vents, includingDiagonals: true).count, 12)
  }
}
