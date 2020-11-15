import Foundation
import Intcode

public struct Day5 {
  public let inputURL = Bundle.module.url(forResource: "input-day5", withExtension: "txt")!

  public init() {}

  public func runPart1() throws {
    let string = try String(contentsOf: inputURL)
    let machine = try IntcodeMachine(program: string, inputProvider: Just([1]))
    _ = try machine.execute()
  }
}
