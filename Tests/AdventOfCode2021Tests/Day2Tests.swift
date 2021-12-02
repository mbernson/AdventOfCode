import XCTest
@testable import AdventOfCode2021

final class Day2Tests: XCTestCase {
  let input = [
    "forward 5",
    "down 5",
    "forward 8",
    "up 3",
    "down 8",
    "forward 2",
  ]

  func testParsing() throws {
    let day2 = Day2()
    let output = try input.map(day2.parseLine)
    XCTAssertEqual(input.count, output.count)

    XCTAssertEqual(output[0].direction, .forward)
    XCTAssertEqual(output[0].amount, 5)
  }

  func testCourse() throws {
    let (horizontalPos, depth) = try Day2().calculateCourse(input: input)
    XCTAssertEqual(horizontalPos, 15)
    XCTAssertEqual(depth, 10)
  }

  func testPart1() throws {
    XCTAssertEqual(try Day2().runPart1(), 1938402)
  }

  func testCourseUpdated() throws {
    let (horizontalPos, depth) = try Day2().calculateCourseUpdated(input: input)
    XCTAssertEqual(horizontalPos, 15)
    XCTAssertEqual(depth, 60)
  }

  func testPart2() throws {
    XCTAssertEqual(try Day2().runPart2(), 1947878632)
  }
}
