import Foundation

public struct Day6 {
  public let inputURL = Bundle.module.url(forResource: "Input/day6", withExtension: "txt")!

  public init() {}

  class Fishbowl {
    var fish: [Int] = Array(repeating: 0, count: 9)

    var amountOfFish: Int {
      fish.reduce(0, +)
    }

    init(input: [Int]) {
      for f in input {
        fish[f] = fish[f] + 1
      }
    }

    func cycle() {
      fish = [
        fish[1],
        fish[2],
        fish[3],
        fish[4],
        fish[5],
        fish[6],
        fish[7] + fish[0],
        fish[8],
        fish[0],
      ]
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
