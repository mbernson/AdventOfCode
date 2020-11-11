//
//  File.swift
//  
//
//  Created by Mathijs on 11/11/2020.
//

import Foundation
import os.log

public class IntcodeMachine {
  private(set) var memory: [Int]
  private var pointer: Int = 0
  private var running: Bool = false

  public init(program: [Int]) {
    self.memory = program
  }

  public func execute() -> [Int] {
    running = true

    while running {
      let nextOpCode = memory[pointer]
      guard let nextOperation = Operation(rawValue: nextOpCode) else {
        fatalError("Invalid opcode encountered: \(nextOpCode)")
      }
      pointer += 1
      switch nextOperation {
      case .add:
        arityTwoOperation(+)
      case .multiply:
        arityTwoOperation(*)
      case .halt:
        running = false
      }
    }
    return memory
  }

  private func arityTwoOperation(_ block: (Int, Int) -> Int) {
    let lhs_addr = memory[pointer]
    let rhs_addr = memory[pointer + 1]
    let result_addr = memory[pointer + 2]
    let lhs = memory[lhs_addr]
    let rhs = memory[rhs_addr]
    memory[result_addr] = block(lhs, rhs)
    pointer += 3
  }
}

public extension IntcodeMachine {
  enum Operation: Int {
    case add = 1
    case multiply = 2
    case halt = 99
  }
}
