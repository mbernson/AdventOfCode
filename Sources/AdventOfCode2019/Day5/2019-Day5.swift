import Foundation
import Intcode

public struct Day5 {
  public let inputURL = Bundle.module.url(forResource: "input-day5", withExtension: "txt")!

  public init() {}

  public func runPart1() throws {
    let string = try String(contentsOf: inputURL)
    let program = string
      .components(separatedBy: ",")
      .compactMap(Int.init)
    let machine = IntcodeMachine(program: program, inputProvider: Just([1]))
    _ = try machine.execute()
  }
}
