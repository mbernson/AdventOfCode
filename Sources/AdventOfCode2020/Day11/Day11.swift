import Foundation

public struct Day11 {
  public let inputURL = Bundle.module.url(forResource: "day11", withExtension: "txt")!

  public init() {}

  typealias Grid = [[Tile]]
  typealias Coordinate = (x: Int, y: Int)

  enum Tile: String {
    case emptySeat = "L"
    case occupiedSeat = "#"
    case floor = "."
  }

  func parseInput(string: String) -> Grid {
    return string
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map { $0.map { Tile(rawValue: String($0))! } }
  }

  public func runPart1() throws -> Int {
    let grid = parseInput(string: try String(contentsOf: inputURL))
    assert(grid.allSatisfy({ $0.count == 91 }))
    assert(grid.count == 94)
    return seatsOccupied(in: runUntilUnchanged(grid: grid))
  }

  func runUntilUnchanged(grid _grid: Grid) -> Grid {
    var lastGrid = generation(grid: _grid)
    var generations = 1
    while true {
      print("Generation \(generations)\n")
//      lastGrid.print()
//      print("\n")

      let newGrid = generation(grid: lastGrid)
      if newGrid == lastGrid {
        return lastGrid
      }
      lastGrid = newGrid
      generations += 1
    }
  }

  func seatsOccupied(in grid: Grid) -> Int {
    grid
      .flatMap { $0 }
      .filter { $0 == .occupiedSeat }
      .count
  }

  public func runPart2() throws -> Int {
    return 0
  }

  func generation(grid: Grid) -> Grid {
    var newGrid = grid

    for (y, row) in grid.enumerated() {
      for (x, tile) in row.enumerated() {
        if tile == .floor { continue }

        let adjacent = self.adjacent(to: (x: x, y: y), in: grid)
        let adjacentOccupiedSeats: [Tile] = adjacent.map { (x, y) in
          grid[y][x]
        }.filter({ $0 == .occupiedSeat })

        switch tile {
        // If a seat is empty (L) and there are no occupied seats adjacent to it, the seat becomes occupied.
        case .emptySeat:
          guard adjacentOccupiedSeats.count == 0 else { break }
          newGrid[y][x] = .occupiedSeat
        // If a seat is occupied (#) and four or more seats adjacent to it are also occupied, the seat becomes empty.
        case .occupiedSeat:
          guard adjacentOccupiedSeats.count >= 4 else { break }
          newGrid[y][x] = .emptySeat
        case .floor:
          break
        }
      }
    }

    return newGrid
  }

  func adjacent(to point: Coordinate, in grid: Grid) -> [Coordinate] {
    var adjacent: [Coordinate] = []

    // left
    if point.x - 1 >= 0 {
      adjacent.append((x: point.x - 1, y: point.y))
    }
    // right
    if point.x + 1 < grid[point.y].count {
      adjacent.append((x: point.x + 1, y: point.y))
    }
    // up
    if point.y - 1 >= 0 {
      adjacent.append((x: point.x, y: point.y - 1))
    }
    // down
    if point.y + 1 < grid[point.y].count {
      adjacent.append((x: point.x, y: point.y + 1))
    }
    // top left
    if point.x - 1 >= 0 && point.y - 1 >= 0 {
      adjacent.append((x: point.x - 1, y: point.y - 1))
    }
    // top right
    if point.x + 1 < grid[point.y].count && point.y - 1 >= 0 {
      adjacent.append((x: point.x + 1, y: point.y - 1))
    }
    // bottom left
    if point.x - 1 >= 0 && point.y + 1 < grid[point.y].count {
      adjacent.append((x: point.x - 1, y: point.y + 1))
    }
    // bottom right
    if point.x + 1 < grid[point.y].count && point.y + 1 < grid[point.y].count {
      adjacent.append((x: point.x + 1, y: point.y + 1))
    }

    return adjacent
  }
}

extension Day11.Grid {
  func stringRepresenstation() -> String {
    self.map { row in
      row.map(\.rawValue).joined()
    }.joined(separator: "\n")
  }

  func print() {
    Swift.print(stringRepresenstation())
  }
}
