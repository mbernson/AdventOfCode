import XCTest
@testable import AdventOfCode2019

final class Day6Tests: XCTestCase {
  func testParsingInput() throws {
    let input = "A)B\nB)C\nC)D\n"
    XCTAssertEqual(
      Day6().parseDefinitions(from: input),
      [
        Day6.OrbitDefinition(parent: "A", child: "B"),
        Day6.OrbitDefinition(parent: "B", child: "C"),
        Day6.OrbitDefinition(parent: "C", child: "D"),
      ]
    )
  }

  func testBuildTree() throws {
    XCTAssertEqual(
      Day6().buildTree(from: []),
      Day6.Body(id: "COM")
    )

    XCTAssertEqual(
      Day6().buildTree(from: [
        Day6.OrbitDefinition(parent: "COM", child: "A"),
      ]),
      Day6.Body(id: "COM", children: [
        Day6.Body(id: "A")
      ])
    )

    let definitions = [
      Day6.OrbitDefinition(parent: "COM", child: "A"),
      Day6.OrbitDefinition(parent: "A", child: "B"),
      Day6.OrbitDefinition(parent: "A", child: "C"),
      Day6.OrbitDefinition(parent: "COM", child: "D"),
      Day6.OrbitDefinition(parent: "C", child: "E"),
    ]
    XCTAssertEqual(
      Day6().buildTree(from: definitions),
      Day6.Body(id: "COM", children: [
        Day6.Body(id: "A", children: [
          Day6.Body(id: "B"),
          Day6.Body(id: "C", children: [
            Day6.Body(id: "E"),
          ]),
        ]),
        Day6.Body(id: "D"),
      ])
    )
  }

  func testCountDirectOrbits1() throws {
    let input = "COM)A\n"
    let definitions = Day6().parseDefinitions(from: input)
    let system = Day6().buildTree(from: definitions)
    XCTAssertEqual(Day6().countDirectOrbits(of: system), 1)
  }

  func testCountDirectOrbits2() throws {
    /*
     COM)A
     A)B
     COM)C
     A)D
     C)E
     C)F"
     */
    let input = "COM)A\nA)B\nCOM)C\nA)D\nC)E\nC)F\n"
    let definitions = Day6().parseDefinitions(from: input)
    let system = Day6().buildTree(from: definitions)
    XCTAssertEqual(Day6().countDirectOrbits(of: system), 6)
  }

  func testCountIndirectOrbits1() throws {
    let input = "COM)A\n"
    let definitions = Day6().parseDefinitions(from: input)
    let system = Day6().buildTree(from: definitions)
    XCTAssertEqual(Day6().countDirectOrbits(of: system), 1)
  }
}
