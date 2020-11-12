//
//  File.swift
//  
//
//  Created by Mathijs on 11/11/2020.
//

import Foundation

struct Day2 {
  public let inputURL = Bundle.module.url(forResource: "input-day2", withExtension: "txt")!

  func run1() throws -> Int {
    let string = try String(contentsOf: inputURL)
    var program = string
      .components(separatedBy: ",")
      .compactMap(Int.init)
    program[1] = 12
    program[2] = 2
    let machine = IntcodeMachine(program: program)
    let result = machine.execute()
    return result[0]
  }

  func run2(desiredOutput: Int) throws -> Int {
    let string = try String(contentsOf: inputURL)
    var program = string
      .components(separatedBy: ",")
      .compactMap(Int.init)

    for noun in 0...99 {
      for verb in 0...99 {
        program[1] = noun
        program[2] = verb
        let machine = IntcodeMachine(program: program)
        let result = machine.execute()
        let output = result[0]
        if output == desiredOutput {
          return noun * 100 + verb
        }
      }
    }

    throw Day2Error.solutionNotFound
  }

  enum Day2Error: Error, LocalizedError {
    case solutionNotFound

    var errorDescription: String? {
      switch self {
      case .solutionNotFound: return "No solution was found"
      }
    }
  }
}
