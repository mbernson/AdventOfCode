import Foundation

public struct Day8 {
  public let inputURL = Bundle.module.url(forResource: "day8", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Entry] = inputString
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .compactMap(Entry.init(line:))

    return countDigitsPart1(in: input)
  }

  func countDigitsPart1(in input: [Entry]) -> Int {
    input
      .flatMap(\.outputValues)
      .filter {
        $0.count == 2 || $0.count == 3 || $0.count == 4 || $0.count == 7
      }
      .count
  }

  struct Entry {
    let signalPatterns: [Set<String.Element>]
    let outputValues: [Set<String.Element>]

    init?(line: String) {
      let parts = line.components(separatedBy: "|")
      guard parts.count == 2 else { return nil }
      self.init(signalPatterns: parts[0], outputValues: parts[1])
    }

    init(signalPatterns: String, outputValues: String) {
      self.signalPatterns = signalPatterns.components(separatedBy: " ").map { Set(Array($0)) }
      self.outputValues = outputValues.components(separatedBy: " ").map { Set(Array($0)) }
    }
  }

  public func runPart2() throws -> Int {
    return 0
  }
}
