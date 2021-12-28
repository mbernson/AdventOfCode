import Foundation

public struct Day10 {
  public let inputURL = Bundle.module.url(forResource: "Input/day10", withExtension: "txt")!

  public init() {}

  public enum ParsingError: Error {
    case incomplete
    case corrupted(score: Int)
    case unexpectedCharacter(Character)
  }

  let openingChars = Set("{[(<")
  let closingChars = Set("}])>")

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
          throw ParsingError.corrupted(score: scoreForCharacter(char))
        }
      } else {
        print("Encountered unexpected character: \(char)")
      }
    }

    if !stack.isEmpty {
      throw ParsingError.incomplete
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

  private func scoreForCharacter(_ char: Character) -> Int {
    switch char {
    case ")": return 3
    case "]": return 57
    case "}": return 1197
    case ">": return 25137
    default: return 0
    }
  }

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [String] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }

    var corrupted = 0

    for line in input {
      do {
        try parseChunk(line)
      } catch ParsingError.corrupted(let score) {
        corrupted += score
      } catch ParsingError.incomplete {
        continue
      }
    }

    return corrupted
  }

  public func runPart2() throws -> Int {
    return 0
  }
}
