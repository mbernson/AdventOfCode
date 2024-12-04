import Foundation
import Algorithms

struct Day03: AdventDay {
    var data: String

    func part1() throws -> Any {
        data.matches(of: /mul\((?<lhs>\d+),(?<rhs>\d+)\)/)
            .map { result in
                Int(result.lhs)! * Int(result.rhs)!
            }
            .reduce(0, +)
    }

    func part2() throws -> Any {
        var multiplicationEnabled = true
        var total: Int = 0
        for result in data.matches(of: /(?:(?:mul\((?<lhs>\d+),(?<rhs>\d+)\))|(?:do\(\))|(?:don\'t\(\)))/) {
            print(result.output.0)
            if let lhs = result.lhs, let rhs = result.rhs, multiplicationEnabled {
                total += Int(lhs)! * Int(rhs)!
            } else if result.output.0 == "do()" {
                multiplicationEnabled = true
            } else if result.output.0 == "don't()" {
                multiplicationEnabled = false
            }
        }
        return total
    }
}
