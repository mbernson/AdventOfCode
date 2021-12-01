@testable import AdventOfCode2020
import XCTest

final class Day7Tests: XCTestCase {
  let day = Day7()
  let samples = [
    /* 0 */ "light red bags contain 1 bright white bag, 2 muted yellow bags.",
    /* 1 */ "dark orange bags contain 3 bright white bags, 4 muted yellow bags.",
    /* 2 */ "bright white bags contain 1 shiny gold bag.",
    /* 3 */ "muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.",
    /* 4 */ "shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.",
    /* 5 */ "dark olive bags contain 3 faded blue bags, 4 dotted black bags.",
    /* 6 */ "vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.",
    /* 7 */ "faded blue bags contain no other bags.",
    /* 8 */ "dotted black bags contain no other bags.",
  ]

  func testParsing() throws {
    let results = samples.compactMap(day.parseLine)
    XCTAssertEqual(samples.count, results.count)

    XCTAssertEqual(results[0].name, "light red")
    XCTAssertEqual(results[1].name, "dark orange")
    XCTAssertEqual(results[2].name, "bright white")
    XCTAssertEqual(results[3].name, "muted yellow")
    XCTAssertEqual(results[4].name, "shiny gold")
    XCTAssertEqual(results[5].name, "dark olive")
    XCTAssertEqual(results[6].name, "vibrant plum")
    XCTAssertEqual(results[7].name, "faded blue")
    XCTAssertEqual(results[8].name, "dotted black")

    XCTAssertEqual(results[0].contains, ["bright white", "muted yellow",
                                         "muted yellow"])
    XCTAssertEqual(results[1].contains, ["bright white", "bright white", "bright white",
                                         "muted yellow", "muted yellow", "muted yellow", "muted yellow"])
    XCTAssertEqual(results[2].contains, ["shiny gold"])
    XCTAssertEqual(results[3].contains, ["shiny gold", "shiny gold"] + Array(repeating: "faded blue", count: 9))
    XCTAssertEqual(results[4].contains, ["dark olive",
                                         "vibrant plum", "vibrant plum"])
    XCTAssertEqual(results[5].contains, Array(repeating: "faded blue", count: 3) + Array(repeating: "dotted black", count: 4))
    XCTAssertEqual(results[6].contains,
      Array(repeating: "faded blue", count: 5) + Array(repeating: "dotted black", count: 6)
    )
    XCTAssertEqual(results[7].contains, [])
    XCTAssertEqual(results[8].contains, [])
  }

  func testContains() throws {
    throw XCTSkip("Incomplete test")
    
    let results = samples.compactMap(day.parseLine)
    let bags = day.bagsThatMayContain(bagName: "shiny gold", in: results)
    print(bags)
    XCTAssertEqual(bags, Set([
      "bright white", "muted yellow", // directly
      "dark orange", "light red", // indirectly
    ]))
  }
}
