import XCTest
@testable import AdventOfCode2019

final class Day3Tests: XCTestCase {

  func testParsing() throws {
    XCTAssertEqual(try Day3().parseInstructions(string: "R8,U5,L42,D888"), [
      Day3.Instruction(direction: .right, distance: 8),
      Day3.Instruction(direction: .up, distance: 5),
      Day3.Instruction(direction: .left, distance: 42),
      Day3.Instruction(direction: .down, distance: 888),
    ])
  }

  func testManhattanDistance() throws {
    XCTAssertEqual(Day3().manhattanDistance(p: .init(x: 0, y: 0), q: .init(x: 3, y: 3)), 6)
    XCTAssertEqual(Day3().manhattanDistance(p: .init(x: 0, y: 0), q: .init(x: 1, y: 3)), 4)
    XCTAssertEqual(Day3().manhattanDistance(p: .init(x: 2, y: 3), q: .init(x: 0, y: 0)), 5)
    XCTAssertEqual(Day3().manhattanDistance(p: .init(x: 3, y: 2), q: .init(x: 0, y: 0)), 5)
  }

  func testPoints() throws {
    XCTAssertEqual(Day3().points(for: Day3.Instruction(direction: .up, distance: 3), origin: .zero), [
      Day3.Point(x: 0, y: 1),
      Day3.Point(x: 0, y: 2),
      Day3.Point(x: 0, y: 3),
    ])
    XCTAssertEqual(Day3().points(for: Day3.Instruction(direction: .down, distance: 3), origin: .zero), [
      Day3.Point(x: 0, y: -1),
      Day3.Point(x: 0, y: -2),
      Day3.Point(x: 0, y: -3),
    ])
    XCTAssertEqual(Day3().points(for: Day3.Instruction(direction: .left, distance: 3), origin: .zero), [
      Day3.Point(x: -1, y: 0),
      Day3.Point(x: -2, y: 0),
      Day3.Point(x: -3, y: 0),
    ])
    XCTAssertEqual(Day3().points(for: Day3.Instruction(direction: .right, distance: 3), origin: .zero), [
      Day3.Point(x: 1, y: 0),
      Day3.Point(x: 2, y: 0),
      Day3.Point(x: 3, y: 0),
    ])

    XCTAssertEqual(Day3().points(for: Day3.Instruction(direction: .up, distance: 3), origin: Day3.Point(x: 3, y: 3)), [
      Day3.Point(x: 3, y: 3 + 1),
      Day3.Point(x: 3, y: 3 + 2),
      Day3.Point(x: 3, y: 3 + 3),
    ])
    XCTAssertEqual(Day3().points(for: Day3.Instruction(direction: .down, distance: 3), origin: .zero), [
      Day3.Point(x: 0, y: -1),
      Day3.Point(x: 0, y: -2),
      Day3.Point(x: 0, y: -3),
    ])
    XCTAssertEqual(Day3().points(for: Day3.Instruction(direction: .left, distance: 3), origin: .zero), [
      Day3.Point(x: -1, y: 0),
      Day3.Point(x: -2, y: 0),
      Day3.Point(x: -3, y: 0),
    ])
    XCTAssertEqual(Day3().points(for: Day3.Instruction(direction: .right, distance: 3), origin: .zero), [
      Day3.Point(x: 1, y: 0),
      Day3.Point(x: 2, y: 0),
      Day3.Point(x: 3, y: 0),
    ])
  }

  func testPointsForInstructions() throws {
    let instructions = try Day3().parseInstructions(string: "R2,U2")
    XCTAssertEqual(
      Day3().points(for: instructions, origin: .zero),
      [
        Day3.Point(x: 1, y: 0),
        Day3.Point(x: 2, y: 0),
        Day3.Point(x: 2, y: 1),
        Day3.Point(x: 2, y: 2),
      ]
    )

    let instructions2 = try Day3().parseInstructions(string: "R8,U5,L5,D3")
    XCTAssertEqual(
      Day3().points(for: instructions2, origin: .zero),
      [
        // R8
        Day3.Point(x: 1, y: 0),
        Day3.Point(x: 2, y: 0),
        Day3.Point(x: 3, y: 0),
        Day3.Point(x: 4, y: 0),
        Day3.Point(x: 5, y: 0),
        Day3.Point(x: 6, y: 0),
        Day3.Point(x: 7, y: 0),
        Day3.Point(x: 8, y: 0),
        // U5
        Day3.Point(x: 8, y: 1),
        Day3.Point(x: 8, y: 2),
        Day3.Point(x: 8, y: 3),
        Day3.Point(x: 8, y: 4),
        Day3.Point(x: 8, y: 5),
        // L5
        Day3.Point(x: 7, y: 5),
        Day3.Point(x: 6, y: 5),
        Day3.Point(x: 5, y: 5),
        Day3.Point(x: 4, y: 5),
        Day3.Point(x: 3, y: 5),
        // D3
        Day3.Point(x: 3, y: 4),
        Day3.Point(x: 3, y: 3),
        Day3.Point(x: 3, y: 2),
      ]
    )
  }

  func testDistanceSimple() throws {
    let firstInstr = try Day3().parseInstructions(string: "R8,U5,L5,D3")
    let secondInstr = try Day3().parseInstructions(string: "U7,R6,D4,L4")
    XCTAssertEqual(
      Day3().intersectingPoints(first: firstInstr, second: secondInstr, origin: .zero),
      Set([
        Day3.Point(x: 6, y: 5),
        Day3.Point(x: 3, y: 3),
      ])
    )
    XCTAssertEqual(
      try Day3().closestIntersectionToOrigin(
        firstWire: "R8,U5,L5,D3",
        secondWire: "U7,R6,D4,L4"
      ),
      6
    )
  }

  func testDistanceComplex() throws {
    XCTAssertEqual(
      try Day3().closestIntersectionToOrigin(
        firstWire: "R75,D30,R83,U83,L12,D49,R71,U7,L72",
        secondWire: "U62,R66,U55,R34,D71,R55,D58,R83"
      ),
      159
    )
    XCTAssertEqual(
      try Day3().closestIntersectionToOrigin(
        firstWire: "R98,U47,R26,D63,R33,U87,L62,D20,R33,U53,R51",
        secondWire: "U98,R91,D20,R16,D67,R40,U7,R15,U6,R7"
      ),
      135
    )
  }
}
