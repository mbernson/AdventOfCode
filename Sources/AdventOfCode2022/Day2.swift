import Foundation

public struct Day2 {
    public let inputURL = Bundle.module.url(forResource: "Input/day2", withExtension: "txt")!

    public init() {}

    public func runPart1() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        let input: [String] = inputString
            .components(separatedBy: "\n")

        var totalScore = 0

        for line in input {
            if line.isEmpty { continue }
            let components = line.split(separator: " ")
            assert(components.count == 2)
            let elf = String(components[0])
            let us = String(components[1])
            totalScore += score(for: elf, us: us)
        }

        return totalScore
    }

    enum Roll {
        case rock, paper, scissors
    }

    func score(for elf: String, us: String) -> Int {
        let elfRoll: Roll
        switch elf {
        case "A": elfRoll = .rock
        case "B": elfRoll = .paper
        case "C": elfRoll = .scissors
        default: fatalError("Invalid elf roll")
        }

        let usPoints: Int
        let usRoll: Roll
        switch us {
        case "X":
            usRoll = .rock
            usPoints = 1
        case "Y":
            usRoll = .paper
            usPoints = 2
        case "Z":
            usRoll = .scissors
            usPoints = 3
        default: fatalError("Invalid us roll")
        }

        if usRoll == elfRoll {
            // Draw
            return 3 + usPoints
        }

        switch (usRoll, elfRoll) {
        case (.rock, .scissors),
             (.paper, .rock),
             (.scissors, .paper):
            // We win
            return 6 + usPoints
        default:
            // We lose
            return 0 + usPoints
        }
    }

    public func runPart2() throws -> Int {
        return 0
    }
}
