import Foundation

public struct Day6 {
  public let inputURL = Bundle.module.url(forResource: "day6", withExtension: "txt")!

  public init() {}

  class Fishbowl {
    var fish: [Int] = Array(repeating: 0, count: 8 + 1)

    var amountOfFish: Int {
      fish.reduce(0, +)
    }

    init(input: [Int]) {
      for f in input {
        fish[f] = fish[f] + 1
      }
    }

    func cycle() {
      var result: [Int] = Array(repeating: 0, count: 8 + 1)
      result[0] = fish[1]
      result[1] = fish[2]
      result[2] = fish[3]
      result[3] = fish[4]
      result[4] = fish[5]
      result[5] = fish[6]
      result[6] = fish[7] + fish[0]
      result[7] = fish[8]
      result[8] = fish[0]
      self.fish = result
    }
  }

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Int] = inputString
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: ",")
      .compactMap(Int.init)

    let fishbowl = Fishbowl(input: input)
    for _ in 1...80 {
      fishbowl.cycle()
    }

    return fishbowl.amountOfFish
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Int] = inputString
      .trimmingCharacters(in: .whitespacesAndNewlines)
      .components(separatedBy: ",")
      .compactMap(Int.init)

    let fishbowl = Fishbowl(input: input)
    for _ in 1...256 {
      fishbowl.cycle()
    }

    return fishbowl.amountOfFish
  }
}
