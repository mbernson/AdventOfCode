import Foundation

public struct Day7 {
  public let inputURL = Bundle.module.url(forResource: "day7", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
//    let inputString = try String(contentsOf: inputURL)
    let inputString = "light red bags contain 1 bright white bag, 2 muted yellow bags.\ndark orange bags contain 3 bright white bags, 4 muted yellow bags.\nbright white bags contain 1 shiny gold bag.\nmuted yellow bags contain 2 shiny gold bags, 9 faded blue bags.\nshiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.\ndark olive bags contain 3 faded blue bags, 4 dotted black bags.\nvibrant plum bags contain 5 faded blue bags, 6 dotted black bags.\nfaded blue bags contain no other bags.\ndotted black bags contain no other bags."
    let bags = inputString.components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
      .compactMap(makeBagsLine)
    print(bags)
    return 0
  }

  public func runPart2() throws -> Int {
    return 0
  }

  func makeBagsTree(from string: String) -> Bag {
    let bags = string.components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
      .compactMap(makeBagsLine)
    return Bag(name: "__ROOT__", children: bags)
  }

  func makeBagsLine(from string: String) -> Bag {
    print(string)
    let parts = string.split(separator: " ")
    let parentName = parts[0...1].joined(separator: " ")

    if string.contains("no other bags.") {
      return Bag(name: parentName, children: [])
    } else {
      // ["1 bright white bag", "2 muted yellow bags."]
      let childrenStrings = parts[4...].joined(separator: " ")
        .components(separatedBy: ", ")
      let children: [Bag] = childrenStrings.flatMap { string -> [Bag] in
        let components = string.components(separatedBy: " ")
        let quantity = Int(components[0]) ?? 1
        let childName = components[1...2].joined(separator: " ")
        return (0..<quantity).map { _ in
          Bag(name: childName, children: [])
        }
      }
      return Bag(name: parentName, children: children)
    }
  }

  struct Bag: Equatable {
    let name: String
    var children: [Bag]

    func canContain(_ other: Bag) -> Bool {
      return children.map(\.name).contains(other.name)
    }

    func deepContains(_ other: Bag) -> [Bag] {
      children.filter { $0.canContain(other) } +
        children.flatMap { $0.deepContains(other) }
    }

    mutating func deepAppend(_ other: Bag, to name: String) {
      if self.name == name {
        children.append(other)
      }

      self.children = children.map { _child -> Bag in
        var child = _child
        child.deepAppend(other, to: name)
        return child
      }
    }
  }
}
