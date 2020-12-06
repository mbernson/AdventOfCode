import Foundation

public struct Day6 {
  public let inputURL = Bundle.module.url(forResource: "day6", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let groups = makeGroups(string: inputString)
    return countAnswers(in: groups)
  }

  public func runPart2() throws -> Int {
    return 0
  }

  func countAnswers(in groups: [Group]) -> Int {
    return groups.reduce(0, { total, group in
      return total + group.combinedAnswers.filter({ _, v in v == true}).count
    })
  }

  func makeGroups(string: String) -> [Group] {
    string
      .components(separatedBy: "\n\n")
      .filter { !$0.isEmpty }
      .map(makeGroup)
  }

  func makeGroup(string: String) -> Group {
    return Group(
      people: string.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map(makePerson)
    )
  }

  func makePerson(line: String) -> Person {
    var answers = [String : Bool]()
    line.map(String.init)
      .forEach {
        if !answers.keys.contains($0) {
          answers[$0] = true
        }
      }
    return Person(answers: answers)
  }

  struct Group: Equatable {
    let people: [Person]

    var combinedAnswers: [String: Bool] {
      return people.reduce([:], { acc, person in
        return acc.merging(person.answers, uniquingKeysWith: { a, b in a })
      })
    }
  }

  struct Person: Equatable {
    let answers: [String : Bool]
  }
}
