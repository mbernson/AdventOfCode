import Foundation

public struct Day9 {
  public let inputURL = Bundle.module.url(forResource: "Input/day9", withExtension: "txt")!

  public init() {}

  struct Point: Equatable {
    let x: Int
    let y: Int
    let value: Int
  }

  func lowPoints(in input: [[Int]]) -> [Int] {
    var result: [Point] = []

    for (rowIndex, row) in input.enumerated() {
      for (colIndex, n) in row.enumerated() {
        let neighbors = self.neighbors(x: colIndex, y: rowIndex, input: input)
        let lowestPoint = neighbors.min(by: { $0.value < $1.value })
        if let lowestPoint = lowestPoint, n < lowestPoint.value {
          result.append(Point(x: colIndex, y: rowIndex, value: n))
        }
      }
    }

    return result.map(\.value)
  }

  func neighbors(x: Int, y: Int, input: [[Int]]) -> [Point] {
    var result: [Point] = []
    let width = input[0].count
    let height = input.count
    // Top
    if y > 0 {
      result.append(Point(x: x, y: y - 1, value: input[y - 1][x]))
    }
    // Left
    if x > 0 {
      result.append(Point(x: x - 1, y: y, value: input[y][x - 1]))
    }
    // Right
    if x < (width - 1) {
      result.append(Point(x: x + 1, y: y, value: input[y][x + 1]))
    }
    // Bottom
    if y < (height - 1) {
      result.append(Point(x: x, y: y + 1, value: input[y + 1][x]))
    }
    return result
  }

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [[Int]] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map { line in
        line.map(String.init).compactMap(Int.init)
      }

    return lowPoints(in: input)
      .map { 1 + $0 }
      .reduce(0, +)
  }

  public func runPart2() throws -> Int {
    return 0
  }
}
