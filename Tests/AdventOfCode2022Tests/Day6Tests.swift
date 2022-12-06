import XCTest
@testable import AdventOfCode2022

final class Day6Tests: XCTestCase {
    func testPart1() throws {
        let day6 = Day6()
        XCTAssertEqual(day6.findMarker(in: "mjqjpqmgbljsphdztnvjfqwrcgsmlb")?.endIndex, 7)
        XCTAssertEqual(day6.findMarker(in: "bvwbjplbgvbhsrlpgdmjqwftvncz")?.endIndex, 5)
        XCTAssertEqual(day6.findMarker(in: "nppdvjthqldpwncqszvftbrmjlhg")?.endIndex, 6)
        XCTAssertEqual(day6.findMarker(in: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")?.endIndex, 10)
        XCTAssertEqual(day6.findMarker(in: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")?.endIndex, 11)
    }

    func testPart2() throws {
        let day6 = Day6()
        XCTAssertEqual(day6.findMessage(in: "mjqjpqmgbljsphdztnvjfqwrcgsmlb")?.endIndex, 19)
        XCTAssertEqual(day6.findMessage(in: "bvwbjplbgvbhsrlpgdmjqwftvncz")?.endIndex, 23)
        XCTAssertEqual(day6.findMessage(in: "nppdvjthqldpwncqszvftbrmjlhg")?.endIndex, 23)
        XCTAssertEqual(day6.findMessage(in: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")?.endIndex, 29)
        XCTAssertEqual(day6.findMessage(in: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")?.endIndex, 26)
    }
}
