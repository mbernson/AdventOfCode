import Foundation

public struct Day9 {
    public let inputURL = Bundle.module.url(forResource: "Input/day9", withExtension: "txt")!

    public init() {}

    enum Direction: String {
        case up = "U"
        case down = "D"
        case left = "L"
        case right = "R"

        var x: Int {
            switch self {
            case .up, .down: return 0
            case .left: return -1
            case .right: return 1
            }
        }

        var y: Int {
            switch self {
            case .left, .right: return 0
            case .up: return -1
            case .down: return 1
            }
        }
    }

    typealias Command = (Direction, Int)
    struct Point: Hashable, Equatable {
        var x: Int
        var y: Int
        static let zero = Point(x: 0, y: 0)
    }

    func parseInput(_ inputString: String) -> [Command] {
        inputString
            .components(separatedBy: "\n")
            .compactMap { string -> Command? in
                guard !string.isEmpty else { return nil }
                let parts = string.components(separatedBy: " ")
                if let d = Direction(rawValue: parts[0]), let q = Int(parts[1]) {
                    return (d, q)
                } else {
                    return nil
                }
            }
    }

    public func runPart1() throws -> Int {
        runPart1(input: try String(contentsOf: inputURL))
    }

    func runPart1(input: String) -> Int {
        let commands = parseInput(input)
        let movements = commands.flatMap { (direction, quantity) in
            Array(repeating: direction, count: quantity)
        }
        return visitedPoints(afterApplying: movements).count
    }

    func visitedPoints(afterApplying movements: [Direction], startingPoint: Point = .zero) -> Set<Point> {
        var visitedPoints: Set<Point> = []
        var head = startingPoint
        var tail = startingPoint
        visitedPoints.insert(tail)
        for movement in movements {
            head.x += movement.x
            head.y += movement.y
            tail = newPosition(of: tail, toFollow: head)
            visitedPoints.insert(tail)
            printState(head: head, tail: tail, visitedPoints: visitedPoints)
        }
        return visitedPoints
    }

    func printState(head: Point, tail: Point, visitedPoints: Set<Point>) {
        let minX = visitedPoints.min(by: { $0.x < $1.x })!.x
        let maxX = visitedPoints.max(by: { $0.x < $1.x })!.x
        let minY = visitedPoints.min(by: { $0.y < $1.y })!.y
        let maxY = visitedPoints.max(by: { $0.y < $1.y })!.y

        for y in (minY...maxY) {
            (minX...maxX).map { x in

            }
        }
    }

    func newPosition(of point: Point, toFollow target: Point) -> Point {
        let distance = self.distance(from: point, to: target)
        if distance == 0 || distance == 1 {
            return point
        } else if distance == 2 {
            if point.x == target.x {
                // We've moved only along the Y axis
                if point.y < target.y {
                    return Point(x: target.x, y: target.y - 1)
                } else {
                    return Point(x: target.x, y: target.y + 1)
                }
            } else if point.y == target.y {
                // We've moved only along the X axis
                if point.x < target.x {
                    return Point(x: target.x - 1, y: target.y)
                } else {
                    return Point(x: target.x + 1, y: target.y)
                }
            } else {
                let corners = cornerPoints(x: target.x, y: target.y)
                let sorted = corners.sorted(by: { lhs, rhs in
                    self.distance(from: point, to: lhs) < self.distance(from: point, to: rhs)
                })
                return sorted.first!
            }
        } else {
            fatalError("Distance cannot be greater than 1. Input error.")
        }
    }

    func distance(from point: Point, to other: Point) -> Int {
        let a = Double(other.x - point.x)
        let b = Double(other.y - point.y)
        return Int(sqrt(a * a + b * b))
    }

    public func runPart2() throws -> Int {
        return 0
    }

    /// Gets the points directly adjacent to a given point horizontally, vertically and diagonally.
    func cornerPoints(x: Int, y: Int) -> [Point] {
        var result: [Point] = []
        for relX in (-1...1) {
            for relY in (-1...1) {
                let absX = x + relX
                let absY = y + relY
                if absX != x && absY != y {
                    result.append(Point(x: absX, y: absY))
                }
            }
        }
        return result
    }
}
