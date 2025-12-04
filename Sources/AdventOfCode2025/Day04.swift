import Foundation
import Algorithms

struct Day04: AdventDay {
    var data: String

    var grid: Grid<PrintingDepartmentTile> {
        let lines = data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map(Array.init)
        let height = lines.count
        let width = lines[0].count
        let memory: [PrintingDepartmentTile] = data.replacing("\n", with: "").map { character in
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

    enum PrintingDepartmentTile: Hashable, CustomStringConvertible {
        case empty
        case paperRoll

        var description: String {
            switch self {
            case .empty: "."
            case .paperRoll: "@"
            }
        }
    }

    func part1() -> Any {
        numberOfAccessibleRolls(in: grid)
    }

    func numberOfAccessibleRolls(in grid: Grid<PrintingDepartmentTile>) -> Int {
        let adjacent = grid.filter { grid[$0] == .paperRoll }.map(grid.adjacentTiles)
        let filtered = adjacent.filter { $0.filter { $0 == .paperRoll }.count < 4 }
        return filtered.count
    }

    func part2() -> Any {
        var grid = grid
        let numberOfPaperRolls = grid.memory.filter { $0 == .paperRoll }.count
        while true {
            let newGrid = grid.removingPaperRolls()
            if newGrid == grid {
                break
            }
            grid = newGrid
        }
        let finalNumberOfPaperRolls = grid.memory.filter { $0 == .paperRoll }.count
        return numberOfPaperRolls - finalNumberOfPaperRolls
    }
}

extension Grid where Tile == Day04.PrintingDepartmentTile {
    func isAccessible(point: GridPoint) -> Bool {
        return adjacentTiles(to: point).filter { $0 == .paperRoll }.count < 4
    }

    func removingPaperRolls() -> Self {
        Grid(width: width, height: height, memory: map { point in
            let value = self[point]
            if value == .paperRoll && isAccessible(point: point) {
                return .empty
            } else {
                return value
            }
        })
    }
}
