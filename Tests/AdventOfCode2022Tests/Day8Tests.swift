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
        let trees = day8.visibleTrees(in: grid)
        XCTAssertEqual(trees.count, 21)
    }
}
