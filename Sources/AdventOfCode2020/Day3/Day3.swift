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
    return numberOfTreesHit(grid: grid, movement: Position(x: 3, y: 1))
  }

  func numberOfTreesHit(grid: [[Point]], movement: Position) -> Int {
    var position = Position.zero
    var numberOfTreesHit = 0
    while position.y < (grid.count - 1) {
      // Move to the right
      position.x += movement.x
      // Move down
      position.y += movement.y
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
    let movements: [Position] = [
      Position(x: 1, y: 1),
      Position(x: 3, y: 1),
      Position(x: 5, y: 1),
      Position(x: 7, y: 1),
      Position(x: 1, y: 2),
    ]
    let grid = parseInput(input: try String(contentsOf: inputURL))
    return movements
      .map { numberOfTreesHit(grid: grid, movement: $0) }
      .reduce(1, *)
  }
}
