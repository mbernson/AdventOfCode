import Algorithms

struct Day06: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var inputPart1: ([[Int]], [Operation]) {
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

    var inputPart2: ([[Int]], [Operation]) {
        var lines: [Substring] = data.split(separator: "\n")
            .filter { !$0.isEmpty }
        let height = lines.count
        let operations = lines.removeLast()
            .split(separator: " ", omittingEmptySubsequences: true)
            .map { Operation(rawValue: String($0))! }
        let width = operations.count

        var columns: [[Int]] = Array(repeating: [], count: width)
        var col = 0
        for x in 0..<lines[0].count {
            let characters = (0..<(height - 1)).map { y in
                let line = lines[y]
                let x = line.index(line.startIndex, offsetBy: x)
                let character = line[x]
                return character
            }.filter { !$0.isWhitespace }

            if characters.isEmpty {
                col += 1
            } else {
                let n = Int(String(characters))!
                columns[col].append(n)
            }
        }

        assert(columns.count == operations.count)

        return (columns, operations.compactMap { $0 })
    }

    enum Operation: String, Hashable {
        case add = "+"
        case multiply = "*"
    }

    private func calculateProblem(columns: [[Int]], operations: [Operation]) -> Int {
        return zip(columns, operations).map { column, operation in
            switch operation {
            case .add: column.reduce(0, +)
            case .multiply: column.reduce(1, *)
            }
        }
        .reduce(0, +)
    }

    func part1() -> Any {
        let (columns, operations) = inputPart1
        return calculateProblem(columns: columns, operations: operations)
    }

    func part2() -> Any {
        let (columns, operations) = inputPart2
        return calculateProblem(columns: columns, operations: operations)
    }
}
