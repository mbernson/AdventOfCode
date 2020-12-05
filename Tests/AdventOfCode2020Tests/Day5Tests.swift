@testable import AdventOfCode2020
import XCTest

final class Day5Tests: XCTestCase {
  func testLowerHalf() throws {
    XCTAssertEqual(Day5().lowerHalf(range: 0...127), 0...63)
    XCTAssertEqual(Day5().lowerHalf(range: 32...63), 32...47)
    XCTAssertEqual(Day5().lowerHalf(range: 44...47), 44...45)
  }

  func testUpperHalf() throws {
    XCTAssertEqual(Day5().upperHalf(range: 0...127), 64...127)
    XCTAssertEqual(Day5().upperHalf(range: 0...63), 32...63)
    XCTAssertEqual(Day5().upperHalf(range: 32...47), 40...47)
    XCTAssertEqual(Day5().upperHalf(range: 40...47), 44...47)
  }

  func testCalculateRow() throws {
    let input: [Day5.Seat] = "FBFBBFF".map(String.init)
      .compactMap(Day5.Seat.init(rawValue:))
    XCTAssertEqual(Day5().calculateRow(seats: input), 44)
  }

  func testCalculateRow2() throws {
    let input: [Day5.Seat] = "BFFFBBF".map(String.init)
      .compactMap(Day5.Seat.init(rawValue:))
    XCTAssertEqual(Day5().calculateRow(seats: input), 70)
  }

  func testCalculateColumn() throws {
    XCTAssertEqual(Day5().calculateColumn(seats: "RLR".map(String.init).compactMap(Day5.Seat.init(rawValue:))), 5)
  }

  func testCalculateColumn2() throws {
    let input: [Day5.Seat] = "RLL".map(String.init)
      .compactMap(Day5.Seat.init(rawValue:))
    XCTAssertEqual(Day5().calculateColumn(seats: input), 4)
  }

  func testCalculateSeat() throws {
    XCTAssertEqual(Day5().calculateSeat(string: "BFFFBBFRRR"),
                   Day5.CalculatedSeat(row: 70, column: 7, seatID: 567))
    XCTAssertEqual(Day5().calculateSeat(string: "FFFBBBFRRR"),
                   Day5.CalculatedSeat(row: 14, column: 7, seatID: 119))
    XCTAssertEqual(Day5().calculateSeat(string: "BBFFBBFRLL"),
                   Day5.CalculatedSeat(row: 102, column: 4, seatID: 820))
    XCTAssertEqual(Day5().calculateSeat(string: "FBFBBFFRLR"),
                   Day5.CalculatedSeat(row: 44, column: 5, seatID: 357))

  }
}
