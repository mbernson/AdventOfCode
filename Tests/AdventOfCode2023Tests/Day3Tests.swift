import XCTest
@testable import AdventOfCode2023

final class Day3Tests: XCTestCase {
    let exampleInput = """
    467..114..
    ...*......
    ..35..633.
    ......#...
    617*......
    .....+.58.
    ..592.....
    ......755.
    ...$.*....
    .664.598..
    """

    func testPart1() throws {
        XCTAssertEqual(Day3().part1(inputString: exampleInput, width: 10, height: 10), 4361)
    }

    func testExample() throws {
        let input = """
        .242......276....234.........
        .............*...............
        ..........346................
        ...............#76...........
        ........204............396..*
        ....859*......496.598.+....81
        92............*.....*........
        ........$..388.........152*14
        .....877.....................
        ................142.....569..
        ...........560.....%....+....
        ......681...*................
        """
        let numbers: [Int] = [276, 346, 76, 204, 396, 859, 496, 598, 81, 388, 152, 14, 877, 142, 569, 560]
        let total = numbers.reduce(0, +)
        XCTAssertEqual(Day3().part1(inputString: input, width: 29, height: 12), total)
    }

    func testPart2() throws {
        XCTAssertEqual(Day3().part2(inputString: exampleInput, width: 10, height: 10), 467835)
    }
}
