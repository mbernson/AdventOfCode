import Foundation

@available(macOS 13.0, *)
public struct Day5 {
    public let inputURL = Bundle.module.url(forResource: "Input/day5", withExtension: "txt")!

    public init() {}

    let exampleInput: [[String]] = [
        ["Z", "N"],
        ["M", "C", "D"],
        ["P"],
    ]

    let input: [[String]] = [
        "ZPMHR",
        "PCJB",
        "SNHGLCD",
        "FTMDQSRL",
        "FSPQBTZM",
        "TFSZBG",
        "NRV",
        "PGLTDVCM",
        "WQNJFML",
    ].map { Array($0).map { String($0) } }

    func moveCrates(initialState: [[String]], inputURL: URL, isUsingCrateMover9001: Bool) throws -> String {
        var stacks: [[String]] = input
        let regex = #/move (\d+) from (\d+) to (\d+)/#
        let lines: [String] = try String(contentsOf: inputURL)
            .components(separatedBy: "\n")

        var lineNumber = 1
        for line in lines {
            if let match = line.wholeMatch(of: regex) {
                let (_, quantityString, fromString, toString) = match.output
                let quantity = Int(quantityString)!
                let from = Int(fromString)! - 1
                let to = Int(toString)! - 1

                if isUsingCrateMover9001 {
                    let startIndex = stacks[from].startIndex
                    let middleIndex = stacks[from].endIndex - quantity
                    let endIndex = stacks[from].endIndex
                    let xs = stacks[from][middleIndex..<endIndex]
                    let remainder = stacks[from][startIndex..<middleIndex]
                    stacks[to].append(contentsOf: xs)
                    stacks[from] = Array(remainder)
                } else {
                    for _ in 1...quantity {
                        let x = stacks[from].removeLast()
                        stacks[to].append(x)
                    }
                }
            }
            lineNumber += 1
        }

        return stacks.compactMap(\.last).joined()
    }

    public func runPart1() throws -> String {
        return try moveCrates(initialState: input, inputURL: inputURL, isUsingCrateMover9001: false)
    }

    public func runPart2() throws -> String {
        return try moveCrates(initialState: input, inputURL: inputURL, isUsingCrateMover9001: true)
    }
}
