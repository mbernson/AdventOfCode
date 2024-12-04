import Testing

@testable import AdventOfCode2024

struct Day03Tests {
    let testData = """
    xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))
    """

    @Test func testPart1() throws {
        let challenge = Day03(data: testData)
        #expect(String(describing: try challenge.part1()) == "161")
    }

    @Test func testPart2() throws {
//        let challenge = Day03(data: testData)
//        #expect(String(describing: challenge.part2()) == "32000")
    }
}
