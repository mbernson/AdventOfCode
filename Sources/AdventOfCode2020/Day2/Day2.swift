import Foundation

public struct Day2 {
  public let inputURL = Bundle.module.url(forResource: "day2", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let lines = try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map(makePasswordLine)

    return lines
      .map { (password, rule) in
        rule.test(password: password)
      }
      .filter { $0 == true }
      .count
  }

  func makePasswordLine(string: String) throws -> (PasswordRules.Password, PasswordRules.PasswordRule1) {
    let parts = string.components(separatedBy: ": ")
    assert(parts.count == 2)
    let ruleDescriptor = parts[0].components(separatedBy: " ")
    assert(ruleDescriptor.count == 2)
    let password: PasswordRules.Password = parts[1]
    let rangeDescriptor = ruleDescriptor[0]
    let rangeParts = rangeDescriptor.components(separatedBy: "-").map { Int($0)! }
    assert(rangeParts.count == 2)
    let range = rangeParts[0]...rangeParts[1]
    let character = Character(ruleDescriptor[1])
    let rule = PasswordRules.PasswordRule1(character: character, occurrences: range)
    return (password, rule)
  }
}

public enum PasswordRules {

  public typealias Password = String

  public struct PasswordRule1 {
    let character: Character
    let occurrences: ClosedRange<Int>

    public init(character: Character, occurrences: ClosedRange<Int>) {
      self.character = character
      self.occurrences = occurrences
    }

    public func test(password: Password) -> Bool {
      return occurrences.contains(password.filter({ $0 == character }).count)
    }
  }

}
