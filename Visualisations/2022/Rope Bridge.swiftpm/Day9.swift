import Foundation

public struct Day9 {
    public let inputURL = Bundle.main.url(forResource: "day9", withExtension: "txt")!
    
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
        }
        return visitedPoints
    }
    
    func newPosition(of point: Point, toFollow target: Point) -> Point {
        let distance = self.distance(from: point, to: target)
        if distance == 0 || distance == 1 {
            return point
        } else if distance == 2 {
            let offsetX = point.x - target.x
            let offsetY = point.y - target.y
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
                if abs(offsetX) > abs(offsetY) {
                    return Point(x: offsetX < 0 ? target.x - 1 : target.x + 1, y: target.y)
                } else {
                    return Point(x: target.x, y: offsetY < 0 ? target.y - 1 : target.y + 1)
                }
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
}
