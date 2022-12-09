import Foundation

public struct Day8 {
    public let inputURL = Bundle.module.url(forResource: "Input/day8", withExtension: "txt")!

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
    }
}
