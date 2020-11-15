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

    while isRunning {
      let nextOpCode = memory[instructionPointer]
      guard let nextOperation = Operation(rawValue: nextOpCode) else { throw IntcodeError.invalidOpcode(code: nextOpCode) }
      switch nextOperation {
      case .add:
        performArityTwoOperation(+)
      case .multiply:
        performArityTwoOperation(*)
      case .input:
        guard let input = inputProvider.requestInput() else { throw IntcodeError.missingInput }
        let inputAddress = memory[instructionPointer + 1]
        memory[inputAddress] = input
        instructionPointer += 2
      case .output:
        let outputAddress = memory[instructionPointer + 1]
        outputProvider.output(value: memory[outputAddress])
        instructionPointer += 2
      case .halt:
        isRunning = false
      }
    }
    return memory
  }

  private func performArityTwoOperation(_ block: (Int, Int) -> Int) {
    let lhs_addr = memory[instructionPointer + 1]
    let rhs_addr = memory[instructionPointer + 2]
    let result_addr = memory[instructionPointer + 3]
    let lhs = memory[lhs_addr]
    let rhs = memory[rhs_addr]
    memory[result_addr] = block(lhs, rhs)
    instructionPointer += 4
  }
}
