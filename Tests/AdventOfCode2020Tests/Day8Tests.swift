@testable import AdventOfCode2020
import XCTest

final class Day8Tests: XCTestCase {
  func testInstructionParsing() throws {
    let programString = "nop +0\nacc +1\njmp +4\nacc +3\njmp -3\nacc -99\nacc +1\njmp -4\nacc +6"
    XCTAssertEqual(
      try Day8.ProgramFactory().parseProgram(string: programString),
      [
        Day8.Instruction(operation: .nop, argument: 0),
        Day8.Instruction(operation: .acc, argument: 1),
        Day8.Instruction(operation: .jmp, argument: 4),
        Day8.Instruction(operation: .acc, argument: 3),
        Day8.Instruction(operation: .jmp, argument: -3),
        Day8.Instruction(operation: .acc, argument: -99),
        Day8.Instruction(operation: .acc, argument: 1),
        Day8.Instruction(operation: .jmp, argument: -4),
        Day8.Instruction(operation: .acc, argument: 6),
      ]
    )
  }

  func testSampleProgramRunOnce() throws {
    let programString = "nop +0\nacc +1\njmp +4\nacc +3\njmp -3\nacc -99\nacc +1\njmp -4\nacc +6"
    let program = try Day8.ProgramFactory().parseProgram(string: programString)
    let machine = Day8.Machine(memory: program)
    machine.runOnce()
    XCTAssertEqual(machine.accumulator, 5)
  }

  func testSampleProgramTermination() throws {
    let programString = "nop +0\nacc +1\njmp +4\nacc +3\njmp -3\nacc -99\nacc +1\nnop -4\nacc +6\n"
    let program = try Day8.ProgramFactory().parseProgram(string: programString)
    let machine = Day8.Machine(memory: program)
    XCTAssertTrue(machine.runWithExecutionLimit(limit: 10))
    XCTAssertEqual(machine.accumulator, 8)
  }

  func testSampleProgramInfiniteLoopTermination() throws {
    let programString = "jmp +0\nacc +1\njmp +4\nacc +3\njmp -3\nacc -99\nacc +1\nnop -4\nacc +6\n"
    let program = try Day8.ProgramFactory().parseProgram(string: programString)
    let machine = Day8.Machine(memory: program)
    XCTAssertFalse(machine.runWithExecutionLimit(limit: 10))
    XCTAssertEqual(machine.accumulator, 0)
  }
}
