import Foundation
import Intcode

public struct Day2 {
  public let inputURL = Bundle.module.url(forResource: "day2", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let string = try String(contentsOf: inputURL)
    var program = string
      .components(separatedBy: ",")
      .compactMap(Int.init)
    program[1] = 12
    program[2] = 2
    let machine = IntcodeMachine(program: program)
    let memory = try machine.execute()
    return memory[0]
  }

  public func runPart2(desiredOutput: Int) throws -> Int {
    let string = try String(contentsOf: inputURL)
    var program = string
      .components(separatedBy: ",")
      .compactMap(Int.init)

    for noun in 0...99 {
      for verb in 0...99 {
        program[1] = noun
        program[2] = verb
        let machine = IntcodeMachine(program: program)
        let memory = try machine.execute()
        let output = memory[0]
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
