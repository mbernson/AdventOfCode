@testable import AdventOfCode2020
import XCTest

final class Day6Tests: XCTestCase {
  func testParseSingleGroup() throws {
    let input = "abcx\nabcy\nabcz\n"
    let group = Day6().makeGroup(string: input)
    XCTAssertEqual(group, Day6.Group(people: [
      Day6.Person(answers: ["a", "b", "c", "x"]),
      Day6.Person(answers: ["a", "b", "c", "y"]),
      Day6.Person(answers: ["a", "b", "c", "z"]),
    ]))
  }

  func testParseMultipleGroups() {
    let input = "abc\n\na\nb\nc\n\nab\nac\n\na\na\na\na\n\nb"
    let groups = Day6().makeGroups(string: input)
    XCTAssertEqual(groups, [
      Day6.Group(people: [
        Day6.Person(answers: ["a", "b", "c"]),
      ]),
      Day6.Group(people: [
        Day6.Person(answers: ["a"]),
        Day6.Person(answers: ["b"]),
        Day6.Person(answers: ["c"]),
      ]),
      Day6.Group(people: [
        Day6.Person(answers: ["a", "b"]),
        Day6.Person(answers: ["a", "c"]),
      ]),
      Day6.Group(people: [
        Day6.Person(answers: ["a"]),
        Day6.Person(answers: ["a"]),
        Day6.Person(answers: ["a"]),
        Day6.Person(answers: ["a"]),
      ]),
      Day6.Group(people: [
        Day6.Person(answers: ["b"]),
      ]),
    ])
  }

  func testCountAnswersAnyoneYes() throws {
    let input = "abc\n\na\nb\nc\n\nab\nac\n\na\na\na\na\n\nb"
    let groups = Day6().makeGroups(string: input)
    XCTAssertEqual(Day6().countAnswersAnyAnsweredYes(in: groups), 11)
  }

  func testCountAnswersEveryoneYes() throws {
    let input = "abc\n\na\nb\nc\n\nab\nac\n\na\na\na\na\n\nb"
    let groups = Day6().makeGroups(string: input)
    XCTAssertEqual(groups[0].questionsWhereAllAnsweredYes, ["a", "b", "c"])
    XCTAssertEqual(groups[1].questionsWhereAllAnsweredYes, [])
    XCTAssertEqual(groups[2].questionsWhereAllAnsweredYes, ["a"])
    XCTAssertEqual(groups[3].questionsWhereAllAnsweredYes, ["a"])
    XCTAssertEqual(groups[4].questionsWhereAllAnsweredYes, ["b"])
    XCTAssertEqual(Day6().countAnswersAllAnsweredYes(in: groups), 6)
  }
}
