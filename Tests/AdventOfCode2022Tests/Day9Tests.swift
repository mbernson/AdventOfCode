import XCTest
@testable import AdventOfCode2022

final class Day9Tests: XCTestCase {
    let exampleInput: String = """
R 4
U 4
L 3
D 1
R 4
D 1
L 5
R 2
"""

    let day9 = Day9()
    typealias Point = Day9.Point

    func testExample() {
        XCTAssertEqual(day9.runPart1(input: exampleInput), 13)
    }

    func testDistance() {
        XCTAssertEqual(day9.distance(from: Point(x: 1, y: 1), to: Point(x: 1, y: 1)), 0)
        XCTAssertEqual(day9.distance(from: Point(x: 1, y: 2), to: Point(x: 1, y: 1)), 1)
        XCTAssertEqual(day9.distance(from: Point(x: 0, y: 0), to: Point(x: 1, y: 1)), 1)
        XCTAssertEqual(day9.distance(from: Point(x: 0, y: 0), to: Point(x: 2, y: 2)), 2)
        XCTAssertEqual(day9.distance(from: Point(x: 0, y: 0), to: Point(x: 0, y: 2)), 2)
    }
}
