import XCTest
@testable import AdventOfCode2020

final class Day11Tests: XCTestCase {
  func testArrangements() throws {
    let initial = "L.LL.LL.LL\nLLLLLLL.LL\nL.L.L..L..\nLLLL.LL.LL\nL.LL.LL.LL\nL.LLLLL.LL\n..L.L.....\nLLLLLLLLLL\nL.LLLLLL.L\nL.LLLLL.LL"
    let input = Day11().parseInput(string: initial)

    let gen1 = Day11().generation(grid: input)
    let gen1String = "#.##.##.##\n#######.##\n#.#.#..#..\n####.##.##\n#.##.##.##\n#.#####.##\n..#.#.....\n##########\n#.######.#\n#.#####.##"
    XCTAssertEqual(gen1.stringRepresenstation(), gen1String)

    let gen2 = Day11().generation(grid: gen1)
    let gen2String = "#.LL.L#.##\n#LLLLLL.L#\nL.L.L..L..\n#LLL.LL.L#\n#.LL.LL.LL\n#.LLLL#.##\n..L.L.....\n#LLLLLLLL#\n#.LLLLLL.L\n#.#LLLL.##"
    XCTAssertEqual(gen2.stringRepresenstation(), gen2String)

    let gen3 = Day11().generation(grid: gen2)
    let gen3String = "#.##.L#.##\n#L###LL.L#\nL.#.#..#..\n#L##.##.L#\n#.##.LL.LL\n#.###L#.##\n..#.#.....\n#L######L#\n#.LL###L.L\n#.#L###.##"
    XCTAssertEqual(gen3.stringRepresenstation(), gen3String)

    let gen4 = Day11().generation(grid: gen3)
    let gen4String = "#.#L.L#.##\n#LLL#LL.L#\nL.L.L..#..\n#LLL.##.L#\n#.LL.LL.LL\n#.LL#L#.##\n..L.L.....\n#L#LLLL#L#\n#.LLLLLL.L\n#.#L#L#.##"
    XCTAssertEqual(gen4.stringRepresenstation(), gen4String)

    let gen5 = Day11().generation(grid: gen4)
    let gen5String = "#.#L.L#.##\n#LLL#LL.L#\nL.#.L..#..\n#L##.##.L#\n#.#L.LL.LL\n#.#L#L#.##\n..L.L.....\n#L#L##L#L#\n#.LLLLLL.L\n#.#L#L#.##"
    XCTAssertEqual(gen5.stringRepresenstation(), gen5String)

    XCTAssertEqual(Day11().seatsOccupied(in: gen5), 37)
  }

  func testIntegration() throws {
    let initial = "L.LL.LL.LL\nLLLLLLL.LL\nL.L.L..L..\nLLLL.LL.LL\nL.LL.LL.LL\nL.LLLLL.LL\n..L.L.....\nLLLLLLLLLL\nL.LLLLLL.L\nL.LLLLL.LL"
    let input = Day11().parseInput(string: initial)
    let gen5String = "#.#L.L#.##\n#LLL#LL.L#\nL.#.L..#..\n#L##.##.L#\n#.#L.LL.LL\n#.#L#L#.##\n..L.L.....\n#L#L##L#L#\n#.LLLLLL.L\n#.#L#L#.##"
    let gen5 = Day11().runUntilUnchanged(grid: input)
    XCTAssertEqual(gen5.stringRepresenstation(), gen5String)
    XCTAssertEqual(Day11().seatsOccupied(in: gen5), 37)
  }
}
