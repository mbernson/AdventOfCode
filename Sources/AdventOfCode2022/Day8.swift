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
        grid.filter(grid.isTreeVisibleOutsideOfGrid).count
    }

    public func runPart2() throws -> Int {
        let input: [Int] = try String(contentsOf: inputURL).map(String.init).compactMap(Int.init)
        let grid = Grid(width: 99, height: 99, memory: input)
        return highestScenicScore(in: grid)
    }

    func highestScenicScore(in grid: Grid) -> Int {
        grid.map(grid.scenicScore).max()!
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

        func map<T>(_ transform: (Int, Int) -> T) -> [T] {
            (0..<height).flatMap { y in
                (0..<width).map { x in
                    transform(x, y)
                }
            }
        }

        func filter(_ predicate: (Int, Int) -> Bool) -> [Point] {
            (0..<height).flatMap { y in
                (0..<width).compactMap { x in
                    predicate(x, y) ? Point(x: x, y: y) : nil
                }
            }
        }

        func isTreeVisibleOutsideOfGrid(x: Int, y: Int) -> Bool {
            let value = self[x, y]
            func isVisible(_ range: Range<Int>, tile: (Int) -> Tile) -> Bool {
                range.map(tile).allSatisfy { $0 < value }
            }

            // Top
            let isTopClear = isVisible(0..<y) { y in self[x, y] }
            if isTopClear { return true }

            // Bottom
            let isBottomClear = isVisible((y + 1)..<height) { y in self[x, y] }
            if isBottomClear { return true }

            // Left
            let isLeftClear = isVisible(0..<x) { x in self[x, y] }
            if isLeftClear { return true }

            // Right
            let isRightClear = isVisible((x + 1)..<width) { x in self[x, y] }
            if isRightClear { return true }

            return false
        }

        func scenicScore(x: Int, y: Int) -> Int {
            let value = self[x, y]

            func sightDistance(_ range: Array<Int>, tile: (Int) -> Tile) -> Int {
                var distance = 0
                for v in range {
                    distance += 1
                    if tile(v) >= value {
                        break
                    }
                }
                return distance
            }

            let topDistance = sightDistance(Array((0..<y).reversed())) { y in self[x, y] }
            let bottomDistance = sightDistance(Array((y + 1)..<height)) { y in self[x, y] }

            let leftDistance = sightDistance(Array((0..<x).reversed())) { x in self[x, y] }
            let rightDistance = sightDistance(Array((x + 1)..<width)) { x in self[x, y] }

            return topDistance * bottomDistance * leftDistance * rightDistance
        }
    }
}
