import Foundation

extension IntcodeMachine {
  /// Initializer that parses an intcode program from a string.
  public convenience init(
    program: String,
    inputProvider: InputProvider = EmptyInputProvider(),
    outputProvider: OutputProvider = OutputProviderStdout()
  ) throws {
    let program = try program
      .components(separatedBy: ",")
      .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
      .map { string -> Int in
        guard let int = Int(string) else {
          throw IntcodeError.invalidInstruction(string)
        }
        return int
      }
    self.init(program: program, inputProvider: inputProvider, outputProvider: outputProvider)
  }
}
