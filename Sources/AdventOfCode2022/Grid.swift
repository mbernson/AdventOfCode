import Foundation

struct Grid {
    typealias Tile = Int

    struct Point: Hashable, Equatable {
        let x: Int
        let y: Int
    }

    let width: Int
    let height: Int
    var memory: [Tile]

    init(width: Int, height: Int, memory: [Grid.Tile]) {
        assert(memory.count == width * height, "Incorrect amount of tiles given")
        self.width = width
        self.height = height
        self.memory = memory
    }

    subscript(x: Int, y: Int) -> Tile {
        get { memory[y * width + x] }
        set(newValue) { memory[y * width + x] = newValue }
    }

    func point(at index: Int) -> Point {
        Point(x: index % width, y: index / width)
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
