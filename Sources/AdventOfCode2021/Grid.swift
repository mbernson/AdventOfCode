import Foundation

/// A 2D grid with useful utility functions such as finding the neighbors of each tile.
/// You can store a generic piece of data into each tile.
/// Internally, it is represented as a 1D array.
/// A subscript getter is implemented to get the value at a certain coordinate.
struct Grid<Tile> {
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

    func debugPrint() {
        for row in 0..<height {
            let offset = row * width
            print(grid[offset..<(offset + width)].map { String(describing: $0) }.joined(separator: ""))
        }
    }
}
