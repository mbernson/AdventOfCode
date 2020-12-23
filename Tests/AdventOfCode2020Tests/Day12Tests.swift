@testable import AdventOfCode2020
import XCTest

final class Day12Tests: XCTestCase {
  func testParseInput() throws {
    XCTAssertEqual(try Day12.Instruction(string: "N12"), Day12.Instruction(direction: .north, distance: 12))
    XCTAssertEqual(try Day12.Instruction(string: "F10"), Day12.Instruction(direction: .front, distance: 10))
    XCTAssertEqual(try Day12.Instruction(string: "E3"), Day12.Instruction(direction: .east, distance: 3))
  }

  func testApplyingInstructions() throws {
    let input: [Day12.Instruction] = try [
      "F10",
      "N3",
      "F7",
      "R90",
      "F11",
    ].map(Day12.Instruction.init(string:))
    XCTAssertEqual(Day12().applyInstructions(input: input), Day12.Position(direction: .south, x: 17, y: 8))
  }

  func testPositionRotate0() throws {
    var position = Day12.Position(direction: .north, x: 0, y: 0)
    position.rotate(direction: .right, degrees: 45)
    XCTAssertEqual(position.direction, .north)
  }

  func testPositionRotate90() throws {
    var position = Day12.Position(direction: .east, x: 0, y: 0)
    position.rotate(direction: .right, degrees: 90)
    XCTAssertEqual(position.direction, .south)
  }

  func testPositionRotate180() throws {
    var position = Day12.Position(direction: .north, x: 0, y: 0)
    position.rotate(direction: .right, degrees: 180)
    XCTAssertEqual(position.direction, .south)
  }

  func testPositionRotate270() throws {
    var position = Day12.Position(direction: .north, x: 0, y: 0)
    position.rotate(direction: .left, degrees: 270)
    XCTAssertEqual(position.direction, .east)
  }

  func testManhattanDistance() throws {
    XCTAssertEqual(Day12().manhattanDistance(from: .zero, to: .init(x: 17, y: 8)), 25)
  }
}
