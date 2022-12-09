import XCTest
@testable import AdventOfCode2022

final class Day8Tests: XCTestCase {
    let exampleInput = """
30373
25512
65332
33549
35390
"""

    func testGridRowAndCol() throws {
        let input: [Int] = exampleInput.map(String.init).compactMap(Int.init)
        let grid = Day8.Grid(width: 5, height: 5, memory: input)

        XCTAssertEqual(grid.row(y: 0), [3, 0, 3, 7, 3])
        XCTAssertEqual(grid.row(y: 1), [2, 5, 5, 1, 2])
        XCTAssertEqual(grid.row(y: 4), [3, 5, 3, 9, 0])

        XCTAssertEqual(grid.col(x: 0), [3, 2, 6, 3, 3])
        XCTAssertEqual(grid.col(x: 4), [3, 2, 2, 9, 0])

        let trees = grid.rowAndColumnNotIncluding(x: 1, y: 1)
        XCTAssertEqual(trees, [
            .init(x: 0, y: 1),
            .init(x: 2, y: 1),
            .init(x: 3, y: 1),
            .init(x: 4, y: 1),

            .init(x: 1, y: 0),
            .init(x: 1, y: 2),
            .init(x: 1, y: 3),
            .init(x: 1, y: 4),
        ])
    }

    func testVisibleTrees() throws {
        let input: [Int] = exampleInput.map(String.init).compactMap(Int.init)
        let grid = Day8.Grid(width: 5, height: 5, memory: input)
        let day8 = Day8()
        let trees = day8.visibleTrees(in: grid)
        XCTAssertEqual(trees.count, 21)
    }
}
