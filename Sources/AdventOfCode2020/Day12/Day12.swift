import Foundation

public struct Day12 {
  public let inputURL = Bundle.module.url(forResource: "day00", withExtension: "txt")!

  public init() {}

  func parseInput(string: String) -> [String] {
    return string
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map { _ in "foo" }
  }

  public func runPart1() throws -> Int {
    let input = parseInput(string: try String(contentsOf: inputURL))
    return 0
  }

  public func runPart2() throws -> Int {
    let input = parseInput(string: try String(contentsOf: inputURL))
    return 0
  }
}
