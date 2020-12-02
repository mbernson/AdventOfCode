@testable import AdventOfCode2020
import XCTest

final class Day2Tests: XCTestCase {
  func testPasswordRules1Valid() throws {
    let rule1 = Day2.PasswordRule(character: "f", occurrences: 1...2)
    XCTAssertEqual(rule1.testPart1(password: "xkqzbcrsdswpf"), true)

    let rule2 = Day2.PasswordRule(character: "x", occurrences: 14...15)
    XCTAssertEqual(rule2.testPart1(password: "xxxxxxxxxxxxxwx"), true)
  }

  func testPasswordRules1Invalid() throws {
    let rule1 = Day2.PasswordRule(character: "b", occurrences: 1...3)
    XCTAssertEqual(rule1.testPart1(password: "cdefg"), false)
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

  func testPasswordParsing3() throws {
    let (password, rule) = try Day2().makePasswordLine(string: "2-9 c: ccccccccc")
    XCTAssertEqual(password, "ccccccccc")
    XCTAssertEqual(rule.character, "c")
    XCTAssertEqual(rule.occurrences, 2...9)
  }

  func testValidPasswordRules2Valid() throws {
    let rule = Day2.PasswordRule(character: "a", occurrences: 1...3)
    XCTAssertTrue(rule.testPart2(password: "abcde"))
  }

  func testValidPasswordRules2Invalid() throws {
    let rule = Day2.PasswordRule(character: "b", occurrences: 1...3)
    XCTAssertFalse(rule.testPart2(password: "cdefg"))
    let rule2 = Day2.PasswordRule(character: "c", occurrences: 2...9)
    XCTAssertFalse(rule2.testPart2(password: "ccccccccc"))
  }

}
