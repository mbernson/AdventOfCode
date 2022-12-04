import Foundation

public struct Day3 {
    public let inputURL = Bundle.module.url(forResource: "Input/day3", withExtension: "txt")!

    let priorities: [Character: Int]

    public init() {
        var priorities: [Character: Int] = [:]
        for (character, priority) in zip(("a"..."z").characters, 1...26) {
            priorities[character] = priority
        }
        for (character, priority) in zip(("A"..."Z").characters, 27...52) {
            priorities[character] = priority
        }
        self.priorities = priorities
    }

    public func runPart1() throws -> Int {
        let lines: [String] = try String(contentsOf: inputURL)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }

        let rucksacks = lines.map { line -> ([Character], [Character]) in
            let half = line.index(line.startIndex, offsetBy: line.count / 2)
            let firstCompartment = line[line.startIndex..<half].map(Character.init)
            let secondCompartment = line[half..<line.endIndex].map(Character.init)
            return (firstCompartment, secondCompartment)
        }

        let result: Int = rucksacks.map { a, b in
            let commonItems = Set(a).intersection(Set(b))
            let item = commonItems.first!
            let priority = priorities[item]!
            return priority
        }.reduce(0, +)

        return result
    }

    public func runPart2() throws -> Int {
        let lines: [String] = try String(contentsOf: inputURL)
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }

        var score: Int = 0
        var iterator = stride(from: lines.startIndex, to: lines.endIndex, by: 3).makeIterator()
        while let startIndex = iterator.next() {
            let endIndex = min(startIndex.advanced(by: 3), lines.endIndex)
            let set: Set<Character> = lines[startIndex..<endIndex].map { line in
                Set(line.map(Character.init))
            }.reduce(into: Set<Character>()) { result, item in
                if result.isEmpty {
                    result = result.union(item)
                } else {
                    result = result.intersection(item)
                }
            }
            score += priorities[set.first!]!
        }

        return score
    }
}
