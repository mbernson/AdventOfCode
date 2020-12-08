import Foundation

public struct Day8 {
  public let inputURL = Bundle.module.url(forResource: "day8", withExtension: "txt")!
  private let programFactory = ProgramFactory()

  public init() {}

  public func runPart1() throws -> Int {
    let program = try programFactory.parseProgram(string: try String(contentsOf: inputURL))
    let machine = Machine(memory: program)
    machine.runOnce()
    return machine.accumulator
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let program = try programFactory.parseProgram(string: inputString)
    // We need to change any jmp or nop instruction and check if the program terminates.
    let indicesToChange = program.enumerated()
      .filter { index, instruction in
        switch instruction.operation {
        case .acc: return false
        case .jmp, .nop: return true
        }
      }

    for (index, instruction) in indicesToChange {
      // Toggle instruction from nop to jmp or vice versa at `index`.
      var newProgram = try programFactory.parseProgram(string: inputString)
      let newInstruction = Instruction(operation: instruction.operation == .jmp ? .nop : .jmp, argument: instruction.argument)
      newProgram[index] = newInstruction
      let machine = Machine(memory: newProgram)
      // Try running until any single instruction has been executed 10 times.
      // In that case, consider the program non-terminating.
      if machine.runWithExecutionLimit(limit: 10) {
        return machine.accumulator
      } else {
        continue
      }
    }
    throw Day8Error.noSolutionFound
  }

  struct ProgramFactory {
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
  }

  class Machine {
    var accumulator: Int = 0
    var instructionPointer: Int = 0
    let memory: [Instruction]

    init(memory: [Instruction]) {
      self.memory = memory
    }

    /// Run until any instruction is executed the second time.
    func runOnce() {
      var executedInstructions = Set<Int>()
      while !executedInstructions.contains(instructionPointer) {
        executedInstructions.insert(instructionPointer)
        step()
      }
    }

    /// Run until any instruction is executed more than `limit` times.
    /// Return true if the program terminated by itself, false if not.
    func runWithExecutionLimit(limit: Int) -> Bool {
      var executedInstructions = [Int : Int]()
      var terminatedNormally = true
      while memory.indices.contains(instructionPointer) {
        step()

        if let executed = executedInstructions[instructionPointer] {
          executedInstructions[instructionPointer] = executed + 1
          if executed > limit {
            terminatedNormally = false
            break
          }
        } else {
          executedInstructions[instructionPointer] = 1
        }
      }
      return terminatedNormally
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

  enum Day8Error: Error {
    case noSolutionFound
  }
}
