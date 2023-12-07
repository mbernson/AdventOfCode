import Foundation

struct Grid<Tile> {
    struct Point: Hashable, Equatable {
        let x: Int
        let y: Int
    }

    let width: Int
    let height: Int
    var memory: [Tile]

    var points: [Point] {
        (0..<height).flatMap { y in
            (0..<width).map { x in
                Point(x: x, y: y)
            }
        }
    }

    init(width: Int, height: Int, initialTileValue: Tile) {
        self.width = width
        self.height = height
        self.memory = Array(repeating: initialTileValue, count: width * height)
    }

    init(width: Int, height: Int, memory: [Tile]) {
        assert(memory.count == width * height, "Incorrect number of tiles given. Got \(memory.count) but should be \(width * height)")
        self.width = width
        self.height = height
        self.memory = memory
    }

    init(width: Int, height: Int, valueProvider: (Point) -> Tile) {
        self.width = width
        self.height = height
        self.memory = (0..<height).flatMap { y in
            (0..<width).map { x in
                valueProvider(Point(x: x, y: y))
            }
        }
    }

    subscript(x: Int, y: Int) -> Tile {
        get { memory[y * width + x] }
        set(newValue) { memory[y * width + x] = newValue }
    }

    subscript(point: Point) -> Tile {
        get { memory[point.y * width + point.x] }
        set(newValue) { memory[point.y * width + point.x] = newValue }
    }

    func point(at index: Int) -> Point {
        Point(x: index % width, y: index / width)
    }

    /// Checks whether a point is within the grid.
    func isInBounds(x: Int, y: Int) -> Bool {
        return x >= 0 && x < width &&
        y >= 0 && y < height
    }

    /// Gets the points directly adjacent to a given point horizontally, vertically and diagonally.
    func adjacentPoints(to point: Point) -> [Point] {
        adjacentPoints(x: point.x, y: point.y)
    }

    /// Gets the points directly adjacent to a given point horizontally, vertically and diagonally.
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

    func adjacentPointsNonDiagonal(to point: Point) -> [Point] {
        adjacentPointsNonDiagonal(x: point.x, y: point.y)
    }

    func adjacentPointsNonDiagonal(x: Int, y: Int) -> [Point] {
        var result: [Point] = []
        for relX in (-1...1) {
            let relY = 0
            let absX = x + relX
            let absY = y + relY
            if !(relX == 0 && relY == 0) && isInBounds(x: absX, y: absY) {
                result.append(Point(x: absX, y: absY))
            }
        }
        for relY in (-1...1) {
            let relX = 0
            let absX = x + relX
            let absY = y + relY
            if !(relX == 0 && relY == 0) && isInBounds(x: absX, y: absY) {
                result.append(Point(x: absX, y: absY))
            }
        }
        return result
    }

    /// Gets the tiles directly adjacent to a point.
    func adjacentTiles(to point: Point) -> [Tile] {
        adjacentPoints(to: point)
            .map { point in
                self[point.x, point.y]
            }
    }

    /// Gets the tiles directly adjacent to a point.
    func adjacentTiles(x: Int, y: Int) -> [Tile] {
        adjacentPoints(x: x, y: y)
            .map { point in
                self[point.x, point.y]
            }
    }

    /// Returns an array containing the results of mapping the given closure over the grid's points.
    func map<T>(_ transform: (Point) -> T) -> [T] {
        (0..<height).flatMap { y in
            (0..<width).map { x in
                transform(Point(x: x, y: y))
            }
        }
    }

    /// Returns an array containing, in order, the points of the grid that satisfy the given predicate.
    func filter(_ isIncluded: (Point) -> Bool) -> [Point] {
        (0..<height).flatMap { y in
            (0..<width).compactMap { x in
                let point = Point(x: x, y: y)
                return isIncluded(point) ? point : nil
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

func printGrid<Tile>(_ grid: Grid<Tile>, formatter: (Tile) -> String) {
    for row in 0..<grid.height {
        let offset = row * grid.width
        print(grid.memory[offset..<(offset + grid.width)].map(formatter).joined(separator: ""))
    }
}
