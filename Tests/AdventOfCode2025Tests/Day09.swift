import Testing

@testable import AdventOfCode2025

struct Day09Tests {
    // Smoke test data provided in the challenge question
    let testData = """
    7,1
    11,1
    11,7
    9,7
    9,5
    2,5
    2,3
    7,3
    
    """

    @Test func testArea() {
        let a = GridPoint(x: 2, y: 5)
        let b = GridPoint(x: 9, y: 7)
        let challenge = Day09(data: testData)
        #expect(challenge.area(p: a, q: b) == 24)
        #expect(challenge.area(p: b, q: a) == 24)

        let c = GridPoint(x: 7, y: 1)
        let d = GridPoint(x: 11, y: 7)
        #expect(challenge.area(p: c, q: d) == 35)
        #expect(challenge.area(p: d, q: c) == 35)

        let e = GridPoint(x: 7, y: 3)
        let f = GridPoint(x: 2, y: 3)
        #expect(challenge.area(p: e, q: f) == 6)
    }

    @Test func testPart1() {
        let challenge = Day09(data: testData)
        #expect(String(describing: challenge.part1()) == "50")
    }
}
