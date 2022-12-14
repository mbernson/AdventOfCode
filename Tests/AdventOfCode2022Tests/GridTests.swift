import XCTest
@testable import AdventOfCode2022

final class GridTests: XCTestCase {
    let exampleInput = """
3 0 3 7 3
2 5 5 1 2
6 5 3 3 2
3 3 5 4 9
3 5 3 9 0
"""
    var grid: Grid2D<Int> = .init(width: 0, height: 0, memory: [])

    override func setUp() {
        let input: [Int] = exampleInput.map(String.init).compactMap(Int.init)
        grid = Grid2D(width: 5, height: 5, memory: input)
    }

    func testGridInitWithMemory() {
        XCTAssertEqual(grid.width, 5)
        XCTAssertEqual(grid.height, 5)
        XCTAssertEqual(grid.memory.count, 5 * 5)
    }

    func testGridInitWithProvider() {
        let grid = Grid2D<Int>(width: 5, height: 5) { point in
            0
        }
        XCTAssertEqual(grid.width, 5)
        XCTAssertEqual(grid.height, 5)
        XCTAssertEqual(grid.memory.count, 5 * 5)
        XCTAssertEqual(grid.memory, Array(repeating: 0, count: 25))
    }

    func testGridRowAndCol() {
        XCTAssertEqual(grid.row(y: 0), [3, 0, 3, 7, 3])
        XCTAssertEqual(grid.row(y: 1), [2, 5, 5, 1, 2])
        XCTAssertEqual(grid.row(y: 4), [3, 5, 3, 9, 0])

        XCTAssertEqual(grid.col(x: 0), [3, 2, 6, 3, 3])
        XCTAssertEqual(grid.col(x: 4), [3, 2, 2, 9, 0])
    }

    func testGridSubscript() {
        XCTAssertEqual(grid[0, 0], 3)
        XCTAssertEqual(grid[1, 1], 5)
        XCTAssertEqual(grid[0, 1], 2)
        XCTAssertEqual(grid[1, 0], 0)
    }
}
