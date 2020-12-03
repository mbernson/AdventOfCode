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
    XCTAssertEqual(grid.count, 11)

    XCTAssertEqual(Day3().numberOfTreesHit(grid: grid, movement: .init(x: 1, y: 1)), 2)
    XCTAssertEqual(Day3().numberOfTreesHit(grid: grid, movement: .init(x: 3, y: 1)), 7)
    XCTAssertEqual(Day3().numberOfTreesHit(grid: grid, movement: .init(x: 5, y: 1)), 3)
    XCTAssertEqual(Day3().numberOfTreesHit(grid: grid, movement: .init(x: 7, y: 1)), 4)
    XCTAssertEqual(Day3().numberOfTreesHit(grid: grid, movement: .init(x: 1, y: 2)), 2)
  }
}
