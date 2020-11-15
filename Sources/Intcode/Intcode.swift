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
      let parameters = fetchParameters(instruction: instruction)

      switch instruction.opCode {
      case .add:
        try performArityTwoOperation(+, parameters: parameters)
      case .multiply:
        try performArityTwoOperation(*, parameters: parameters)
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
      instructionPointer += instruction.opCode.arity + 1
    }
    isRunning = false
    return memory
  }

  private func performArityTwoOperation(_ block: (Int, Int) -> Int, parameters: [Int]) throws {
    guard parameters.count == 3 else { throw IntcodeError.invalidNumberOfParameters }
    let result_addr = memory[instructionPointer + 3]
    memory[result_addr] = block(parameters[0], parameters[1])
  }

  private func fetchParameters(instruction: Instruction) -> [Int] {
    if instruction.opCode.arity == 0 {
      return []
    }
    let start = instructionPointer + 1
    let end = start + instruction.opCode.arity - 1
    let sector = memory[start...end]
    let parameters = zip(sector, instruction.parameterModes)
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
