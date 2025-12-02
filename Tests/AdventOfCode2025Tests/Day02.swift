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

        #expect(challenge.isInvalidIDPart1(1) == false)
        #expect(challenge.isInvalidIDPart1(123) == false)
        #expect(challenge.isInvalidIDPart1(22) == true)
        #expect(challenge.isInvalidIDPart1(1010) == true)
        #expect(challenge.isInvalidIDPart1(1188511885) == true)
        #expect(challenge.isInvalidIDPart1(38593859) == true)

        #expect(String(describing: challenge.part1()) == "1227775554")
    }

    @Test func testPart2() {
        let challenge = Day02(data: testData)

        #expect(challenge.isInvalidIDPart2(12341234) == true)
//        #expect(challenge.isInvalidIDPart2(123123123) == true)
//        #expect(challenge.isInvalidIDPart2(1212121212) == true)
//        #expect(challenge.isInvalidIDPart2(1111111) == true)

        #expect(String(describing: challenge.part2()) == "4174379265")
    }
}
