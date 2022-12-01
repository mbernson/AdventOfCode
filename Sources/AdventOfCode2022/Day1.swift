import Foundation

public struct Day1 {
    public let inputURL = Bundle.module.url(forResource: "Input/day1", withExtension: "txt")!

    public init() {}

    public func runPart1() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        let input: [[Int]] = inputString
            .components(separatedBy: "\n\n")
            .map { string in
                string
                    .components(separatedBy: "\n")
                    .compactMap(Int.init)
            }

        let highest: Int = input
            .map { elf in
                let total: Int = elf.reduce(0, +)
                return total
            }
            .max()!

        return highest
    }

    public func runPart2() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        let input: [Int] = inputString
            .components(separatedBy: "\n")
            .compactMap(Int.init)
        print(input)
        return 0
    }
}
