import Foundation

/// An output provider logs or stores any integers that the intcode machine outputs using opcode 4.
public protocol OutputProvider {
  func output(value: Int)
}

/// Logs output to sdtout.
public class OutputProviderStdout: OutputProvider {
  public init() {}

  public func output(value: Int) {
    print("Output: \(value)")
  }
}

/// Discards all output sent to it.
public class VoidOutputProvider: OutputProvider {
  public init() {}
  public func output(value: Int) {}
}

public class ClosureOutputProvider: OutputProvider {
  public let closure: (Int) -> ()

  public init(_ closure: @escaping (Int) -> ()) {
    self.closure = closure
  }

  public func output(value: Int) {
    closure(value)
  }
}
