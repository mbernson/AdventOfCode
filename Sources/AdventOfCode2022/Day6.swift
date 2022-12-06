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
        for (index, _) in input.enumerated() {
            let startIndex = input.index(input.startIndex, offsetBy: index)
            let endIndex = input.index(startIndex, offsetBy: 4)
            let range = startIndex..<endIndex
            let xs = input[range]
            if xs.count == 4 && Set(xs).count == 4 {
                return index..<(index + 4)
            }
        }
        return nil
    }

    public func runPart2() throws -> Int {
        return 0
    }
}
