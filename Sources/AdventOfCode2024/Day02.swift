import Algorithms
import Foundation

struct Day02: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var input: [[Int]] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map {
                $0.split(separator: " ").compactMap { Int($0) }
            }
    }

    func part1() -> Any {
        return input
            .filter(isSafe)
            .count
    }

    func isSafe(_ input: [Int]) -> Bool {
        let isIncreasing = input.windows(ofCount: 2).allSatisfy {
            $0.first! < $0.last!
        }

        let isDecreasing = input.windows(ofCount: 2).allSatisfy {
            $0.first! > $0.last!
        }

        let isNotTooDifferent = input.windows(ofCount: 2).allSatisfy {
            (1...3).contains(abs($0.first! - $0.last!))
        }

        return (isIncreasing || isDecreasing) && isNotTooDifferent
    }
}
