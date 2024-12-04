import Algorithms
import Foundation

struct Day01: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var input: ([Int], [Int]) {
        var left: [Int] = []
        var right: [Int] = []
        for line in data.split(separator: "\n") {
            let parts = line.split(separator: "   ").compactMap { Int($0) }
            if let lhs = parts.first, let rhs = parts.last {
                left.append(lhs)
                right.append(rhs)
            }
        }
        return (left, right)
    }
    
    func part1() -> Any {
        let (left, right) = input
        return zip(left.sorted(), right.sorted()).map {
            abs($0 - $1)
        }
        .reduce(0, +)
    }
    
    func part2() -> Any {
        let (left, right) = input
        return left.map { x in
            x * right.filter { $0 == x }.count
        }
        .reduce(0, +)
    }
}
