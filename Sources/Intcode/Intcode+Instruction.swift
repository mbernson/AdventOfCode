import Foundation

public extension IntcodeMachine {
  enum ParameterMode: Int {
    case position = 0
    case immediate = 1
  }

  struct Instruction {
    public let opCode: OpCode
    public let parameterModes: [ParameterMode]
  }

  struct Parameters {
    let mode: ParameterMode
    let value: Int
  }

  struct InstructionParser {
    public static func parse(_ instruction: Int) throws -> Instruction {
      let rawOpCode = instruction % 100
      guard let opCode = OpCode(rawValue: rawOpCode) else {
        throw IntcodeError.invalidOpcode(code: rawOpCode)
      }

      let rawFirstParameterMode: Int = instruction / 100 % 10
      guard let firstParameterMode = ParameterMode(rawValue: rawFirstParameterMode)
        else { throw IntcodeError.invalidParameterMode(mode: rawFirstParameterMode) }
      let rawSecondParameterMode: Int = instruction / 1000 % 10
      guard let secondParameterMode = ParameterMode(rawValue: rawSecondParameterMode)
        else { throw IntcodeError.invalidParameterMode(mode: rawSecondParameterMode) }
      let rawThirdParameterMode: Int = (instruction / 10000) % 10
      guard let thirdParameterMode = ParameterMode(rawValue: rawThirdParameterMode)
        else { throw IntcodeError.invalidParameterMode(mode: rawThirdParameterMode) }
      
      return Instruction(opCode: opCode, parameterModes: [
        firstParameterMode,
        secondParameterMode,
        thirdParameterMode,
      ])
    }
  }
}
