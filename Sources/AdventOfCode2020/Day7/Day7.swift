import Foundation

public struct Day7 {
  public let inputURL = Bundle.module.url(forResource: "day7", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let bags = inputString.components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
      .compactMap(parseLine)
    let matches = bagsThatMayContain(bagName: "shiny gold", in: bags)
    return matches.count
  }

  public func runPart2() throws -> Int {
    return 0
  }

  let noOtherBagsRegex = try! NSRegularExpression(pattern: #"^([\w\s]+) bags contain no other bags.$"#, options: [])
  let bagsRegex = try! NSRegularExpression(pattern: #"^([\w\s]+) bags contain ([\w\s,]+).$"#, options: [])

  func parseLine(_ line: String) -> Bag? {
    let fullRange = NSRange(location: 0, length: line.utf16.count)

    if let match = noOtherBagsRegex.firstMatch(in: line, options: [], range: fullRange) {
      let bagNameRange = match.range(at: 1)
      let bagName = String(line[Range(bagNameRange, in: line)!])
      return Bag(name: bagName, contents: [])
    } else if let match = bagsRegex.firstMatch(in: line, options: [], range: fullRange) {
      let bagNameRange = match.range(at: 1)
      let bagName = String(line[Range(bagNameRange, in: line)!])
      let contentsRange = match.range(at: 2)
      let contents = String(line[Range(contentsRange, in: line)!])
      return Bag(name: bagName, contents: parseContents(contents))
    } else {
      return nil
    }
  }

  private func parseContents(_ line: String) -> [String] {
    let parts = line.split(separator: ",").map(String.init)
    return parts.flatMap(parseContent)
  }

  private func parseContent(_ part: String) -> [String] {
    let xs = part.split(separator: " ")
    let amount = Int(String(xs[0]))!
    let bagName: String = xs[1...2].joined(separator: " ")
    return Array(repeating: bagName, count: amount)
  }

  func bagsThatMayContain(bagName: String, in bags: [Bag]) -> Set<String> {
    var results = Set<String>()
    for bag in bags {
      if bag.contents.contains(bagName) {
        results.insert(bag.name)
      }
    }
    for bag in results {
      if !results.contains(bagName) {
        results = results.union(bagsThatMayContain(bagName: bag, in: bags))
      }
    }
    return results
  }

  struct Bag: Equatable {
    let name: String
    let contents: [String]
  }
}
