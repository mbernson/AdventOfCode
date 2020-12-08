import Foundation

public struct Day7 {
  public let inputURL = Bundle.module.url(forResource: "day7", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
//    let inputString = try String(contentsOf: inputURL)
    let inputString = "light red bags contain 1 bright white bag, 2 muted yellow bags.\ndark orange bags contain 3 bright white bags, 4 muted yellow bags.\nbright white bags contain 1 shiny gold bag.\nmuted yellow bags contain 2 shiny gold bags, 9 faded blue bags.\nshiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.\ndark olive bags contain 3 faded blue bags, 4 dotted black bags.\nvibrant plum bags contain 5 faded blue bags, 6 dotted black bags.\nfaded blue bags contain no other bags.\ndotted black bags contain no other bags."
    let bags = inputString.components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
      .compactMap(makeBag)
    print(bags)
    return 0
  }

  public func runPart2() throws -> Int {
    return 0
  }

  func makeBag(from string: String) -> Bag? {
    print(string)
    let parts = string.split(separator: " ")
    let parentName = parts[0...1].joined(separator: " ")

    if string.contains("no other bags.") {
      return Bag(name: parentName, children: [])
    } else {
      return nil
    }
  }

  struct Bag {
    let name: String
    let children: [Bag]
  }
}
