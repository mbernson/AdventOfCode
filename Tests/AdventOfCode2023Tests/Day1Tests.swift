import XCTest
@testable import AdventOfCode2023

final class Day1Tests: XCTestCase {
    func testPart1() throws {
        let input = """
        1abc2
        pqr3stu8vwx
        a1b2c3d4e5f
        treb7uchet
        """
        XCTAssertEqual(Day1().part1(inputString: input), 142)
    }

    func testPart2() throws {
        let day1 = Day1()
        XCTAssertEqual(day1.scanDigitsFromLine(line: "two1nine"), [2, 1, 9])
        XCTAssertEqual(day1.scanDigitsFromLine(line: "eightwothree"), [8, 2, 3])
        XCTAssertEqual(day1.scanDigitsFromLine(line: "abcone2threexyz"), [1, 2, 3])
        XCTAssertEqual(day1.scanDigitsFromLine(line: "4nineeightseven2"), [4, 9, 8, 7, 2])
        XCTAssertEqual(day1.scanDigitsFromLine(line: "zoneight234"), [1, 8, 2, 3, 4])
        XCTAssertEqual(day1.scanDigitsFromLine(line: "7pqrstsixteen"), [7, 6])

        let input = """
        two1nine
        eightwothree
        abcone2threexyz
        xtwone3four
        4nineeightseven2
        zoneight234
        7pqrstsixteen
        """
        XCTAssertEqual(day1.part2(inputString: input), 281)
    }
}
