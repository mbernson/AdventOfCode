import Foundation
import Algorithms

private func makeGrid(from input: String) -> Grid<Character> {
    let lines = input.split(separator: "\n")
    let width = lines[0].count
    let height = lines.count
    let memory = Array(lines.joined())
    return Grid(width: width, height: height, memory: memory)
}

struct Day04: AdventDay {
    var data: String
    let grid: Grid<Character>
    let xmas = "XMAS"

    init(data: String) {
        let data = Self.loadData(challengeDay: Self.day)
        self.data = data
        self.grid = makeGrid(from: data)
    }

    func part1() throws -> Any {
        grid.points.map(countNumberOfXmases).reduce(0, +)
    }

    private func countNumberOfXmases(startingAt point: GridPoint) -> Int {
        let x = point.x, y = point.y, char = grid[x, y], n = xmas.count
        var strings: [String] = []
        for relX in 0..<n {
            for relY in (0..<n) {
                let absX = x + relX
                let absY = y + relY
                if isInBounds(x: absX, y: absY) {
                    result.append(Point(x: absX, y: absY))
                }
            }
        }
        return strings.filter { $0 == xmas }.count
    }
}
