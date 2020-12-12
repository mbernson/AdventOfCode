import Foundation

public struct Day10 {
  public let inputURL = Bundle.module.url(forResource: "day10", withExtension: "txt")!

  public init() {}

  func parseInput() throws -> [Int] {
    return try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
      .map { Int($0)! }
  }

  public func runPart1() throws -> Int {
    var input = try parseInput()
    input.sort()
    input.append(input.max()! + 3)

    var oneJoltDifferences = 0
    var threeJoltDifferences = 0
    var currentAdapter = 0
    for adapter in input {
      let difference = adapter - currentAdapter

      if difference == 1 {
        oneJoltDifferences += 1
      } else if difference == 3 {
        threeJoltDifferences += 1
      }

      currentAdapter = adapter
    }
    return oneJoltDifferences * threeJoltDifferences
  }

  public func runPart2() throws -> Int {
    let input = try parseInput()
    return arrangements(for: input)
  }

  func arrangements(for _input: [Int]) -> Int {
    var input = _input
    input.sort()
    input.insert(0, at: 0)
    input.append(input.max()! + 3)

    var seen = [Int: Int]()
    seen[0] = 1

    for adapter in input {
      let permissibleRange = (adapter + 1)...(adapter + 3)
      let reachable = input.filter { permissibleRange.contains($0) }
      for candidate in reachable {
        let add = seen[adapter] ?? 0
        seen[candidate] = (seen[candidate] ?? 0) + add
      }
    }
    return seen[input.max()!]!
  }
}
