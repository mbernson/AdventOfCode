import Foundation

public struct Day1 {
  public let inputURL = Bundle.module.url(forResource: "day1", withExtension: "txt")!

  public init() {}

  func fuel(forMass mass: Double) -> Double {
    floor(mass / 3) - 2
  }

  func totalFuel(forMass mass: Double) -> Double {
    var fuel = self.fuel(forMass: mass)
    var total: Double = fuel
    while true {
      fuel = self.fuel(forMass: fuel)
      if fuel < 0 {
        break
      } else {
        total += fuel
      }
    }
    return total
  }

  public func runPart1() throws -> Double {
    let input = try String(contentsOf: inputURL)
    return input
      .components(separatedBy: "\n")
      .compactMap(Double.init)
      .map(fuel(forMass:))
      .reduce(0, +)
  }

  public func runPart2() throws -> Double {
    let input = try String(contentsOf: inputURL)
    return input
      .components(separatedBy: "\n")
      .compactMap(Double.init)
      .map(totalFuel(forMass:))
      .reduce(0, +)
  }
}
