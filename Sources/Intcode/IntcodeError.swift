import Foundation

public enum IntcodeError: Error, LocalizedError {
  case invalidOpcode(code: Int)
  case invalidParameterMode(mode: Int)
  case missingInput
  case invalidInstruction(String)
  case internalInconsistency
  case invalidUsage(message: String)

  public var errorDescription: String? {
    switch self {
    case let .invalidOpcode(code):
      return "Unknown opcode encountered: \(code)"
    case let .invalidParameterMode(mode):
      return "Unknown parameter encountered: \(mode)"
    case .missingInput:
      return "The Intcode program requested some input from the provider, but none was provided to it."
    case let .invalidInstruction(string):
      return "Encountered instruction value '\(string)' which is not a valid integer."
    case .internalInconsistency:
      return "An internal error occurred. This shouldn't happen."
    case let .invalidUsage(message):
      return message
    }
  }
}
