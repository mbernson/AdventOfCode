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

    let exampleInput = """
5483143223
2745854711
5264556173
6141336146
6357385478
4167524645
2176841721
6882881134
4846848554
5283751526
"""

    public init() {}

    func countFlashes(in input: [Int], steps: Int) -> Int {
        var grid = Grid(width: 10, height: 10, grid: input)
        assert(grid.grid.count == grid.width * grid.height)
        print("Initial state:")
        debugPrint(grid)
        print()
        var totalFlashes = 0
        for step in 1...steps {
            // First, the energy level of each octopus increases by 1
            grid.grid = grid.grid.map { $0 + 1 }
            // Then, any octopus with an energy level greater than 9 flashes
            var flashedPoints: [Grid.Point] = []
            while grid.grid.contains(where: { $0 > 9 }) {
                for y in 0..<grid.height {
                    for x in 0..<grid.width {
                        if grid[x, y] > 9 {
                            flashedPoints.append(.init(x: x, y: y))
                            grid[x, y] = 0
                            for point in grid.adjacentPoints(x: x, y: y) {
                                grid[point.x, point.y] += 1
                            }
                        }
                    }
                }
            }
            // Finally, any octopus that flashed during this step has its energy level set to 0
            for point in flashedPoints {
                grid[point.x, point.y] = 0
            }
            let flashes = flashedPoints.count
            totalFlashes += flashes

            if step % 10 == 0 {
                print("After step \(step): \(flashes) fish flashed")
                debugPrint(grid)
                print()
            }
        }
        return totalFlashes
    }

    public func runPart1() throws -> Int {
        let input: [Int] = input.map(String.init).compactMap(Int.init)
        assert(input.count == 10 * 10, "Wrong input size")
        return countFlashes(in: input, steps: 100)
    }

    public func runPart2() throws -> Int {
        let input: [Int] = input.map(String.init).compactMap(Int.init)
        var grid = Grid(width: 10, height: 10, grid: input)
        assert(grid.grid.count == grid.width * grid.height)

        for step in 1...10_000 {
            // First, the energy level of each octopus increases by 1
            grid.grid = grid.grid.map { $0 + 1 }
            // Then, any octopus with an energy level greater than 9 flashes
            var flashedPoints: [Grid.Point] = []
            while grid.grid.contains(where: { $0 > 9 }) {
                for y in 0..<grid.height {
                    for x in 0..<grid.width {
                        if grid[x, y] > 9 {
                            flashedPoints.append(.init(x: x, y: y))
                            grid[x, y] = 0
                            for point in grid.adjacentPoints(x: x, y: y) {
                                grid[point.x, point.y] += 1
                            }
                        }
                    }
                }
            }
            // Finally, any octopus that flashed during this step has its energy level set to 0
            for point in flashedPoints {
                grid[point.x, point.y] = 0
            }
            let flashes = flashedPoints.count

            if flashes == grid.grid.count {
                return step
            }
        }
        fatalError("Solution not found")
    }

    func debugPrint(_ grid: Grid) {
        for row in 0..<grid.height {
            let offset = row * grid.width

            print(grid.grid[offset..<(offset + grid.width)].map { value in
                if value > 9 {
                    return "X"
                } else {
                    return String(value)
                }
            }.joined(separator: ""))
        }
    }

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
            get {
                grid[y * width + x]
            }
            set(newValue) {
                grid[y * width + x] = newValue
            }
        }

        /// Checks whether a point is within the grid.
        private func isInBounds(x: Int, y: Int) -> Bool {
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

        /// Gets the tiles directly adjacent to a point.
        func adjacentTiles(x: Int, y: Int) -> [Tile] {
            adjacentPoints(x: x, y: y)
                .map { point in
                    self[point.x, point.y]
                }
        }

        /// Recursively finds all the points matching the predicate, which are connected to the given point.
        func findPointsConnectedTo(x: Int, y: Int, visitedSet: Set<Point> = Set(), matching predicate: (Point) -> Bool) -> Set<Point> {
            var set = visitedSet
            for point in adjacentPoints(x: x, y: y) {
                if predicate(point) {
                    if !set.contains(point) {
                        set.insert(point)
                        set = set.union(findPointsConnectedTo(x: point.x, y: point.y, visitedSet: set, matching: predicate))
                    }
                }
            }
            return set
        }
    }
}
