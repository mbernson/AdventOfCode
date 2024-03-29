import Foundation

public struct Day4 {
  public let inputURL = Bundle.module.url(forResource: "Input/day4", withExtension: "txt")!

  let rowLength: Int = 5

  public init() {}

  /// Represents a single bingo card
  struct Grid {
    var numbers: [Int]
    /// All the combinations of the bingo grid that make for a valid bingo
    var combinations: [[Int]]
  }

  func parseInput(string: String) -> (draw: [Int], grids: [Grid]) {
    var parts: [String] = string.components(separatedBy: "\n\n")
    let draw: [Int] = parts.removeFirst().components(separatedBy: ",").compactMap(Int.init)
    let grids: [Grid] = parts.compactMap(parseGrid)
    return (draw, grids)
  }

  func parseGrid(string: String) -> Grid? {
    let rows = self.rows(string: string)
    assert(rows.count == rowLength)
    let columns = self.columns(rows: rows)
    assert(columns.count == rowLength)
    let numbers: [Int] = rows.reduce([], +)
    return Grid(numbers: numbers, combinations: rows + columns)
  }

  /// Get all the horizontal rows from a bingo grid
  func rows(string: String) -> [[Int]] {
    return string.components(separatedBy: "\n").map { row in
      row.components(separatedBy: " ")
        .filter { !$0.isEmpty }
        .compactMap(Int.init)
    }.filter { !$0.isEmpty }
  }

  /// Get all the vertical columns from a bingo grid
  func columns(rows: [[Int]]) -> [[Int]] {
    return rows[0].enumerated().map { i, _ in
      rows.map { row in row[i] }
    }
  }

  /// Represents a bingo game that can draw numbers and determine the winner(s)
  struct Bingo {
    var grids: [Grid]
    var drawn: [Int] = []

    var winningBoards: [Grid] {
      grids.filter { grid in
        grid.combinations.contains { combo in combo.isEmpty }
      }
    }

    mutating func removeWinningBoards() -> [Grid] {
      let winningBoards = self.winningBoards
      grids = grids.filter { grid in
        !grid.combinations.contains { combo in combo.isEmpty }
      }
      return winningBoards
    }

    mutating func draw(_ number: Int) {
      drawn.append(number)
      for (index, _) in grids.enumerated() {
        grids[index].combinations = grids[index].combinations.map { combo in
          combo.filter { $0 != number }
        }
        grids[index].numbers = grids[index].numbers.filter { $0 != number }
      }
    }

    mutating func draw(_ numbers: [Int]) {
      for number in numbers {
        draw(number)
      }
    }
  }

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let (draw, grids) = parseInput(string: inputString)
    var bingo = Bingo(grids: grids)

    for n in draw {
      bingo.draw(n)
      let winningBoards = bingo.winningBoards
      if !winningBoards.isEmpty {
        assert(winningBoards.count == 1)
        let winner = winningBoards[0]
        let score = winner.numbers.reduce(0, +)
        return score * n
      }
    }

    throw AdventError(errorDescription: "No solution")
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let (draw, grids) = parseInput(string: inputString)
    var bingo = Bingo(grids: grids)

    var allWinningBoards: [(Int, [Grid])] = []

    for n in draw {
      bingo.draw(n)
      let winningBoards = bingo.removeWinningBoards()
      if !winningBoards.isEmpty {
        allWinningBoards.append((n, winningBoards))
      }
    }

    guard let (n, winners) = allWinningBoards.last, let winner = winners.last else {
      throw AdventError(errorDescription: "No solution")
    }

    let score = winner.numbers.reduce(0, +)
    return score * n
  }
}
