import Foundation
import XCTest
@testable import AdventOfCode2021

class Day10Tests: XCTestCase {
  let input: [String] = [
    "[({(<(())[]>[[{[]{<()<>>",
    "[(()[<>])]({[<{<<[]>>(",
    "{([(<{}[<>[]}>{[]{[(<()>",
    "(((({<>}<{<{<>}{[]{[]{}",
    "[[<[([]))<([[{}[[()]]]",
    "[{[{({}]{}}([{[{{{}}([]",
    "{<[[]]>}<{[{[{[]{()[[[]",
    "[<(<(<(<{}))><([]([]()",
    "<{([([[(<>()){}]>(<<{{",
    "<{([{{}}[<[[[<>{}]]]>[]]",
  ]
  let day10 = Day10()

  func testValidChunks() throws {
    XCTAssertNoThrow(try day10.parseChunk("()"))
    XCTAssertNoThrow(try day10.parseChunk("[]"))
    XCTAssertNoThrow(try day10.parseChunk("([])"))
    XCTAssertNoThrow(try day10.parseChunk("{()()()}"))
    XCTAssertNoThrow(try day10.parseChunk("[<>({}){}[([])<>]]"))
    XCTAssertNoThrow(try day10.parseChunk("(((((((((())))))))))"))
  }

  func testIncompleteChunks() throws {
    XCTAssertThrowsError(try day10.parseChunk("([")) { error in
      guard let error = error as? Day10.ParsingError else { XCTFail(); return }
      guard case .incomplete = error else { XCTFail(); return }
    }
  }

  func testCorruptedChunks() throws {
    assertChunkScore(chunk: "{([(<{}[<>[]}>{[]{[(<()>", score: 1197)
    assertChunkScore(chunk: "[[<[([]))<([[{}[[()]]]", score: 3)
    assertChunkScore(chunk: "[{[{({}]{}}([{[{{{}}([]", score: 57)
    assertChunkScore(chunk: "[<(<(<(<{}))><([]([]()", score: 3)
    assertChunkScore(chunk: "<{([([[(<>()){}]>(<<{{", score: 25137)
  }

  private func assertChunkScore(chunk: String, score: Int) {
    XCTAssertThrowsError(try day10.parseChunk(chunk)) { error in
      guard let error = error as? Day10.ParsingError else { XCTFail(); return }
      guard case .corrupted(let actualScore) = error else { XCTFail(); return }
      XCTAssertEqual(actualScore, score)
    }
  }
}
