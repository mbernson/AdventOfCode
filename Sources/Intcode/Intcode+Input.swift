import Foundation

/// An input provider can give (zero or more) integers as input to the intcode machine when it requests them using opcode 3.
public protocol InputProvider {
  mutating func requestInput() -> Int?
}

/// Asks and waits for input on stdin.
public class InputProviderStdin: InputProvider {
  public init() {}

  public func requestInput() -> Int? {
    print("Please enter input > ", terminator: "")
    guard let input = readLine(strippingNewline: true), !input.isEmpty else {
      print("No input or empty input received.")
      return nil
    }
    return Int(input)
  }
}

/// Provides the given array as a 'queue' of input to the machine.
/// Inputs are taken from the array, starting from the beginning of the array, to the end until there are none remaining.
public struct Just: InputProvider {
  private var inputs: [Int]

  public init(_ inputs: [Int]) {
    self.inputs = inputs
  }

  public mutating func requestInput() -> Int? {
    inputs.removeFirst()
  }
}

/// Provides no input
public class EmptyInputProvider: InputProvider {
  public init() {}

  public func requestInput() -> Int? {
    return nil
  }
}
