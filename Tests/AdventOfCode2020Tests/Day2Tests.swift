@testable import AdventOfCode2020
import XCTest

final class Day2Tests: XCTestCase {
  func testValidPasswordRules() throws {
    let rule1 = PasswordRules.PasswordRule1(character: "f", occurrences: 1...2)
    XCTAssertEqual(rule1.test(password: "xkqzbcrsdswpf"), true)

    let rule2 = PasswordRules.PasswordRule1(character: "x", occurrences: 14...15)
    XCTAssertEqual(rule2.test(password: "xxxxxxxxxxxxxwx"), true)
  }

  func testInvalidPasswordRules() throws {
    let rule1 = PasswordRules.PasswordRule1(character: "b", occurrences: 1...3)
    XCTAssertEqual(rule1.test(password: "cdefg"), false)
  }

  func testPasswordParsing() throws {
    let (password, rule) = try Day2().makePasswordLine(string: "14-15 x: xxxxxxxxxxxxxwx")
    XCTAssertEqual(password, "xxxxxxxxxxxxxwx")
    XCTAssertEqual(rule.character, "x")
    XCTAssertEqual(rule.occurrences, 14...15)
  }

  func testPasswordParsing2() throws {
    let (password, rule) = try Day2().makePasswordLine(string: "16-17 j: jjjvhgjzjwjzjmjnj")
    XCTAssertEqual(password, "jjjvhgjzjwjzjmjnj")
    XCTAssertEqual(rule.character, "j")
    XCTAssertEqual(rule.occurrences, 16...17)
  }
}
