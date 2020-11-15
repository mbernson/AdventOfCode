import Foundation

public enum IntcodeError: Error, LocalizedError {
  case invalidOpcode(code: Int)
  case invalidParameterMode(mode: Int)
  case missingInput
  case featureNotImplemented
  case invalidNumberOfParameters

  public var errorDescription: String? {
    switch self {
    case let .invalidOpcode(code):
      return String(format: "Unknown opcode encountered: %d", code)
    case let .invalidParameterMode(mode):
      return String(format: "Unknown parameter encountered: %d", mode)
    case .missingInput:
      return "The Intcode program requested some input from the provider, but none was provided to it."
    case .featureNotImplemented:
      return "Attempted to use a feature that is not yet implemented"
    case .invalidNumberOfParameters:
      return "Invalid number of paramters given for operation"
    }
  }
}
