import Testing

@testable import AdventOfCode2025

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day02Tests {
    // Smoke test data provided in the challenge question
    let testData = """
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
    """

    @Test func testPart1() {
        let challenge = Day02(data: testData)

        #expect(challenge.isInvalidID(1) == false)
        #expect(challenge.isInvalidID(123) == false)
        #expect(challenge.isInvalidID(22) == true)
        #expect(challenge.isInvalidID(1010) == true)
        #expect(challenge.isInvalidID(1188511885) == true)
        #expect(challenge.isInvalidID(38593859) == true)

        #expect(String(describing: challenge.part1()) == "1227775554")
    }
}
