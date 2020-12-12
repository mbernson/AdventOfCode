import Foundation

public struct Day9 {
  public let inputURL = Bundle.module.url(forResource: "day9", withExtension: "txt")!

  public init() {}

  func parseInput() throws -> [Int] {
    return try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
      .map { Int($0)! }
  }

  public func runPart1() throws -> Int {
    let numbers = try parseInput()
    guard let n = findInvalidNumber(numbers) else {
      throw Day9Error.noSolutionFound
    }
    return n
  }

  public func runPart2(invalidNumber: Int) throws -> Int {
    let numbers = try parseInput()
    guard let result = contiguousSetAddingUpTo(result: invalidNumber, in: numbers)?.sorted(),
          let first = result.first, let last = result.last
    else {
      throw Day9Error.noSolutionFound
    }
    return first + last
  }

  func contiguousSetAddingUpTo(result: Int, in numbers: [Int]) -> [Int]? {
    for (index, _) in numbers.enumerated() {
      let start = index
      var end = index
      while true {
        end += 1
        let ns = numbers[start...end]
        let total = ns.reduce(0, +)
        if total < result {
          continue
        } else if total == result {
          return Array(ns)
        } else if total > result {
          break
        }
        if !numbers.indices.contains(end) {
          break
        }
      }
    }
    return nil
  }

  func findInvalidNumber(_ numbers: [Int]) -> Int? {
    for (index, n) in numbers.enumerated() {
      if index >= 25 {
        let preamble = Array(numbers[(index - 25)..<index])
        if !isValid(number: n, in: preamble) {
          return n
        }
      }
    }
    return nil
  }

  func isValid(number: Int, in preamble: [Int]) -> Bool {
    for (idx, x) in preamble.enumerated() {
      for (idy, y) in preamble.enumerated() {
        if idx != idy, x + y == number {
          return true
        }
      }
    }
    return false
  }

  enum Day9Error: Error {
    case noSolutionFound
  }
}
