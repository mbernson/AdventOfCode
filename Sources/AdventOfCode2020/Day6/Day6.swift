import Foundation

public struct Day6 {
  public let inputURL = Bundle.module.url(forResource: "day6", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let groups = makeGroups(string: inputString)
    return countAnswersAnyAnsweredYes(in: groups)
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let groups = makeGroups(string: inputString)
    return countAnswersAllAnsweredYes(in: groups)
  }

  func countAnswersAnyAnsweredYes(in groups: [Group]) -> Int {
    return groups.map(\.questionsWhereAnyAnsweredYes)
      .map(\.count).reduce(0, +)
  }

  func countAnswersAllAnsweredYes(in groups: [Group]) -> Int {
    return groups.map(\.questionsWhereAllAnsweredYes)
      .map(\.count).reduce(0, +)
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
    return Person(questionsAnsweredYes: Set(line.map(String.init)))
  }

  struct Group: Equatable {
    let people: [Person]

    var questionsWhereAnyAnsweredYes: Set<String> {
      return people.reduce(Set(), { acc, person in
        return acc.union(person.questionsAnsweredYes)
      })
    }

    var questionsWhereAllAnsweredYes: Set<String> {
      return questionsWhereAnyAnsweredYes.filter { answer in
        people.allSatisfy { person in
          person.questionsAnsweredYes.contains(answer)
        }
      }
    }
  }

  struct Person: Equatable {
    let questionsAnsweredYes: Set<String>
  }
}
