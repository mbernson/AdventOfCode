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
    let bags = samples.compactMap(day.parseLine)
    XCTAssertEqual(samples.count, bags.count)

    XCTAssertEqual(bags[0].name, "light red")
    XCTAssertEqual(bags[1].name, "dark orange")
    XCTAssertEqual(bags[2].name, "bright white")
    XCTAssertEqual(bags[3].name, "muted yellow")
    XCTAssertEqual(bags[4].name, "shiny gold")
    XCTAssertEqual(bags[5].name, "dark olive")
    XCTAssertEqual(bags[6].name, "vibrant plum")
    XCTAssertEqual(bags[7].name, "faded blue")
    XCTAssertEqual(bags[8].name, "dotted black")

    XCTAssertEqual(bags[0].contents, ["bright white", "muted yellow",
                                         "muted yellow"])
    XCTAssertEqual(bags[1].contents, ["bright white", "bright white", "bright white",
                                         "muted yellow", "muted yellow", "muted yellow", "muted yellow"])
    XCTAssertEqual(bags[2].contents, ["shiny gold"])
    XCTAssertEqual(bags[3].contents, ["shiny gold", "shiny gold"] + Array(repeating: "faded blue", count: 9))
    XCTAssertEqual(bags[4].contents, ["dark olive",
                                         "vibrant plum", "vibrant plum"])
    XCTAssertEqual(bags[5].contents, Array(repeating: "faded blue", count: 3) + Array(repeating: "dotted black", count: 4))
    XCTAssertEqual(bags[6].contents,
      Array(repeating: "faded blue", count: 5) + Array(repeating: "dotted black", count: 6)
    )
    XCTAssertEqual(bags[7].contents, [])
    XCTAssertEqual(bags[8].contents, [])
  }

  func testContains() throws {
    let allBags = samples.compactMap(day.parseLine)
    let bagsContainingShinyGold = day.bagsThatMayContain(bagName: "shiny gold", in: allBags)
    XCTAssertEqual(bagsContainingShinyGold, Set([
      "bright white", "muted yellow", // directly
      "dark orange", "light red", // indirectly
    ]))
  }
}
