@testable import AdventOfCode2020
import XCTest

final class Day7Tests: XCTestCase {
  func testMakeBagsNoOther() throws {
    XCTAssertEqual(
      Day7().makeBagsLine(from: "dotted black bags contain no other bags."),
      Day7.Bag(name: "dotted black", children: [])
    )
  }

  func testMakeBags() throws {
    XCTAssertEqual(
      Day7().makeBagsLine(from: "light red bags contain 1 bright white bag, 2 muted yellow bags."),
      Day7.Bag(name: "light red", children: [
        Day7.Bag(name: "bright white", children: []),
        Day7.Bag(name: "muted yellow", children: []),
        Day7.Bag(name: "muted yellow", children: []),
      ])
    )
  }

  func testMakeBagsTree() throws {
    let inputString = "light red bags contain 1 bright white bag, 2 muted yellow bags.\ndark orange bags contain 3 bright white bags, 4 muted yellow bags.\nbright white bags contain 1 shiny gold bag."

    // light red bags contain 1 bright white bag, 2 muted yellow bags.
    // dark orange bags contain 3 bright white bags, 4 muted yellow bags.
    // bright white bags contain 1 shiny gold bag.
    XCTAssertEqual(
      Day7().makeBagsTree(from: inputString),
      Day7.Bag(name: "__ROOT__", children: [
        Day7.Bag(name: "light red", children: [
          Day7.Bag(name: "bright white", children: [
            Day7.Bag(name: "shiny gold", children: []),
          ]),
          Day7.Bag(name: "muted yellow", children: []),
          Day7.Bag(name: "muted yellow", children: []),
        ]),
        Day7.Bag(name: "dark orange", children: [
          Day7.Bag(name: "bright white", children: [
            Day7.Bag(name: "shiny gold", children: []),
          ]),
          Day7.Bag(name: "bright white", children: [
            Day7.Bag(name: "shiny gold", children: []),
          ]),
          Day7.Bag(name: "bright white", children: [
            Day7.Bag(name: "shiny gold", children: []),
          ]),
          Day7.Bag(name: "muted yellow", children: []),
          Day7.Bag(name: "muted yellow", children: []),
          Day7.Bag(name: "muted yellow", children: []),
          Day7.Bag(name: "muted yellow", children: []),
        ]),


        Day7.Bag(name: "bright white", children: [
          Day7.Bag(name: "shiny gold", children: []),
        ]),
      ])
    )
  }

  func testTreeSearch() throws {
    let inputString = "light red bags contain 1 bright white bag, 2 muted yellow bags.\ndark orange bags contain 3 bright white bags, 4 muted yellow bags.\nbright white bags contain 1 shiny gold bag.\nmuted yellow bags contain 2 shiny gold bags, 9 faded blue bags.\nshiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.\ndark olive bags contain 3 faded blue bags, 4 dotted black bags.\nvibrant plum bags contain 5 faded blue bags, 6 dotted black bags.\nfaded blue bags contain no other bags.\ndotted black bags contain no other bags."
    let tree = Day7().makeBagsTree(from: inputString)
    let searchBag = Day7.Bag(name: "shiny gold", children: [])
    XCTAssertEqual(tree.deepContains(searchBag).map(\.name), [
      "bright white",
      "muted yellow",
      "dark orange",
      "light red",
    ])
  }
}
