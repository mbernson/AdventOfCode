import Foundation

public struct Day3 {
  public let inputURL = Bundle.module.url(forResource: "day3", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
    
    return gammaRate(input: input)! * epsilonRate(input: input)!
  }

  private func commonDigit(column: Int, in input: [String], comparator: (Int, Int) -> Bool) -> Int {
    var result: [Int: Int] = [:]

    for line in input {
      let digit = Int(String(line[line.index(line.startIndex, offsetBy: column)]))!
      if result[digit] == nil {
        result[digit] = 0
      }
      result[digit] = result[digit]! + 1
    }

    return result.sorted(by: { lhs, rhs in
      if lhs.value == rhs.value {
        return comparator(lhs.key, rhs.key)
      } else {
        return comparator(lhs.value, rhs.value)
      }
    }).first!.key
  }

  func mostCommonDigit(column: Int, in input: [String]) -> Int {
    commonDigit(column: column, in: input, comparator: >)
  }

  func leastCommonDigit(column: Int, in input: [String]) -> Int {
    commonDigit(column: column, in: input, comparator: <)
  }

  func gammaRate(input: [String]) -> Int? {
    let columns = (0..<input[0].count)
    let rate: String = columns.map { column in
      String(mostCommonDigit(column: column, in: input))
    }.joined()
    return Int(rate, radix: 2)
  }

  func epsilonRate(input: [String]) -> Int? {
    let columns = (0..<input[0].count)
    let rate: String = columns.map { column in
      String(leastCommonDigit(column: column, in: input))
    }.joined()
    return Int(rate, radix: 2)
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }

    return oxygenGeneratorRating(input: input)! * co2ScrubberRating(input: input)!
  }

  private func bitCriteria(input _input: [String], comparator: (Int, Int) -> Bool) -> Int? {
    var input = _input
    var result: String? = nil
    let columns = 0..<input[0].count
    for column in columns {
      let mostCommonDigit = String(commonDigit(column: column, in: input, comparator: comparator))
      input = input.filter { line in
        let idx: String.Index = line.index(line.startIndex, offsetBy: column)
        let c: String = String(line[idx])
        return c == mostCommonDigit
      }
      if input.count == 1 {
        result = input[0]
      }
    }

    return result.flatMap { Int($0, radix: 2) }
  }

  func oxygenGeneratorRating(input: [String]) -> Int? {
    bitCriteria(input: input, comparator: >)
  }

  func co2ScrubberRating(input: [String]) -> Int? {
    bitCriteria(input: input, comparator: <)
  }
}
