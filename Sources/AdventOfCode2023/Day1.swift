import Foundation

public struct Day1 {
    public let inputURL = Bundle.module.url(forResource: "Input/day1", withExtension: "txt")!

    public init() {}

    func part1(inputString: String) -> Int {
        let numbers: Set<Character> = Set("1234567890")
        return inputString
            .components(separatedBy: "\n")
            .map { line -> [Character] in
                line.filter { numbers.contains($0) }
            }
            .filter { characters in
                characters.count > 0
            }
            .compactMap { digits -> Int? in
                let string = String(digits.first!).appending(String(digits.last!))
                return Int(string)
            }
            .reduce(0, +)
    }

    public func runPart1() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        return part1(inputString: inputString)
    }

    public func runPart2() throws -> Int {
        return 0
    }
}
