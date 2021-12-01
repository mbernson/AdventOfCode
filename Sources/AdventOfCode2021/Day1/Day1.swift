import Foundation

public struct Day1 {
  public let inputURL = Bundle.module.url(forResource: "day1", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Int] = inputString
      .components(separatedBy: "\n")
      .compactMap(Int.init)
    return numbersThatIncrease(array: input)
  }
  
  func numbersThatIncrease(array: [Int]) -> Int {
    var numbers = array
    var prev = numbers.removeFirst()
    var result = 0
    for number in numbers {
      if number > prev {
        result += 1
      }
      prev = number
    }
    return result
  }

  public func runPart2() throws -> Int {
    return 42 * 2
  }
}
