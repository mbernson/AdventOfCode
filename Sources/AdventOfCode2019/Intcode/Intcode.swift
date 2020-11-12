//
//  File.swift
//  
//
//  Created by Mathijs on 11/11/2020.
//

import Foundation

public class IntcodeMachine {
  private(set) var memory: [Int]

  private var instructionPointer: Int = 0
  private var isRunning: Bool = false
  public var inputProvider: IntcodeInputProvider
  public var outputProvider: IntcodeOutputProvider

  public init(
    program: [Int],
    inputProvider: IntcodeInputProvider = EmptyInputProvider(),
    outputProvider: IntcodeOutputProvider = IntcodeOutputPrinter()
  ) {
    self.memory = program
    self.inputProvider = inputProvider
    self.outputProvider = outputProvider
  }

  public func execute() throws -> [Int] {
    isRunning = true

    while isRunning {
      let nextOpCode = memory[instructionPointer]
      guard let nextOperation = Operation(rawValue: nextOpCode) else { throw IntcodeError.invalidOpcode(nextOpCode) }
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

public extension IntcodeMachine {
  enum Operation: Int {
    case add = 1
    case multiply = 2
    case input = 3
    case output = 4
    case halt = 99
  }
}

public enum IntcodeError: Error, LocalizedError {
  case invalidOpcode(Int)
  case missingInput

  public var errorDescription: String? {
    switch self {
    case let .invalidOpcode(code):
      return String(format: "Invalid opcode encountered: %d", code)
    case .missingInput:
      return "The Intcode program requested some input from the provider, but none was provided to it."
    }
  }
}
