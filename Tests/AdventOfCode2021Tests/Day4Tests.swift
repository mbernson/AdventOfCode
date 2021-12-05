import XCTest
@testable import AdventOfCode2021

final class Day4Tests: XCTestCase {
  let input = """
7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

22 13 17 11  0
 8  2 23  4 24
21  9 14 16  7
 6 10  3 18  5
 1 12 20 15 19

 3 15  0  2 22
 9 18 13 17  5
19  8  7 25 23
20 11 10 24  4
14 21 16 12  6

14 21 17 24  4
10 16 15  9 19
18  8 23 26 20
22 11 13  6  5
 2  0 12  3  7
"""

  let day4 = Day4()

  func testParse() throws {
    let (draw, grids) = day4.parseInput(string: input)
    XCTAssertEqual(draw, [7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1])

    XCTAssertEqual(grids.count, 3)

    for grid in grids {
      XCTAssertEqual(grid.combinations.count, 5 + 5)

      for row in grid.combinations {
        XCTAssertEqual(row.count, 5)
      }
    }

    // Grid 2, Row 2
    XCTAssertTrue(grids[1].combinations.contains([9, 18, 13, 17, 5]))

    // Grid 2, Column 2
    XCTAssertTrue(grids[1].combinations.contains([15, 18, 8, 11, 21]))

    // Diagonals are not needed (yet)...
    // Grid 2, Diagonal top-left to bottom-right
//    XCTAssertTrue(grids[1].combinations.contains([3, 18, 7, 24, 6]))
    // Grid 2, Diagonal top-right to bottom-left
//    XCTAssertTrue(grids[1].combinations.contains([22, 17, 7, 11, 14]))
  }

  func testBingo() throws {
    let (_, grids) = day4.parseInput(string: input)
    var bingo = Day4.Bingo(grids: grids)
    bingo.draw([7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21])
    XCTAssertTrue(bingo.winningBoards.isEmpty)
    bingo.draw(24)
    let winningBoards = bingo.winningBoards
    XCTAssertEqual(winningBoards.count, 1)
    let winner = winningBoards[0]
    // First row is fully marked, meaning it is empty
    XCTAssertEqual(winner.combinations[0], [])
    let score = winner.numbers.reduce(0, +)
    XCTAssertEqual(score, 188)
  }
}
