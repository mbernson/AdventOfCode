import Foundation

public struct Day1 {
    public let inputURL = Bundle.module.url(forResource: "Input/day1", withExtension: "txt")!

    public init() {}

    let numbers: Set<Character> = Set("1234567890")
    let digits: [String : Int] = [
        "one" : 1,
        "two" : 2,
        "three" : 3,
        "four" : 4,
        "five" : 5,
        "six" : 6,
        "seven" : 7,
        "eight" : 8,
        "nine" : 9
    ]

    func part1(inputString: String) -> Int {
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

    func scanDigitsFromLine(line: String) -> [Int] {
        var startIndex = line.startIndex
        var endIndex = line.index(after: startIndex)
        var numbers: [Int] = []

        while startIndex < line.endIndex {
            let buffer = String(line[startIndex..<endIndex])
            let digit = String(line[startIndex])
            var result: Int? = nil

            if let digitKey = digits.keys.first(where: { buffer.starts(with: $0) }) {
                result = digits[digitKey]!
            } else if let number = Int(digit) {
                result = number
            }

            if let result {
                numbers.append(result)
            }

            if result != nil || endIndex == line.endIndex {
                startIndex = line.index(after: startIndex)
                endIndex = startIndex
            }
            if endIndex < line.endIndex {
                endIndex = line.index(after: endIndex)
            }
        }

        return numbers
    }

    func part2(inputString: String) -> Int {
        return inputString
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map(scanDigitsFromLine(line:))
            .filter { digits in
                digits.count > 0
            }
            .compactMap { digits -> Int? in
                let string = String(digits.first!).appending(String(digits.last!))
                return Int(string)
            }
            .reduce(0, +)
    }

    public func runPart2() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        return part2(inputString: inputString)
    }
}
