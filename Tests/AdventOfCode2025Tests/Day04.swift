import Testing

@testable import AdventOfCode2025

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day04Tests {
    // Smoke test data provided in the challenge question
    let testData = """
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
    """

    @Test func testPart1() async throws {
        let challenge = Day04(data: testData)
        #expect(String(describing: challenge.part1()) == "13")
    }
}
