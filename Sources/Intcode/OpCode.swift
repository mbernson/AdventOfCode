import Foundation

public extension IntcodeMachine {
  enum OpCode: Int {
    case add = 1
    case multiply = 2
    case input = 3
    case output = 4
    case jumpIfTrue = 5
    case jumpIfFalse = 6
    case lessThan = 7
    case equals = 8
    case halt = 99

    /// The total number of arguments/operands the operation takes, both input and output.
    var arity: Int {
      switch self {
      case .add, .multiply, .lessThan, .equals:
        return 3
      case .jumpIfTrue, .jumpIfFalse:
        return 2
      case .input, .output:
        return 1
      case .halt:
        return 0
      }
    }
  }
}
