import Foundation

public struct Day10 {
  public let inputURL = Bundle.module.url(forResource: "Input/day10", withExtension: "txt")!

  public init() {}

  public enum ParsingError: Error {
    case incomplete(completion: [Character])
    case corrupted(score: Int)
    case unexpectedCharacter(Character)
  }

  private let openingChars = Set("{[(<")
  private let closingChars = Set("}])>")

  func parseChunk(_ line: String) throws {
    var stack: [Character] = []
    for char in line {
      if openingChars.contains(char) {
        stack.append(char)
      } else if closingChars.contains(char) {
        let closingChar = try closeToOpen(char)
        if stack.last == closingChar {
          _ = stack.popLast()
        } else {
          throw ParsingError.corrupted(score: scoreForCorruptedCharacter(char))
        }
      } else {
        print("Encountered unexpected character: \(char)")
      }
    }

    if !stack.isEmpty {
      let completion = try stack.reversed().compactMap(openToClose)
      throw ParsingError.incomplete(completion: completion)
    }
  }

  private func closeToOpen(_ char: Character) throws -> Character? {
    switch char {
    case "}": return "{"
    case "]": return "["
    case ")": return "("
    case ">": return "<"
    default: throw ParsingError.unexpectedCharacter(char)
    }
  }

  private func openToClose(_ char: Character) throws -> Character? {
    switch char {
    case "{": return "}"
    case "[": return "]"
    case "(": return ")"
    case "<": return ">"
    default: throw ParsingError.unexpectedCharacter(char)
    }
  }

  private func scoreForCorruptedCharacter(_ char: Character) -> Int {
    switch char {
    case ")": return 3
    case "]": return 57
    case "}": return 1197
    case ">": return 25137
    default: return 0
    }
  }

  private func scoreForAutoCompletedCharacter(_ char: Character) -> Int {
    switch char {
    case ")": return 1
    case "]": return 2
    case "}": return 3
    case ">": return 4
    default: return 0
    }
  }

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }

    return try corruptedScore(chunks: input)
  }

  func corruptedScore(chunks: [String]) throws -> Int {
    var corrupted = 0

    for chunk in chunks {
      do {
        try parseChunk(chunk)
      } catch ParsingError.corrupted(let score) {
        corrupted += score
      } catch ParsingError.incomplete {
        continue
      }
    }

    return corrupted
  }

  func autoCompleteScore(chunks: [String]) throws -> Int {
    var scores: [Int] = []

    for chunk in chunks {
      do {
        try parseChunk(chunk)
      } catch ParsingError.corrupted {
        continue
      } catch ParsingError.incomplete(let completion) {
        let score = completion.map(scoreForAutoCompletedCharacter).reduce(0) { acc, cur in
          (acc * 5) + cur
        }
        scores.append(score)
      }
    }

    scores.sort()
    let mid = scores.startIndex + (scores.endIndex - scores.startIndex) / 2
    return scores[mid]
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }

    return try autoCompleteScore(chunks: input)
  }
}
