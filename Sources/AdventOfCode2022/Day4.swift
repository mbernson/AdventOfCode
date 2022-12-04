import Foundation

public struct Day4 {
    public let inputURL = Bundle.module.url(forResource: "Input/day4", withExtension: "txt")!

    public init() {}

    public func runPart1() throws -> Int {
        let lines: [String] = try String(contentsOf: inputURL)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }

        var result: Int = 0

        for line in lines {
            let parts = line.components(separatedBy: ",")
            let a: [Int] = parts[0].components(separatedBy: "-").map { Int($0)! }
            let range1 = a[0]...a[1]
            let b: [Int] = parts[1].components(separatedBy: "-").map { Int($0)! }
            let range2 = b[0]...b[1]
            if (range1.contains(range2.lowerBound) && range1.contains(range2.upperBound)) ||
               (range2.contains(range1.lowerBound) && range2.contains(range1.upperBound)) {
                result += 1
            }
        }

        return result
    }

    public func runPart2() throws -> Int {
        let lines: [String] = try String(contentsOf: inputURL)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }

        var result: Int = 0

        for line in lines {
            let parts = line.components(separatedBy: ",")
            let a: [Int] = parts[0].components(separatedBy: "-").map { Int($0)! }
            let range1 = a[0]...a[1]
            let b: [Int] = parts[1].components(separatedBy: "-").map { Int($0)! }
            let range2 = b[0]...b[1]
            if range1.overlaps(range2) || range2.overlaps(range1) {
                result += 1
            }
        }

        return result
    }
}
