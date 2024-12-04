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
}
