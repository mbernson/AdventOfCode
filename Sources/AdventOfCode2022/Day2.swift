import Foundation

public struct Day2 {
    public let inputURL = Bundle.module.url(forResource: "Input/day2", withExtension: "txt")!

    public init() {}

    public func runPart1() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        let input: [String] = inputString
            .components(separatedBy: "\n")

        return input
            .compactMap(parseLinePart1)
            .map { (elf, us) in scorePart1(for: elf, us: us) }
            .reduce(0, +)
    }

    enum Roll {
        case rock, paper, scissors
    }

    func parseLinePart1(line: String) -> (Roll, Roll)? {
        let components = line.split(separator: " ")
        guard components.count == 2 else { return nil }
        let elf = String(components[0])
        let us = String(components[1])

        let elfRoll: Roll
        switch elf {
        case "A": elfRoll = .rock
        case "B": elfRoll = .paper
        case "C": elfRoll = .scissors
        default: return nil
        }

        let usRoll: Roll
        switch us {
        case "X": usRoll = .rock
        case "Y": usRoll = .paper
        case "Z": usRoll = .scissors
        default: return nil
        }

        return (elfRoll, usRoll)
    }

    func scorePart1(for elf: Roll, us: Roll) -> Int {
        let usPoints: Int
        switch us {
        case .rock:
            usPoints = 1
        case .paper:
            usPoints = 2
        case .scissors:
            usPoints = 3
        }

        if us == elf {
            // Draw
            return 3 + usPoints
        }

        switch (us, elf) {
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
        let inputString = try String(contentsOf: inputURL)
        let input: [String] = inputString
            .components(separatedBy: "\n")

        return input
            .compactMap(parseLinePart2)
            .map { (elf, us) in scorePart2(for: elf, us: us) }
            .reduce(0, +)
    }

    enum Result {
        case win, lose, draw
    }

    func parseLinePart2(line: String) -> (Roll, Result)? {
        let components = line.split(separator: " ")
        guard components.count == 2 else { return nil }
        let elf = String(components[0])
        let us = String(components[1])

        let elfRoll: Roll
        switch elf {
        case "A": elfRoll = .rock
        case "B": elfRoll = .paper
        case "C": elfRoll = .scissors
        default: return nil
        }

        let usResult: Result
        switch us {
        case "X": usResult = .lose
        case "Y": usResult = .draw
        case "Z": usResult = .win
        default: return nil
        }

        return (elfRoll, usResult)
    }

    func scorePart2(for elf: Roll, us result: Result) -> Int {
        let usRoll: Roll
        switch (result, elf) {
        case (.draw, _): usRoll = elf
        case (.win, .rock): usRoll = .paper
        case (.win, .paper): usRoll = .scissors
        case (.win, .scissors): usRoll = .rock
        case (.lose, .rock): usRoll = .scissors
        case (.lose, .paper): usRoll = .rock
        case (.lose, .scissors): usRoll = .paper
        }

        let usPoints: Int
        switch usRoll {
        case .rock:
            usPoints = 1
        case .paper:
            usPoints = 2
        case .scissors:
            usPoints = 3
        }

        switch result {
        case .win: return 6 + usPoints
        case .draw: return 3 + usPoints
        case .lose: return 0 + usPoints
        }
    }
}
