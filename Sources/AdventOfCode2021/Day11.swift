import Foundation

public struct Day11 {
    let input = """
7232374314
8531113786
3411787828
5482241344
5856827742
7614532764
5311321758
1255116187
5821277714
2623834788
"""

    public init() {}

    public func runPart1() throws -> Int {
        let input: [Int] = input.map(String.init).compactMap(Int.init)
        return countFlashes(in: input, steps: 100)
    }

    func countFlashes(in input: [Int], steps: Int) -> Int {
        var grid = Grid(width: 10, height: 10, grid: input)

        print("Initial state:")
        debugPrint(grid)
        print()

        var totalFlashes = 0
        for step in 1...steps {
            let flashes = grid.flashFish()
            totalFlashes += flashes.count

            if step % 10 == 0 {
                print("After step \(step): \(flashes.count) fish flashed")
                debugPrint(grid)
                print()
            }
        }

        return totalFlashes
    }

    public func runPart2() throws -> Int {
        let input: [Int] = input.map(String.init).compactMap(Int.init)
        var grid = Grid(width: 10, height: 10, grid: input)

        for step in 1...10_000 {
            let flashes = grid.flashFish()

            if flashes.count == grid.grid.count {
                return step
            }
        }

        fatalError("Solution not found")
    }
}

extension Day11.Grid {
    mutating func flashFish() -> [Point] {
        // First, the energy level of each octopus increases by 1
        grid = grid.map { $0 + 1 }

        // Then, any octopus with an energy level greater than 9 flashes
        var flashedPoints: [Point] = []
        while grid.contains(where: { $0 > 9 }) {
            for y in 0..<height {
                for x in 0..<width {
                    if self[x, y] > 9 {
                        flashedPoints.append(.init(x: x, y: y))
                        self[x, y] = 0
                        for point in adjacentPoints(x: x, y: y) {
                            self[point.x, point.y] += 1
                        }
                    }
                }
            }
        }

        // Finally, any octopus that flashed during this step has its energy level set to 0
        for point in flashedPoints {
            self[point.x, point.y] = 0
        }

        return flashedPoints
    }
}

extension Day11 {
    struct Grid {
        typealias Tile = Int

        struct Point: Hashable, Equatable {
            let x: Int
            let y: Int
        }

        let width: Int
        let height: Int
        var grid: [Tile]

        subscript(x: Int, y: Int) -> Tile {
            get { grid[y * width + x] }
            set(newValue) { grid[y * width + x] = newValue }
        }

        /// Checks whether a point is within the grid.
        func isInBounds(x: Int, y: Int) -> Bool {
            return x >= 0 && x < width &&
            y >= 0 && y < height
        }

        /// Gets the points directly adjacent to a point.
        func adjacentPoints(x: Int, y: Int) -> [Point] {
            var result: [Point] = []
            for relX in (-1...1) {
                for relY in (-1...1) {
                    let absX = x + relX
                    let absY = y + relY
                    if !(relX == 0 && relY == 0) && isInBounds(x: absX, y: absY) {
                        result.append(Point(x: absX, y: absY))
                    }
                }
            }
            return result
        }
    }

    func debugPrint(_ grid: Grid) {
        for row in 0..<grid.height {
            let offset = row * grid.width
            print(grid.grid[offset..<(offset + grid.width)].map(String.init).joined(separator: ""))
        }
    }
}
