import Foundation

public struct Day1 {
  public let inputURL = Bundle.module.url(forResource: "day1", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Int] = inputString
      .components(separatedBy: "\n")
      .compactMap(Int.init)
    return numbersThatIncrease(input)
  }
  
  func numbersThatIncrease(_ array: [Int]) -> Int {
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
  
  func numbersThatIncrease(_ array: [Int], window: Int) -> Int {
    let windowed: [Int] = windowedSums(array, window: window)
    return numbersThatIncrease(windowed)
  }
  
  func windowedSums(_ numbers: [Int], window: Int) -> [Int] {
    var result: [Int] = []
    for (startIndex, _) in numbers.enumerated() {
      let endIndex = startIndex + window
      if endIndex > numbers.endIndex {
        break
      }
      let range = numbers[startIndex..<endIndex]
      result.append(range.reduce(0, +))
    }
    return result
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Int] = inputString
      .components(separatedBy: "\n")
      .compactMap(Int.init)
    return numbersThatIncrease(input, window: 3)
  }
}
