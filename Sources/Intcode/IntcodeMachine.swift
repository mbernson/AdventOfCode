import Foundation

public class IntcodeMachine {
  private(set) var memory: [Int]
  private var instructionPointer: Int = 0
  private var isRunning: Bool = false

  public var inputProvider: InputProvider
  public var outputProvider: OutputProvider

  public init(
    program: [Int],
    inputProvider: InputProvider = EmptyInputProvider(),
    outputProvider: OutputProvider = OutputProviderStdout()
  ) {
    self.memory = program
    self.inputProvider = inputProvider
    self.outputProvider = outputProvider
  }

  /// Runs the machine's given intcode program and returns the machine's memory tape after it has finished running.
  public func execute() throws -> [Int] {
    isRunning = true

    // Main loop
    while isRunning {
      let instruction = try InstructionParser.parse(memory[instructionPointer])
      let parameters = try fetchParameters(instruction: instruction)
      var nextInstructionPointer: Int? = nil

      switch instruction.opCode {
      case .add:
        try performArityTwoOperation(+, parameters: parameters)
      case .multiply:
        try performArityTwoOperation(*, parameters: parameters)
      case .jumpIfTrue:
        if parameters[0] != 0 {
          nextInstructionPointer = parameters[1]
        }
      case .jumpIfFalse:
        if parameters[0] == 0 {
          nextInstructionPointer = parameters[1]
        }
      case .lessThan:
        let result_addr = memory[instructionPointer + 3]
        if parameters[0] < parameters[1] {
          memory[result_addr] = 1
        } else {
          memory[result_addr] = 0
        }
      case .equals:
        let result_addr = memory[instructionPointer + 3]
        if parameters[0] == parameters[1] {
          memory[result_addr] = 1
        } else {
          memory[result_addr] = 0
        }
      case .input:
        guard let input = inputProvider.requestInput() else {
          throw IntcodeError.missingInput
        }
        let inputAddress = memory[instructionPointer + 1]
        memory[inputAddress] = input
      case .output:
        let output = parameters[0]
        outputProvider.output(value: output)
      case .halt:
        isRunning = false
      }

      // Advance instruction pointer
      if let nextInstructionPointer = nextInstructionPointer {
        instructionPointer = nextInstructionPointer
      } else {
        instructionPointer += instruction.opCode.arity + 1
      }
    }
    isRunning = false
    return memory
  }

  private func performArityTwoOperation(_ block: (Int, Int) -> Int, parameters: [Int]) throws {
    let result_addr = memory[instructionPointer + 3]
    let lhs = parameters[0]
    let rhs = parameters[1]
    let result = block(lhs, rhs)
    memory[result_addr] = result
  }

  private func fetchParameters(instruction: Instruction) throws -> [Int] {
    guard instruction.parameterModes[2] == .position else {
      throw IntcodeError.invalidUsage(message: "The third parameter mode should always be in position mode")
    }
    if instruction.opCode.arity == 0 {
      return []
    }
    let start = instructionPointer + 1
    let end = start + instruction.opCode.arity
    guard memory.indices.contains(end) else { throw IntcodeError.internalInconsistency }
    let instructionMemory = memory[start..<end]
    let parameters = zip(instructionMemory, instruction.parameterModes)
      .map { int, mode -> Int in
        switch mode {
        case .immediate:
          return int
        case .position:
          return memory[int]
        }
      }
    return parameters
  }
}
