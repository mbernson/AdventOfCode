import Foundation
import Algorithms

struct Day04: AdventDay {
    var data: String

    var grid: Grid<Tile> {
        let lines = data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map(Array.init)
        let height = lines.count
        let width = lines[0].count
        let memory: [Tile] = data.replacing("\n", with: "").map { character in
            switch character {
            case ".":
                return .empty
            case "@":
                return .paperRoll
            default:
                fatalError()
            }
        }
        return Grid(width: width, height: height, memory: memory)
    }

    enum Tile: Hashable {
        case empty
        case paperRoll
    }

    func part1() -> Any {
        let grid = grid
        let adjacent = grid.filter { grid[$0] == .paperRoll }.map(grid.adjacentTiles)
        let filtered = adjacent.filter { $0.filter { $0 == .paperRoll } .count < 4 }
        return filtered.count
    }
 }
