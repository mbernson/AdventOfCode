import Foundation

public struct Day3 {
  public let inputURL = Bundle.module.url(forResource: "day3", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
    
    return gammaRate(input: input) * epsilonRate(input: input)
  }

  public func runPart2() throws -> Int {
    return 0
  }

  func commonDigit(row: Int, in input: [String], comparator: (Int, Int) -> Bool) -> Int {
    var result: [Int: Int] = [:]

    for line in input {
      let digit = Int(String(line[line.index(line.startIndex, offsetBy: row)]))!
      if result[digit] == nil {
        result[digit] = 0
      }
      result[digit] = result[digit]! + 1
    }

    return result.sorted(by: { lhs, rhs in
      comparator(lhs.value, rhs.value)
    }).first!.key
  }

  func mostCommonDigit(row: Int, in input: [String]) -> Int {
    commonDigit(row: row, in: input, comparator: >)
  }

  func leastCommonDigit(row: Int, in input: [String]) -> Int {
    commonDigit(row: row, in: input, comparator: <)
  }

  func gammaRate(input: [String]) -> Int {
    let rate: String = (0..<input[0].count).map { row in
      String(mostCommonDigit(row: row, in: input))
    }.joined()
    return Int(rate, radix: 2)!
  }

  func epsilonRate(input: [String]) -> Int {
    let rate: String = (0..<input[0].count).map { row in
      String(leastCommonDigit(row: row, in: input))
    }.joined()
    return Int(rate, radix: 2)!
  }
}
