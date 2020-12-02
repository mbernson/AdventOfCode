import Foundation

public struct Day2 {
  public let inputURL = Bundle.module.url(forResource: "day2", withExtension: "txt")!

  public init() {}

  func getInput() throws -> [(Password, PasswordRule)] {
    try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map(makePasswordLine)
  }

  public func runPart1() throws -> Int {
    try getInput()
      .map { (password, rule) in
        rule.testPart1(password: password)
      }
      .filter { $0 == true }
      .count
  }

  public func runPart2() throws -> Int {
    try getInput()
      .map { (password, rule) in
        rule.testPart2(password: password)
      }
      .filter { $0 == true }
      .count
  }

  func makePasswordLine(string: String) throws -> (Password, PasswordRule) {
    let parts = string.components(separatedBy: ": ")
    assert(parts.count == 2)
    let ruleDescriptor = parts[0].components(separatedBy: " ")
    assert(ruleDescriptor.count == 2)
    let password: Password = parts[1]
    let rangeDescriptor = ruleDescriptor[0]
    let rangeParts = rangeDescriptor.components(separatedBy: "-").map { Int($0)! }
    assert(rangeParts.count == 2)
    let range = rangeParts[0]...rangeParts[1]
    let character = Character(ruleDescriptor[1])
    let rule = PasswordRule(character: character, occurrences: range)
    return (password, rule)
  }

  public typealias Password = String

  public struct PasswordRule {
    let character: Character
    let occurrences: ClosedRange<Int>

    public init(character: Character, occurrences: ClosedRange<Int>) {
      self.character = character
      self.occurrences = occurrences
    }

    public func testPart1(password: Password) -> Bool {
      return occurrences.contains(password.filter({ $0 == character }).count)
    }

    public func testPart2(password: Password) -> Bool {
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
