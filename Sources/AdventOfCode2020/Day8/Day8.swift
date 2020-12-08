import Foundation

public struct Day8 {
  public let inputURL = Bundle.module.url(forResource: "day8", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let program = try parseProgram(string: try String(contentsOf: inputURL))
    let machine = Machine(memory: program)
    machine.runOnce()
    return machine.accumulator
  }

  public func runPart2() throws -> Int {
    return 0
  }

  class Machine {
    var accumulator: Int = 0
    var instructionPointer: Int = 0
    let memory: [Instruction]

    init(memory: [Instruction]) {
      self.memory = memory
    }

    /// Run until an instruction is executed the second time
    func runOnce() {
      var executedInstructions = Set<Int>()
      while !executedInstructions.contains(instructionPointer) {
        let currentInstructionPointer = instructionPointer
        step()
        executedInstructions.insert(currentInstructionPointer)
      }
    }

    func step() {
      let instruction = memory[instructionPointer]
      switch instruction.operation {
      case .acc:
        accumulator += instruction.argument
        instructionPointer += 1
      case .jmp:
        instructionPointer += instruction.argument
      case .nop:
        instructionPointer += 1
      }
    }
  }

  func parseProgram(string: String) throws -> [Instruction] {
    return try string.components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map(makeInstruction)
  }

  private func makeInstruction(string: String) throws -> Instruction {
    let parts = string.components(separatedBy: " ")
    guard let operation = Operation(rawValue: parts[0]) else {
      throw ParseError.invalidOperation(operation: parts[0])
    }
    guard let argument = Int(parts[1]) else {
      throw ParseError.invalidArgument(arg: parts[1])
    }
    return Instruction(operation: operation, argument: argument)
  }

  enum ParseError: Error {
    case invalidOperation(operation: String)
    case invalidArgument(arg: String)
  }

  struct Instruction: Equatable {
    let operation: Operation
    let argument: Int
  }

  enum Operation: String {
    case acc
    case jmp
    case nop
  }
}
