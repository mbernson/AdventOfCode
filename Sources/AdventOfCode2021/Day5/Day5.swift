import Foundation

public struct Day5 {
  public let inputURL = Bundle.module.url(forResource: "day5", withExtension: "txt")!

  public init() {}

  struct Vent: Equatable {
    let start: Coordinate
    let end: Coordinate

    var line: [Coordinate] {
      if start.x == end.x {
        // Vertical line
        let x = start.x
        if start.y < end.y {
          return (start.y...end.y).map { Coordinate(x: x, y: $0) }
        } else {
          return (end.y...start.y).map { Coordinate(x: x, y: $0) }
            .sorted(by: { lhs, rhs in lhs.y < rhs.y })
        }
      } else if start.y == end.y {
        // Horizontal line
        let y = start.y
        if start.x < end.x {
          return (start.x...end.x).map { Coordinate(x: $0, y: y) }
        } else {
          return (end.x...start.x).map { Coordinate(x: $0, y: y) }
//            .sorted(by: { lhs, rhs in lhs.x < rhs.x })
        }
      } else {
        // Not a line
        return []
      }
    }
  }

  struct Coordinate: Equatable {
    let x: Int
    let y: Int
  }

  func parseLine(line: String) -> Vent? {
    let parts = line.components(separatedBy: " -> ")
    assert(parts.count == 2)
    let start = parts[0].components(separatedBy: ",").compactMap(Int.init)
    let end = parts[1].components(separatedBy: ",").compactMap(Int.init)
    return Vent(start: .init(x: start[0], y: start[1]), end: .init(x: end[0], y: end[1]))
  }

  func overlappingCoordinates(in vents: [Vent]) -> [Coordinate] {
    let xs = vents.map(\.start).map(\.x) + vents.map(\.end).map(\.x)
    let ys = vents.map(\.start).map(\.y) + vents.map(\.end).map(\.y)
    let width = xs.max()! + 1
    let height = ys.max()! + 1
    var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: width), count: height)

    for vent in vents {
      for coordinate in vent.line {
        grid[coordinate.y][coordinate.x] += 1
      }
    }

    var result: [Coordinate] = []
    for (y, row) in grid.enumerated() {
      for (x, column) in row.enumerated() {
        if grid[y][x] >= 2 {
          result.append(Coordinate(x: x, y: y))
        }
      }
    }
    return result
  }

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
    let vents = input.compactMap(parseLine)
    return overlappingCoordinates(in: vents).count
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [String] = inputString
      .components(separatedBy: "\n")

    return 0
  }
}
