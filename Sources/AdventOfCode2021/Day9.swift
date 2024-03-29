import Foundation

public struct Day9 {
  public let inputURL = Bundle.module.url(forResource: "Input/day9", withExtension: "txt")!

  public init() {}

  struct Point: Equatable, Hashable {
    let x: Int
    let y: Int
    let value: Int
  }

  struct Basin: Equatable {
    let points: Set<Point>
    var size: Int { points.count }
  }

  func basins(in input: [[Int]]) -> [Basin] {
    lowPoints(in: input).map { point in
      basin(for: point, input: input)
    }
  }

  func basin(for point: Point, input: [[Int]]) -> Basin {
    return Basin(points: Set([point]).union(increasingPoints(around: point, input: input)))
  }

  private func increasingPoints(around point: Point, input: [[Int]]) -> Set<Point> {
    let ns = Set(neighbors(x: point.x, y: point.y, input: input)
      .filter { p in
        p.value < 9 && p.value > point.value
      })
    let others = ns.flatMap { neighor in
      increasingPoints(around: neighor, input: input)
    }
    return ns.union(others)
  }

  func lowPoints(in input: [[Int]]) -> [Point] {
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

    return result
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
      .map { 1 + $0.value }
      .reduce(0, +)
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [[Int]] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map { line in
        line.map(String.init).compactMap(Int.init)
      }

    let largestBasins: [Basin] = basins(in: input)
      .sorted(by: { $0.size > $1.size })

    return largestBasins[0...2]
      .map(\.size)
      .reduce(1, *)
  }
}
