import Testing

@testable import AdventOfCode2024

struct Day02Tests {
    // Smoke test data provided in the challenge question
    let testData = """
    7 6 4 2 1
    1 2 7 8 9
    9 7 6 2 1
    1 3 2 4 5
    8 6 4 4 1
    1 3 6 7 9
    """
    
    @Test func testPart1() throws {
        let challenge = Day02(data: testData)
        #expect(String(describing: challenge.part1()) == "2")
    }
    
    @Test func testPart2() throws {
        let challenge = Day02(data: testData)
        #expect(String(describing: challenge.part2()) == "4")
    }
}
