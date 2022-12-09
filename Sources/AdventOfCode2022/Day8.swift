import Foundation

public struct Day8 {
    public let inputURL = Bundle.module.url(forResource: "Input/day8", withExtension: "txt")!

    public init() {}

    public func runPart1() throws -> Int {
        let input: [Int] = try String(contentsOf: inputURL).map(String.init).compactMap(Int.init)
        let grid = Grid(width: 99, height: 99, memory: input)
        return visibleTrees(in: grid)
    }

    func visibleTrees(in grid: Grid) -> Int {
        var result: Set<Grid.Point> = []

        for y in 0..<grid.height {
            for x in 0..<grid.width {
                if grid.isTreeVisibleOutsideOfGrid(x: x, y: y) {
                    result.insert(.init(x: x, y: y))
                }
            }
        }

        return result.count
    }

    func highestScenicScore(in grid: Grid) -> Int {
        var scores: Set<Int> = []

        for y in 0..<grid.height {
            for x in 0..<grid.width {
                scores.insert(grid.scenicScore(x: x, y: y))
            }
        }

        return scores.max()!
    }

    public func runPart2() throws -> Int {
        let input: [Int] = try String(contentsOf: inputURL).map(String.init).compactMap(Int.init)
        let grid = Grid(width: 99, height: 99, memory: input)
        return highestScenicScore(in: grid)
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

        func isTreeVisibleOutsideOfGrid(x: Int, y: Int) -> Bool {
            let value = self[x, y]
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

        func scenicScore(x: Int, y: Int) -> Int {
            let value = self[x, y]
            var topDistance = 0
            for yy in (0..<y).reversed() {
                topDistance += 1
                let t = self[x, yy]
                if t >= value {
                    break
                }
            }

            var bottomDistance = 0
            for yy in (y + 1)..<height {
                bottomDistance += 1
                let t = self[x, yy]
                if t >= value {
                    break
                }
            }

            var leftDistance = 0
            for xx in (0..<x).reversed() {
                leftDistance += 1
                let t = self[xx, y]
                if t >= value {
                    break
                }
            }

            var rightDistance = 0
            for xx in (x + 1)..<width {
                rightDistance += 1
                let t = self[xx, y]
                if t >= value {
                    break
                }
            }

            return topDistance * bottomDistance * leftDistance * rightDistance
        }
    }
}
