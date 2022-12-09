import Foundation

public struct Day8 {
    public let inputURL = Bundle.module.url(forResource: "Input/day8", withExtension: "txt")!

    let exampleInput = """
30373
25512
65332
33549
35390
"""

    public init() {}

    public func runPart1() throws -> Int {
        let input: [Int] = try String(contentsOf: inputURL).map(String.init).compactMap(Int.init)
        let grid = Grid(width: 99, height: 99, memory: input)
        return visibleTrees(in: grid).count
    }

    func visibleTrees(in grid: Grid) -> Set<Grid.Point> {
        var result: Set<Grid.Point> = []

        for y in 0..<grid.height {
            for x in 0..<grid.width {
                let value = grid[x, y]
                if grid.isTreeVisibleOutsideOfGrid(value, x: x, y: y) {
                    result.insert(.init(x: x, y: y))
                }
            }
        }

        return result
    }

    public func runPart2() throws -> Int {
        return 0
    }
}

extension Day8 {
    struct Grid {
        typealias Tile = Int

        struct Point: Hashable, Equatable {
            let x: Int
            let y: Int
        }

        let width: Int
        let height: Int
        var memory: [Tile]

        init(width: Int, height: Int, memory: [Day8.Grid.Tile]) {
            assert(memory.count == width * height, "Incorrect amount of tiles given")
            self.width = width
            self.height = height
            self.memory = memory
        }

        subscript(x: Int, y: Int) -> Tile {
            get { memory[y * width + x] }
            set(newValue) { memory[y * width + x] = newValue }
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

        func rowAndColumnNotIncluding(x: Int, y: Int) -> Set<Point> {
            var result: Set<Point> = []
            for relX in (0..<width) {
                for relY in (0..<height) {
                    if (relX == x || relY == y) && !(relX == x && relY == y) && isInBounds(x: relX, y: relY) {
                        result.insert(Point(x: relX, y: relY))
                    }
                }
            }
            return result
        }

        func isTreeVisibleOutsideOfGrid(_ value: Tile, x: Int, y: Int) -> Bool {
            func isVerticalRangeSatisfactory(_ range: Range<Int>) -> Bool {
                range.map { y in self[x, y] }.allSatisfy { $0 < value }
            }
            func isHorizontalRangeSatisfactory(_ range: Range<Int>) -> Bool {
                range.map { x in self[x, y] }.allSatisfy { $0 < value }
            }

            // Top
            let isTopClear = isVerticalRangeSatisfactory(0..<y)
            if isTopClear { return true }

            // Bottom
            let isBottomClear = isVerticalRangeSatisfactory((y + 1)..<height)
            if isBottomClear { return true }

            // Left
            let isLeftClear = isHorizontalRangeSatisfactory(0..<x)
            if isLeftClear { return true }

            // Right
            let isRightClear = isHorizontalRangeSatisfactory((x + 1)..<width)
            if isRightClear { return true }

            return false
        }

        /// Get a single horizontal row of the grid
        func row(y: Int) -> [Tile] {
            let start = y * width
            let end = start + width
            return Array(memory[start..<end])
        }

        /// Get a single vertical column of the grid
        func col(x: Int) -> [Tile] {
            (0..<height).map { y in
                memory[y * width + x]
            }
        }
    }

    func debugPrint(_ grid: Grid) {
        for row in 0..<grid.height {
            let offset = row * grid.width
            print(grid.memory[offset..<(offset + grid.width)].map(String.init).joined(separator: ""))
        }
    }
}
