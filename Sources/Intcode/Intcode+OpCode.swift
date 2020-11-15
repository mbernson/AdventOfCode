//
//  File.swift
//  
//
//  Created by Mathijs on 15/11/2020.
//

import Foundation

public extension IntcodeMachine {
  enum OpCode: Int {
    case add = 1
    case multiply = 2
    case input = 3
    case output = 4
    case halt = 99

    /// The number of arguments the operation takes.
    var arity: Int {
      switch self {
      case .add, .multiply:
        return 3
      case .input, .output:
        return 1
      case .halt:
        return 0
      }
    }
  }
}
