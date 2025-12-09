import Testing

@testable import AdventOfCode2025

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
struct Day08Tests {
    // Smoke test data provided in the challenge question
    let testData = """
    162,817,812
    57,618,57
    906,360,560
    592,479,940
    352,342,300
    466,668,158
    542,29,236
    431,825,988
    739,650,466
    52,470,668
    216,146,977
    819,987,18
    117,168,530
    805,96,715
    346,949,466
    970,615,88
    941,993,340
    862,61,35
    984,92,344
    425,690,689
    
    """

    @Test func testUnorderedHash() {
        let a = Day08.Point(x: 1, y: 2, z: 4)
        let a2 = Day08.Point(x: 1, y: 2, z: 4)
        let b = Day08.Point(x: 4, y: 5, z: 6)
        let c = Day08.Point(x: 7, y: 8, z: 9)
        #expect(a != b)
        #expect(a == a2)
        #expect(a.hashValue == a2.hashValue)
        #expect(Day08.Pair(a, b) == Day08.Pair(b, a))
        #expect(Day08.Pair(a, b) == Day08.Pair(b, a))
        #expect(Day08.Pair(a, b) != Day08.Pair(b, c))
    }

    @Test func testCircuits() {
        let challenge = Day08(data: testData)
        let circuits = challenge.circuits(numberOfConnections: 10).sorted(by: {
            $0.count > $1.count
        })
        #expect(circuits.count == 11)
        #expect(circuits[0].count == 5)
        #expect(circuits[1].count == 4)
        #expect(circuits[2].count == 2)
        #expect(circuits[3].count == 2)
        #expect(circuits[4].count == 1)
        #expect(circuits[5].count == 1)
        #expect(circuits[6].count == 1)
        #expect(circuits[7].count == 1)
        #expect(circuits[8].count == 1)
        #expect(circuits[9].count == 1)
        #expect(circuits[10].count == 1)
    }

    @Test func testPart1() {
        let challenge = Day08(data: testData)
        #expect(String(describing: challenge.part1()) == "40")
    }

    @Test func testPart2() {
        let challenge = Day08(data: testData)
        #expect(String(describing: challenge.part2()) == "25272")
    }
}
