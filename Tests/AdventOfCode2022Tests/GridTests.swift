import XCTest
@testable import AdventOfCode2022

final class GridTests: XCTestCase {
    let exampleInput = """
30373
25512
65332
33549
35390
"""

    func testGridRowAndCol() throws {
        let input: [Int] = exampleInput.map(String.init).compactMap(Int.init)
        let grid = Grid(width: 5, height: 5, memory: input)

        XCTAssertEqual(grid.row(y: 0), [3, 0, 3, 7, 3])
        XCTAssertEqual(grid.row(y: 1), [2, 5, 5, 1, 2])
        XCTAssertEqual(grid.row(y: 4), [3, 5, 3, 9, 0])

        XCTAssertEqual(grid.col(x: 0), [3, 2, 6, 3, 3])
        XCTAssertEqual(grid.col(x: 4), [3, 2, 2, 9, 0])
    }
}
