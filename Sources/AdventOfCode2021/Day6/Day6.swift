import Foundation

public struct Day6 {
  public let inputURL = Bundle.module.url(forResource: "day6", withExtension: "txt")!

  public init() {}

  class Fishbowl {
    var fish: [Int]

    init(input: [Int]) {
      self.fish = input
    }

    func cycle() {
      var existing: [Int] = []
      var newborn: [Int] = []
      for fish in self.fish {
        switch fish {
        case 0:
          existing.append(6)
          newborn.append(8)
        default:
          existing.append(fish - 1)
        }
      }
      fish = existing + newborn
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

    return fishbowl.fish.count
  }

  public func runPart2() throws -> Int {
//    let inputString = try String(contentsOf: inputURL)
//    let input: [Int] = inputString
//      .components(separatedBy: "\n")
//      .compactMap(Int.init)

    return 0
  }
}
