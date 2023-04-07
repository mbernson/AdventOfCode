//
//  File.swift
//  
//
//  Created by Mathijs Bernson on 11/01/2023.
//

import Foundation

public struct Day11 {
    public init() {}

    class Monkey {
        let id: Int
        var items: [Int]
        /// Returns the new value
        let operation: (Int) -> Int
        let divTest: Int
        /// Returns the monkey to whom the item should be thrown
        let test: (Int) -> Int

        var numberOfInspections: Int

        init(id: Int, items: [Int], operation: @escaping (Int) -> Int, divTest: Int, test: @escaping (Int) -> Int) {
            self.id = id
            self.items = items
            self.operation = operation
            self.divTest = divTest
            self.test = test
            self.numberOfInspections = 0
        }
    }

    func makeExampleInput() -> [Monkey] {
        return [
            Monkey(id: 0, items: [79, 98], operation: { $0 * 19 }, divTest: 23, test: { ($0 % 23) == 0 ? 2 : 3 }),
            Monkey(id: 1, items: [54, 65, 75, 74], operation: { $0 + 6 }, divTest: 19, test: { ($0 % 19) == 0 ? 2 : 0 }),
            Monkey(id: 2, items: [79, 60, 97], operation: { $0 * $0 }, divTest: 13, test: { ($0 % 13) == 0 ? 1 : 3 }),
            Monkey(id: 3, items: [74], operation: { $0 + 3 }, divTest: 17, test: { ($0 % 17) == 0 ? 0 : 1 }),
        ]
    }

    func makeInput() -> [Monkey] {
        return [
            Monkey(id: 0, items: [54, 61, 97, 63, 74],
                   operation: { $0 * 7 }, divTest: 17, test: { ($0 % 17 == 0) ? 5 : 3 }),
            Monkey(id: 1, items: [61, 70, 97, 64, 99, 83, 52, 87],
                   operation: { $0 + 8 }, divTest: 2, test: { ($0 % 2 == 0) ? 7 : 6 }),
            Monkey(id: 2, items: [60, 67, 80, 65],
                   operation: { $0 * 13 }, divTest: 5, test: { ($0 % 5 == 0) ? 1 : 6 }),
            Monkey(id: 3, items: [61, 70, 76, 69, 82, 56],
                   operation: { $0 + 7 }, divTest: 3, test: { ($0 % 3 == 0) ? 5 : 2 }),
            Monkey(id: 4, items: [79, 98],
                   operation: { $0 + 2 }, divTest: 7, test: { ($0 % 7 == 0) ? 0 : 3 }),
            Monkey(id: 5, items: [72, 79, 55],
                   operation: { $0 + 1 }, divTest: 13, test: { ($0 % 13 == 0) ? 2 : 1 }),
            Monkey(id: 6, items: [63],
                   operation: { $0 + 4 }, divTest: 19, test: { ($0 % 19 == 0) ? 7 : 4 }),
            Monkey(id: 7, items: [72, 51, 93, 63, 80, 86, 81],
                   operation: { $0 * $0 }, divTest: 11, test: { ($0 % 11 == 0) ? 0 : 4 }),
        ]
    }

    func solve(input: [Monkey], rounds: Int, isRound2: Bool) -> Int {
        let monkeys = input
        var round = 0
        let lcm: Int?
        if isRound2 {
            // LCM = Lowest Common Multiple
            // See:
            // https://github.com/rmbolger/AdventOfCode-PS/blob/6beb60ac5b3a54c5011a482bd114bfdd4a2ad6a1/2022/d11.ps1#L55-L59
            lcm = input.map(\.divTest).reduce(1, *)
        } else {
            lcm = nil
        }

        while round < rounds {
            for monkey in monkeys {
                for var item in monkey.items {
                    // Inspect item

                    // Increase worry level
                    item = monkey.operation(item)
                    // Monkey gets bored
                    if let lcm {
                        item = item % lcm
                    } else {
                        item = item / 3
                    }
                    // Item is thrown to next recipient
                    let recipientId = monkey.test(item)
                    let recipient = monkeys[recipientId]
                    assert(recipient.id != monkey.id)
                    recipient.items.append(item)
                    // Monkey has inspected an item
                    monkey.numberOfInspections += 1
                }
                monkey.items.removeAll()
            }
            round += 1
            print("After round \(round):")
            printMonkeyState(monkeys)
        }

        let biggestMonkeys = Array(monkeys.map(\.numberOfInspections).sorted().reversed())
        return biggestMonkeys[0] * biggestMonkeys[1]
    }

    func printMonkeyState(_ monkeys: [Monkey]) {
        for monkey in monkeys {
            print("Monkey \(monkey.id) inspected items \(monkey.numberOfInspections) times.")
        }
    }

    public func runPart1() -> Int {
        let input = makeInput()
        return solve(input: input, rounds: 20, isRound2: false)
    }

    public func runPart2() -> Int {
        let input = makeInput()
        return solve(input: input, rounds: 10_000, isRound2: true)
    }

}
