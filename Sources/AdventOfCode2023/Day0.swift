import Foundation

public struct Day0 {
    public let inputURL = Bundle.module.url(forResource: "Input/day0", withExtension: "txt")!

    public init() {}

    public func runPart1() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        return inputString
            .components(separatedBy: "\n")
            .map { line -> Int in
                return 1
            }
            .reduce(0, +)
    }

    public func runPart2() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        if inputString.isEmpty {
            return 0
        } else {
            return 1
        }
    }
}
