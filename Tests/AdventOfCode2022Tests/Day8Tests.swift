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

    func testVisibleTrees() throws {
        let input: [Int] = exampleInput.map(String.init).compactMap(Int.init)
        let grid = Day8.Grid(width: 5, height: 5, memory: input)
        let day8 = Day8()
        XCTAssertEqual(day8.visibleTrees(in: grid), 21)
    }

    func testScenicScore() throws {
        let input: [Int] = exampleInput.map(String.init).compactMap(Int.init)
        let grid = Day8.Grid(width: 5, height: 5, memory: input)
        XCTAssertEqual(grid.scenicScore(x: 2, y: 1), 4)
        XCTAssertEqual(grid.scenicScore(x: 2, y: 3), 8)
        let day8 = Day8()
        XCTAssertEqual(day8.highestScenicScore(in: grid), 8)
    }
}
