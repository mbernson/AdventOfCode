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
}
