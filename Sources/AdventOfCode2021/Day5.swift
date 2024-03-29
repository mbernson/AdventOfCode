import Foundation

private func stride1(from start: Int, through end: Int) -> StrideThrough<Int> {
  stride(from: start, through: end, by: start < end ? 1 : -1)
}

public struct Day5 {
  public let inputURL = Bundle.module.url(forResource: "Input/day5", withExtension: "txt")!

  public init() {}

  struct Vent: Equatable {
    let start: Coordinate
    let end: Coordinate

    func coordinatesForLines(includingDiagonals: Bool = true) -> [Coordinate] {
      if start.x == end.x {
        // Vertical line
        let verticalRange = stride1(from: start.y, through: end.y)
        return verticalRange.map { Coordinate(x: start.x, y: $0) }
      } else if start.y == end.y {
        // Horizontal line
        let horizontalRange = stride1(from: start.x, through: end.x)
        return horizontalRange.map { Coordinate(x: $0, y: start.y) }
      } else if includingDiagonals && abs(start.x - end.x) == abs(start.y - end.y) {
        // Diagonal line (45 degrees only)
        let horizontalRange = stride1(from: start.x, through: end.x)
        let verticalRange = stride1(from: start.y, through: end.y)
        return zip(horizontalRange, verticalRange).map { x, y in
          Coordinate(x: x, y: y)
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

  func overlappingCoordinates(in vents: [Vent], includingDiagonals: Bool) -> [Coordinate] {
    let xs = vents.map(\.start).map(\.x) + vents.map(\.end).map(\.x)
    let ys = vents.map(\.start).map(\.y) + vents.map(\.end).map(\.y)
    let width = xs.max()! + 1
    let height = ys.max()! + 1
    var grid: [[Int]] = Array(repeating: Array(repeating: 0, count: width), count: height)

    for vent in vents {
      for coordinate in vent.coordinatesForLines(includingDiagonals: includingDiagonals) {
        grid[coordinate.y][coordinate.x] += 1
      }
    }

    var result: [Coordinate] = []
    for (y, row) in grid.enumerated() {
      for (x, _) in row.enumerated() {
        if grid[y][x] >= 2 {
          result.append(Coordinate(x: x, y: y))
        }
      }
    }
    return result
  }

  func vents(from inputString: String) -> [Vent] {
    let input: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
    let vents = input.compactMap(parseLine)
    return vents
  }

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let vents = vents(from: inputString)
    return overlappingCoordinates(in: vents, includingDiagonals: false)
      .count
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let vents = vents(from: inputString)
    return overlappingCoordinates(in: vents, includingDiagonals: true)
      .count
  }
}
