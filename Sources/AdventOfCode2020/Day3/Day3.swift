import Foundation

public struct Day3 {
  public let inputURL = Bundle.module.url(forResource: "day3", withExtension: "txt")!

  public init() {}

  enum Point {
    case tree
    case empty
  }

  struct Position {
    var x: Int
    var y: Int

    static let zero = Position(x: 0, y: 0)
  }

  func parseInput(input: String) -> [[Point]] {
    input
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map(parseInputRow)
  }

  private func parseInputRow(input: String) -> [Point] {
    input.compactMap { char -> Point? in
      switch char {
      case ".":
        return .empty
      case "#":
        return .tree
      default:
        return nil
      }
    }
  }

  public func runPart1() throws -> Int {
    let grid = parseInput(input: try String(contentsOf: inputURL))
    return numberOfTreesHit(grid: grid)
  }

  func numberOfTreesHit(grid: [[Point]]) -> Int {
    var position = Position.zero
    var numberOfTreesHit = 0
    while position.y < (grid.count - 1) {
      // Move 3 to the right
      position.x += 3
      // Move 1 down
      position.y += 1
      // Get object at current position
      let row = grid[position.y]
      let object = row[position.x % row.count]
      // Increment variable if tree is hit
      if case .tree = object {
        numberOfTreesHit += 1
      }
    }
    return numberOfTreesHit
  }

  public func runPart2() throws -> Int {
    return 0
  }
}
