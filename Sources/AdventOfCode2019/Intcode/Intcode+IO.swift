import Foundation

public protocol IntcodeOutputProvider {
  func output(value: Int)
}

public protocol IntcodeInputProvider {
  func requestInput() -> Int?
}

public class JustInputProvider: IntcodeInputProvider {
  private var inputs: [Int]

  public init(_ inputs: [Int]) {
    self.inputs = inputs
  }

  public func requestInput() -> Int? {
    inputs.removeFirst()
  }
}

public class IntcodeOutputPrinter: IntcodeOutputProvider {
  public init() {}

  public func output(value: Int) {
    print(String(format: "Output: %d", value))
  }
}

public class IntcodeVoidOutputProvider: IntcodeOutputProvider {
  public init() {}
  public func output(value: Int) {}
}

public class EmptyInputProvider: IntcodeInputProvider {
  public init() {}

  public func requestInput() -> Int? {
    return nil
  }
}

public class ClosureOutputProvider: IntcodeOutputProvider {
  public let closure: (Int) -> ()

  public init(_ closure: @escaping (Int) -> ()) {
    self.closure = closure
  }

  public func output(value: Int) {
    closure(value)
  }
}
