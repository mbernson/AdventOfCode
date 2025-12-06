import Algorithms

struct Day06: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var input: ([[Int]], [Operation]) {
        var lines: [[Substring]] = data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map { $0.split(separator: " ", omittingEmptySubsequences: true) }
        let operations = lines.removeLast().map { Operation(rawValue: String($0))! }
        let width = operations.count
        let columns: [[Int]] = lines.reduce(into: Array(repeating: [], count: width)) { acc, line in
            let ns = line.map { Int($0)! }
            for i in 0..<width {
                acc[i].append(ns[i])
            }
        }

        return (columns, operations)
    }

    enum Operation: String, Hashable {
        case add = "+"
        case multiply = "*"
    }

    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        let (columns, operations) = input
        return zip(columns, operations).map { column, operation in
            switch operation {
            case .add: column.reduce(0, +)
            case .multiply: column.reduce(1, *)
            }
        }
        .reduce(0, +)
    }
}
