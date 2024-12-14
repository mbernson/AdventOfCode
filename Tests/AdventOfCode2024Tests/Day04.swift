import Testing

@testable import AdventOfCode2024

struct Day04Tests {
    let testData = """
    MMMSXXMASM
    MSAMXMSMSA
    AMXSXMAAMM
    MSAMASMSMX
    XMASAMXAMM
    XXAMMXXAMA
    SMSMSASXSS
    SAXAMASAAA
    MAMMMXMMMM
    MXMXAXMASX
    """

    @Test func testPart1() throws {
        let challenge = Day04(data: testData)
        #expect(String(describing: try challenge.part1()) == "18")
    }
}
