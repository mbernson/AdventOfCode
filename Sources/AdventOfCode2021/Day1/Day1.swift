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
    (array.startIndex..<(array.endIndex - 1))
      .map { startIndex in
        let endIndex = startIndex + 1
        let current = array[startIndex]
        let next = array[endIndex]
        return next > current
      }
      .filter { $0 == true }
      .count
  }

  func numbersThatIncrease(_ array: [Int], window: Int) -> Int {
    let windowed: [Int] = windowedSums(array, window: window)
    return numbersThatIncrease(windowed)
  }

  func windowedSums(_ numbers: [Int], window: Int) -> [Int] {
    (numbers.startIndex...(numbers.endIndex - window)).map { startIndex in
      let endIndex = startIndex + window
      return numbers[startIndex..<endIndex].reduce(0, +)
    }
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Int] = inputString
      .components(separatedBy: "\n")
      .compactMap(Int.init)
    return numbersThatIncrease(input, window: 3)
  }
}
