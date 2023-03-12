import XCTest
@testable import AdventOfCode2022

final class Day12Tests: XCTestCase {
    typealias Point = Grid2D<UInt8>.Point

    var day12: Day12!
    var grid: Grid2D<UInt8>!
    var start: Point!
    var end: Point!

    override func setUpWithError() throws {
        day12 = Day12()
        grid = day12.exampleGrid
        let startIndex = grid.memory.firstIndex(of: Character("S").asciiValue!)!
        start = grid.point(at: startIndex)
        let endIndex = grid.memory.firstIndex(of: Character("E").asciiValue!)!
        end = grid.point(at: endIndex)
        grid.memory[startIndex] = Character("a").asciiValue!
        grid.memory[endIndex] = Character("z").asciiValue!
    }

    func testSolveExample() throws {
        XCTAssertEqual(day12.solve(grid: grid, start: start, end: end), 31)
    }
}
