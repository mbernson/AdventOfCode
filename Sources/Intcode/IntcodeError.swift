import Foundation

public enum IntcodeError: Error, LocalizedError {
  case invalidOpcode(code: Int)
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
