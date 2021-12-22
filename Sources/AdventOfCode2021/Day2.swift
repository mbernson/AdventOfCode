import Foundation

public struct Day2 {
  public let inputURL = Bundle.module.url(forResource: "Input/day2", withExtension: "txt")!

  public init() {}

  enum Direction: String {
    case up, down, forward
  }

  struct Line {
    let direction: Direction
    let amount: Int
  }

  func parseLine(_ line: String) throws -> Line {
    let components: [String] = line.components(separatedBy: " ")
    assert(components.count == 2)
    guard components.count == 2,
          let direction = Direction(rawValue: components[0]),
          let amount = Int(components[1])
    else {
      throw AdventError(errorDescription: "Invalid line: \(line)")
    }
    return Line(direction: direction, amount: amount)
  }

  func calculateCourse(input: [String]) throws -> (horizontalPos: Int, depth: Int) {
    let lines = try input.map(parseLine)

    var horizontalPos = 0
    var depth = 0

    for line in lines {
      switch line.direction {
      case .forward:
        horizontalPos += line.amount
      case .up:
        depth -= line.amount
      case .down:
        depth += line.amount
      }
    }

    return (horizontalPos, depth)
  }

  func calculateCourseUpdated(input: [String]) throws -> (horizontalPos: Int, depth: Int) {
    let lines = try input.map(parseLine)

    var horizontalPos = 0
    var depth = 0
    var aim = 0

    for line in lines {
      switch line.direction {
      case .forward:
        horizontalPos += line.amount
        depth += aim * line.amount
      case .up:
        aim -= line.amount
      case .down:
        aim += line.amount
      }
    }

    return (horizontalPos, depth)
  }

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let lines: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }

    let (horizontalPos, depth) = try calculateCourse(input: lines)

    return horizontalPos * depth
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let lines: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }

    let (horizontalPos, depth) = try calculateCourseUpdated(input: lines)

    return horizontalPos * depth
  }
}
