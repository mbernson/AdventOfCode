import Foundation

public struct Day3Runner {
  public let inputURL = Bundle.module.url(forResource: "day3", withExtension: "txt")!

  public init() {}

  public func runPart1() throws {
    let string = try String(contentsOf: inputURL)
    let parts = string.components(separatedBy: "\n")
    if let d = try Day3().closestIntersectionToOrigin(firstWire: parts[0], secondWire: parts[1]) {
      print("Intersection distance: \(d)")
    } else {
      print("No intersections found!")
    }
  }

  public func runPart2() throws {
    let string = try String(contentsOf: inputURL)
    let parts = string.components(separatedBy: "\n")
    if let d = try Day3().lowestCostIntersectionToOrigin(firstWire: parts[0], secondWire: parts[1]) {
      print("Lowest costing intersection: \(d) steps")
    } else {
      print("No intersections found!")
    }
  }
}

// MARK: Namespace for day 3 functions

struct Day3 {
  func parseInstructions(string: String) throws -> [Instruction] {
    try string
      .components(separatedBy: ",")
      .map(Instruction.init)
  }

  func lowestCostIntersectionToOrigin(firstWire: String, secondWire: String) throws -> Int? {
    lowestCostIntersectionToOrigin(
      firstWire: try parseInstructions(string: firstWire),
      secondWire: try parseInstructions(string: secondWire)
    )
  }

  func lowestCostIntersectionToOrigin(firstWire: [Instruction], secondWire: [Instruction]) -> Int? {
    let origin = Point.zero
    let firstPoints = points(for: firstWire, origin: origin)
    let secondPoints = points(for: secondWire, origin: origin)
    var intersecting = Set(firstPoints).intersection(Set(secondPoints))
    intersecting.remove(origin)

    let distances = intersecting.compactMap { intersectionPoint -> IntersectionDistance in
      let firstCost = numberOfPoints(points: firstPoints, untilReaching: intersectionPoint)!
      let secondCost = numberOfPoints(points: secondPoints, untilReaching: intersectionPoint)!
      return (firstCost + secondCost, intersectionPoint)
    }.sorted(by: { a, b in
      a.distance < b.distance
    })
    let closest = distances.first
    return closest?.distance
  }

  func closestIntersectionToOrigin(firstWire: String, secondWire: String) throws -> Int? {
    closestIntersectionToOrigin(
      firstWire: try parseInstructions(string: firstWire),
      secondWire: try parseInstructions(string: secondWire)
    )
  }

  func closestIntersectionToOrigin(firstWire: [Instruction], secondWire: [Instruction]) -> Int? {
    let origin = Point.zero
    var intersecting = intersectingPoints(first: firstWire, second: secondWire, origin: origin)
    intersecting.remove(origin)
    guard let closestPoint = intersecting.sorted(by: { a, b in
      manhattanDistance(from: a, to: origin) < manhattanDistance(from: b, to: origin)
    }).first else {
      return nil
    }
    return manhattanDistance(from: closestPoint, to: origin)
  }

  func intersectingPoints(first: [Instruction], second: [Instruction], origin: Point) -> Set<Point> {
    Set(points(for: first, origin: origin))
      .intersection(Set(points(for: second, origin: origin)))
  }

  func numberOfPoints(points: [Point], untilReaching point: Point) -> Int? {
    if let index = points.firstIndex(of: point) {
      return index + 1
    } else {
      return nil
    }
  }

  func points(for instructions: [Instruction], origin: Point) -> [Point] {
    var lastPoint = origin
    var allPoints = [Point]()
    for instruction in instructions {
      let points = self.points(for: instruction, origin: lastPoint)
      lastPoint = points.last!
      allPoints.append(contentsOf: points)
    }
    return allPoints
  }

  func points(for instruction: Instruction, origin: Point) -> [Point] {
    (1...instruction.distance).map { distance in
      switch instruction.direction {
      case .up:
        return Point(x: origin.x, y: origin.y + distance)
      case .down:
        return Point(x: origin.x, y: origin.y - distance)
      case .left:
        return Point(x: origin.x - distance, y: origin.y)
      case .right:
        return Point(x: origin.x + distance, y: origin.y)
      }
    }
  }

  /// Definition:
  /// For a plane with p1 at (x1, y1) and p2 at (x2, y2), the Manhattan distance is |x1 - x2| + |y1 - y2|.
  func manhattanDistance(from p: Point, to q: Point) -> Int {
    return abs(p.x - q.x) + abs(p.y - q.y)
  }
}

// MARK: Types

extension Day3 {
  typealias IntersectionDistance = (distance: Int, point: Point)

  struct Point: Equatable, Hashable {
    var x: Int
    var y: Int

    static let zero = Point(x: 0, y: 0)
  }

  enum InstructionError: Error {
    case invalidDirection
    case invalidDistance
  }

  struct Instruction: Equatable {
    let direction: Direction
    let distance: Int

    init(direction: Day3.Direction, distance: Int) {
      self.direction = direction
      self.distance = distance
    }

    init(string: String) throws {
      var mutableString = string
      guard let direction = Direction(rawValue: mutableString.removeFirst())
        else { throw InstructionError.invalidDirection }
      guard let distance = Int(mutableString)
        else { throw InstructionError.invalidDistance }
      self.direction = direction
      self.distance = distance
    }
  }

  enum Direction: Character {
    case up = "U", down = "D", left = "L", right = "R"
  }

}
