@testable import AdventOfCode2020
import XCTest

final class Day6Tests: XCTestCase {
  func testParseSingleGroup() throws {
    let input = "abcx\nabcy\nabcz\n"
    let group = Day6().makeGroup(string: input)
    XCTAssertEqual(group, Day6.Group(people: [
      Day6.Person(answers: ["a": true, "b": true, "c": true, "x": true]),
      Day6.Person(answers: ["a": true, "b": true, "c": true, "y": true]),
      Day6.Person(answers: ["a": true, "b": true, "c": true, "z": true]),
    ]))
  }

  func testParseMultipleGroups() {
    let input = "abc\n\na\nb\nc\n\nab\nac\n\na\na\na\na\n\nb"
    let groups = Day6().makeGroups(string: input)
    XCTAssertEqual(groups, [
      Day6.Group(people: [
        Day6.Person(answers: ["a": true, "b": true, "c": true]),
      ]),
      Day6.Group(people: [
        Day6.Person(answers: ["a": true]),
        Day6.Person(answers: ["b": true]),
        Day6.Person(answers: ["c": true]),
      ]),
      Day6.Group(people: [
        Day6.Person(answers: ["a": true, "b": true]),
        Day6.Person(answers: ["a": true, "c": true]),
      ]),
      Day6.Group(people: [
        Day6.Person(answers: ["a": true]),
        Day6.Person(answers: ["a": true]),
        Day6.Person(answers: ["a": true]),
        Day6.Person(answers: ["a": true]),
      ]),
      Day6.Group(people: [
        Day6.Person(answers: ["b": true]),
      ]),
    ])
  }

  func testCountAnswersAnyoneYes() throws {
    let input = "abc\n\na\nb\nc\n\nab\nac\n\na\na\na\na\n\nb"
    let groups = Day6().makeGroups(string: input)
    XCTAssertEqual(Day6().countAnswersAnyoneYes(in: groups), 11)
  }

  func testCountAnswersEveryoneYes() throws {
    let input = "abc\n\na\nb\nc\n\nab\nac\n\na\na\na\na\n\nb"
    let groups = Day6().makeGroups(string: input)
    XCTAssertEqual(groups[0].allAnsweredYes, Set(["a", "b", "c"]))
    XCTAssertEqual(groups[1].allAnsweredYes, Set())
    XCTAssertEqual(groups[2].allAnsweredYes, Set(["a"]))
    XCTAssertEqual(groups[3].allAnsweredYes, Set(["a"]))
    XCTAssertEqual(groups[4].allAnsweredYes, Set(["b"]))
    XCTAssertEqual(Day6().countAnswersEveryoneYes(in: groups), 6)
  }
}
