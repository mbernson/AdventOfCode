import Foundation

public struct Day2 {
  public let inputURL = Bundle.module.url(forResource: "day2", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    return try parseInput()
      .map { (password, rule) in
        rule.testPart1(password: password)
      }
      .filter { $0 == true }
      .count
  }

  public func runPart2() throws -> Int {
    return try parseInput()
      .map { (password, rule) in
        rule.testPart2(password: password)
      }
      .filter { $0 == true }
      .count
  }

  func parseInput() throws -> [(String, PasswordRule)] {
    return try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map(makePasswordLine)
  }

  func makePasswordLine(string: String) throws -> (password: String, rule: PasswordRule) {
    let parts = string.components(separatedBy: ": ")
    assert(parts.count == 2)
    let ruleDescriptor = parts[0].components(separatedBy: " ")
    assert(ruleDescriptor.count == 2)
    let password = parts[1]
    let rangeDescriptor = ruleDescriptor[0]
    let rangeParts = rangeDescriptor.components(separatedBy: "-").map { Int($0)! }
    assert(rangeParts.count == 2)
    let range = rangeParts[0]...rangeParts[1]
    let character = Character(ruleDescriptor[1])
    let rule = PasswordRule(character: character, occurrences: range)
    return (password, rule)
  }

  struct PasswordRule {
    let character: Character
    let occurrences: ClosedRange<Int>

    func testPart1(password: String) -> Bool {
      return occurrences.contains(password.filter({ $0 == character }).count)
    }

    func testPart2(password: String) -> Bool {
      return [occurrences.lowerBound, occurrences.upperBound]
        .map { index in
          password[index - 1]
        }
        .filter { $0 == character }
        .count == 1
    }
  }
}

extension StringProtocol {
  subscript(offset: Int) -> Character { self[index(startIndex, offsetBy: offset)] }
}
