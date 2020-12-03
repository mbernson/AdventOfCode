@testable import AdventOfCode2020
import XCTest

final class Day3Tests: XCTestCase {
  func testInputParsing() throws {
    XCTAssertEqual(
      Day3().parseInput(input: "..##......."),
      [[.empty, .empty, .tree, .tree, .empty, .empty, .empty, .empty, .empty, .empty, .empty]]
    )
    XCTAssertEqual(
      Day3().parseInput(input: "..##.......\n#...#...#..\n"),
      [[.empty, .empty, .tree, .tree, .empty, .empty, .empty, .empty, .empty, .empty, .empty],
       [.tree, .empty, .empty, .empty, .tree, .empty, .empty, .empty, .tree, .empty, .empty]]
    )
  }

  func testNumberOfTreesHit() throws {
    let input = "..##.......\n #...#...#..\n .#....#..#.\n ..#.#...#.#\n .#...##..#.\n ..#.##.....\n .#.#.#....#\n .#........#\n #.##...#...\n #...##....#\n .#..#...#.#\n"
    let grid = Day3().parseInput(input: input)
    for row in grid {
      XCTAssertEqual(row.count, 11)
    }
    XCTAssertEqual(Day3().numberOfTreesHit(grid: grid), 7)
  }
}
