import Foundation

public struct Day8 {
  public let inputURL = Bundle.module.url(forResource: "day8", withExtension: "txt")!

  typealias SegmentDisplay = Set<String.Element>

  enum Segment {
    static let zero: Day8.SegmentDisplay = ["a","b","c","e","f","g"]
    static let one: Day8.SegmentDisplay = ["c","f"]
    static let two: Day8.SegmentDisplay = ["a","c","d","e","g"]
    static let three: Day8.SegmentDisplay = ["a","c","d","f","g"]
    static let four: Day8.SegmentDisplay = ["b","c","d","f"]
    static let five: Day8.SegmentDisplay = ["a","b","d","f","g"]
    static let six: Day8.SegmentDisplay = ["a","b","d","e","f","g"]
    static let seven: Day8.SegmentDisplay = ["a","c","f"]
    static let eight: Day8.SegmentDisplay = ["a","b","c","d","e","f","g"]
    static let nine: Day8.SegmentDisplay = ["a","b","c","d","f","g"]
  }

  private let segmentsToDigit: [Day8.SegmentDisplay: Int] = [
    Segment.zero:  0,
    Segment.one:   1,
    Segment.two:   2,
    Segment.three: 3,
    Segment.four:  4,
    Segment.five:  5,
    Segment.six:   6,
    Segment.seven: 7,
    Segment.eight: 8,
    Segment.nine:  9,
  ]

  private var segments: [SegmentDisplay: Int] = [:]

  public init() {
  }

  func digitForSegments(_ segments: SegmentDisplay) -> Int? {
    return segmentsToDigit[segments]
  }

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
    let signalPatterns: [SegmentDisplay]
    let outputValues: [SegmentDisplay]

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
