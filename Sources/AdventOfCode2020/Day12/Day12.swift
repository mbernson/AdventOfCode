import Foundation

public struct Day12 {
  public let inputURL = Bundle.module.url(forResource: "day12", withExtension: "txt")!

  public init() {}

  func parseInput() throws -> [Instruction] {
    return try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter({ !$0.isEmpty })
      .map { try Instruction(string: $0) }
  }

  public func runPart1() throws -> Int {
    let input = try parseInput()
    let finalPosition = applyInstructions(input: input)
    return manhattanDistance(from: .zero, to: Point(x: finalPosition.x, y: finalPosition.y))
  }

  public func runPart2() throws -> Int {
//    let input = try parseInput()
    return 0
  }

  func applyInstructions(input: [Instruction]) -> Position {
    var position = Position(direction: .east, x: 0, y: 0)

    for instruction in input {
      let distance = instruction.distance
      switch instruction.direction {
      case .north:
        position.y -= distance
      case .east:
        position.x += distance
      case .west:
        position.x -= distance
      case .south:
        position.y += distance
      case .front:
        position.moveForward(direction: position.direction, distance: distance)
      case .left:
        position.rotate(direction: .left, degrees: distance)
      case .right:
        position.rotate(direction: .right, degrees: distance)
      }
    }

    return position
  }

  struct Position: Equatable {
    var direction: CompassDirection
    var x: Int
    var y: Int

    mutating func moveForward(direction: CompassDirection, distance: Int) {
      switch direction {
      case .north:
        y -= distance
      case .east:
        x += distance
      case .west:
        x -= distance
      case .south:
        y += distance
      }
    }

    mutating func rotate(direction: RotationDirection, degrees: Int) {
      let times = Int(degrees / 90)
      for _ in 0..<times {
        switch direction {
        case .left:
          self.direction = self.direction.rotatedCounterClockwise
        case .right:
          self.direction = self.direction.rotatedClockwise
        }
      }
    }
  }

  struct Instruction: Equatable {
    let direction: Direction
    let distance: Int

    init(direction: Direction, distance: Int) {
      self.direction = direction
      self.distance = distance
    }

    init(string: String) throws {
      guard let d = string.first, let direction = Direction(rawValue: String(d)) else {
        throw Day12Error.invalidDirection(direction: string.first.map(String.init) ?? "Unknown")
      }
      let distanceString = String(string.dropFirst())
      guard let distance = Int(distanceString) else {
        throw Day12Error.invalidDistance(distance: distanceString)
      }
      self.direction = direction
      self.distance = distance
    }
  }

  enum Direction: String, Equatable {
    case north = "N"
    case south = "S"
    case east = "E"
    case west = "W"
    case front = "F"
    case left = "L"
    case right = "R"
  }

  enum RotationDirection: Equatable {
    case left, right
  }

  enum CompassDirection: Equatable {
    case north, east, south, west

    var rotatedClockwise: CompassDirection {
      switch self {
      case .north: return .east
      case .east: return .south
      case .south: return .west
      case .west: return .north
      }
    }

    var rotatedCounterClockwise: CompassDirection {
      switch self {
      case .north: return .west
      case .west: return .south
      case .south: return .east
      case .east: return .north
      }
    }
  }

  /// Definition:
  /// For a plane with p1 at (x1, y1) and p2 at (x2, y2), the Manhattan distance is |x1 - x2| + |y1 - y2|.
  func manhattanDistance(from p: Point, to q: Point) -> Int {
    return abs(p.x - q.x) + abs(p.y - q.y)
  }

  struct Point: Equatable, Hashable {
    var x: Int
    var y: Int

    static let zero = Point(x: 0, y: 0)
  }

  enum Day12Error: Error {
    case invalidDirection(direction: String)
    case invalidDistance(distance: String)
  }
}
