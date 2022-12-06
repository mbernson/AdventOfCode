import Foundation

public struct Day6 {
    let inputURL = Bundle.module.url(forResource: "Input/day6", withExtension: "txt")!

    public init() {}

    public func runPart1() throws -> Int {
        let input = try String(contentsOf: inputURL)
        if let range = findMarker(in: input) {
            return range.endIndex
        } else {
            throw AdventError(errorDescription: "No solution found for this input")
        }
    }

    func findMarker(in input: String) -> Range<Int>? {
        findMarker(in: input, length: 4)
    }

    func findMessage(in input: String) -> Range<Int>? {
        findMarker(in: input, length: 14)
    }

    private func findMarker(in input: String, length: Int) -> Range<Int>? {
        for (index, _) in input.enumerated() {
            let startIndex = input.index(input.startIndex, offsetBy: index)
            let endIndex = input.index(startIndex, offsetBy: length)
            let range = startIndex..<endIndex
            let xs = input[range]
            if xs.count == length && Set(xs).count == length {
                return index..<(index + length)
            }
        }
        return nil
    }

    public func runPart2() throws -> Int {
        let input = try String(contentsOf: inputURL)
        if let range = findMessage(in: input) {
            return range.endIndex
        } else {
            throw AdventError(errorDescription: "No solution found for this input")
        }
    }
}
