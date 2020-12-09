import Foundation

public struct Day9 {
  public let inputURL = Bundle.module.url(forResource: "day9", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let numbers = try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
      .map { Int($0)! }

    for (index, n) in numbers.enumerated() {
      if index >= 25 {
        let preamble = Array(numbers[(index - 25)..<index])
        if !isValid(number: n, in: preamble) {
          return n
        }
      }
    }

    throw Day9Error.noSolutionFound
  }

  public func runPart2() throws -> Int {
    return 0
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
