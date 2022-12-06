import XCTest
@testable import AdventOfCode2022

final class Day6Tests: XCTestCase {
    func testPart1() throws {
        let day6 = try Day6()
        XCTAssertEqual(day6.findMarker(in: "mjqjpqmgbljsphdztnvjfqwrcgsmlb")?.endIndex, 7)
        XCTAssertEqual(day6.findMarker(in: "bvwbjplbgvbhsrlpgdmjqwftvncz")?.endIndex, 5)
        XCTAssertEqual(day6.findMarker(in: "nppdvjthqldpwncqszvftbrmjlhg")?.endIndex, 6)
        XCTAssertEqual(day6.findMarker(in: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")?.endIndex, 10)
        XCTAssertEqual(day6.findMarker(in: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")?.endIndex, 11)
    }
}
