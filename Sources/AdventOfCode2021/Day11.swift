import Foundation

public struct Day11 {
  private let input: [[Int]] = [
    [7,2,3,2,3,7,4,3,1,4],
    [8,5,3,1,1,1,3,7,8,6],
    [3,4,1,1,7,8,7,8,2,8],
    [5,4,8,2,2,4,1,3,4,4],
    [5,8,5,6,8,2,7,7,4,2],
    [7,6,1,4,5,3,2,7,6,4],
    [5,3,1,1,3,2,1,7,5,8],
    [1,2,5,5,1,1,6,1,8,7],
    [5,8,2,1,2,7,7,7,1,4],
    [2,6,2,3,8,3,4,7,8,8],
  ]
  private let exampleInput: [[Int]] = [
    [5,4,8,3,1,4,3,2,2,3],
    [2,7,4,5,8,5,4,7,1,1],
    [5,2,6,4,5,5,6,1,7,3],
    [6,1,4,1,3,3,6,1,4,6],
    [6,3,5,7,3,8,5,4,7,8],
    [4,1,6,7,5,2,4,6,4,5],
    [2,1,7,6,8,4,1,7,2,1],
    [6,8,8,2,8,8,1,1,3,4],
    [4,8,4,6,8,4,8,5,5,4],
    [5,2,8,3,7,5,1,5,2,6],
  ]

  public init() {}

  typealias Point = Fishbowl.Point

  public class Fishbowl {
    public private(set) var state: [[Int]]
    public private(set) var totalFlashes: Int = 0
    public private(set) var currentTick: Int = 0

    public init(input: [[Int]]) {
      self.state = input
    }

    func dumpState() {
      for row in state {
        print(row.map({ n in
          n > 9 ? "*" : String(n)
        }).joined(separator: " "))
      }
    }

    public func tick() {
      currentTick += 1
      print("Tick \(currentTick)")

      // First, the energy level of each octopus increases by 1.
      for y in 0..<10 {
        for x in 0..<10 {
          state[y][x] += 1
        }
      }

      // Then, any octopus with an energy level greater than 9 flashes.
      var flashes: [Point] = pointsMatching { $0 > 9 }

      while !flashes.isEmpty {
        print("\(flashes.count) flashes in tick \(currentTick)")
        for point in flashes {
          flash(point: point)
        }

        flashes = pointsMatching { $0 == 10 }
      }

      // Finally, any octopus that flashed during this step has its energy level set to 0.
      for point in pointsMatching({ $0 > 9 }) {
        state[point.y][point.x] = 0
      }
    }

    private func flash(point: Point) {
      totalFlashes += 1
      for point in pointsAround(point: point) {
        if state[point.y][point.x] < 10 {
          state[point.y][point.x] += 1
        }
      }
    }

    struct Point: Hashable, Equatable {
      let x: Int, y: Int
    }

    func pointsAround(point: Point) -> [Point] {
      let x = point.x
      let y = point.y
      var result: [Point] = []
      let width = state[0].count
      let height = state.count
      // Top left
      if y > 0 && x > 0 {
        result.append(Point(x: x - 1, y: y - 1))
      }
      // Top
      if y > 0 {
        result.append(Point(x: x, y: y - 1))
      }
      // Top right
      if y > 0 && x < (width - 1) {
        result.append(Point(x: x + 1, y: y - 1))
      }
      // Left
      if x > 0 {
        result.append(Point(x: x - 1, y: y))
      }
      // Right
      if x < (width - 1) {
        result.append(Point(x: x + 1, y: y))
      }
      // Bottom left
      if y < (height - 1) && x > 0 {
        result.append(Point(x: x - 1, y: y + 1))
      }
      // Bottom
      if y < (height - 1) {
        result.append(Point(x: x, y: y + 1))
      }
      // Bottom right
      if y < (height - 1) && x < (width - 1) {
        result.append(Point(x: x + 1, y: y + 1))
      }
      return result
    }

    func pointsMatching(_ predicate: (Int) -> Bool) -> [Point] {
      var result: [Point] = []
      for y in (0..<10) {
        for x in (0..<10) {
          if predicate(state[y][x]) {
            result.append(Point(x: x, y: y))
          }
        }
      }
      return result
//      zip(0..<10, 0..<10)
//        .filter { y, x in predicate(state[y][x]) }
//        .map { y, x in Point(x: x, y: y) }
    }
  }

  public func runPart1() throws -> Int {
    let bowl = Fishbowl(input: exampleInput)
    print("Before any steps:")
    bowl.dumpState()
    for step in 1...100 {
      bowl.tick()
      print("\nAfter step \(step)")
      bowl.dumpState()
      print("Flashes: \(bowl.totalFlashes)")
    }
    return bowl.totalFlashes
  }

  public func runPart2() throws -> Int {
    return 0
  }
}
