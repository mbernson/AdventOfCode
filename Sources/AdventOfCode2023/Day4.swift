import Foundation

public struct Day4 {
    struct Card {
        let id: Int
        let winningNumbers: [Int]
        let myNumbers: [Int]
    }
    
    public let inputURL = Bundle.module.url(forResource: "Input/day4", withExtension: "txt")!
    
    public init() {}

    func parseCards(from input: String) throws -> [Card] {
        let lines = input.split(separator: "\n")
        var cards = [Card]()
        
        for line in lines {
            if line.isEmpty {
                continue
            }
            let components = line.split(separator: ":")
            let id = Int(components[0].replacingOccurrences(of: "Card ", with: "")) ?? 0
            let numbers = components[1].split(separator: "|").map { $0.split(separator: " ").compactMap { Int($0) } }
            let card = Card(id: id, winningNumbers: numbers[0], myNumbers: numbers[1])
            cards.append(card)
        }
        
        return cards
    }

    func part1(input: String) throws -> Int {
        let cards = try parseCards(from: input)
        var total = 0
        for card in cards {
            var score = 0
            for n in card.myNumbers {
                if card.winningNumbers.firstIndex(of: n) != nil {
                    if score == 0 {
                        score = 1
                    } else {
                        score *= 2
                    }
                }
            }
            total += score
        }
        return total
    }

    public func runPart1() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        return try part1(input: inputString)
    }

    public func runPart2() throws -> Int {
        return 0
    }
}
