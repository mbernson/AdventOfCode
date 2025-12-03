import Algorithms

struct Day03: AdventDay {
    var data: String

    var lines: [Substring] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
    }

    func part1() -> Any {
        lines.reduce(0) { acc, line in
            acc + maximumJoltage(line, numberOfBatteries: 2)
        }
    }

    func maximumJoltage(_ substring: Substring, numberOfBatteries: Int) -> Int {
        let line = substring.map { $0.wholeNumberValue! }

        var left = 0
        var digits: [Int] = []
        for n in stride(from: numberOfBatteries - 1, through: 0, by: -1) {
            let right = line.count - n
            let d = line[left..<right].max() ?? line.last!
            left += Array(line[left...]).firstIndex(of: d)! + 1
            digits.append(d)
        }

        return Int(digits.map(String.init).joined())!
    }

    func part2() -> Any {
        lines.reduce(0) { acc, line in
            acc + maximumJoltage(line, numberOfBatteries: 12)
        }
    }
 }
