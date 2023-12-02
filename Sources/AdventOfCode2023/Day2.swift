import Foundation

public struct Day2 {
    public let inputURL = Bundle.module.url(forResource: "Input/day2", withExtension: "txt")!

    public init() {}

    struct Game {
        let id: Int
        let turns: [Turn]
    }
    typealias Turn = [String : Int]
    typealias TurnPart = (String, Int)
    let emptyTurn: Turn = ["red" : 0, "green" : 0, "blue" : 0]

    public func runPart1() throws -> Int {
        let configuration: Turn = [
            "red" : 12,
            "green" : 13,
            "blue" : 14,
        ]
        let inputString = try String(contentsOf: inputURL)
        let games: [Game] = inputString
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map(parseIDFromLine)
            .map(parseLineIntoGame)

        return games.filter { game in
            // Get maximum count per color from the game
            let turn: Turn = game.turns.reduce(into: emptyTurn) { total, turn in
                for (key, value) in turn {
                    if total[key]! < value {
                        total[key] = value
                    }
                }
            }

            return turn.allSatisfy { key, value in
                turn[key]! <= configuration[key]!
            }
        }
        .map(\.id)
        .reduce(0, +)
    }

    func parseIDFromLine(line: String) -> (Int, String) {
        let parts = line.split(separator: ":").map { String($0).trim() }
        let n = String(parts[0].split(separator: " ").last!)
        return (Int(n)!, parts[1])
    }

    func parseLineIntoGame(id: Int, line: String) -> Game {
        let turns: [Turn] = line.split(separator: ";")
            .map { String($0).trim() }
            .map { game -> Turn in
                let turns = game.split(separator: ",").map { String($0).trim() }
                return turns.map { turn -> TurnPart in
                    let parts: [String] = turn.split(separator: " ").map { String($0).trim() }
                    return (parts[1], Int(parts[0])!)
                }
                .reduce(into: Turn()) { acc, turn in
                    acc[turn.0] = turn.1
                }
            }
        return Game(id: id, turns: turns)
    }

    public func runPart2() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        let games: [Game] = inputString
            .components(separatedBy: "\n")
            .filter { !$0.isEmpty }
            .map(parseIDFromLine)
            .map(parseLineIntoGame)

        return games.map { game -> Turn in
            game.turns.reduce(into: emptyTurn) { total, turn in
                for (key, value) in turn {
                    if total[key]! < value {
                        total[key] = value
                    }
                }
            }
        }
        .map(power)
        .reduce(0, +)
    }

    func power(of turn: Turn) -> Int {
        turn["red"]! * turn["green"]! * turn["blue"]!
    }
}

extension String {
    func trim() -> String { trimmingCharacters(in: .whitespacesAndNewlines) }
}
