import Algorithms

struct Day03: AdventDay {
    var data: String

    var lines: [Substring] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
    }

    func part1() -> Any {
        lines.reduce(0) { acc, line in
            acc + maximumJoltage(line)
        }
    }

    func maximumJoltage(_ substring: Substring) -> Int {
        let characters = substring.map(String.init)
        let numbers = substring.map { $0.wholeNumberValue! }

        var max = 0
        for i in numbers.indices {
            for j in numbers.indices where j > i {
                let total = Int(characters[i] + characters[j])!
                if total > max {
                    max = total
                }
            }
        }
        return max
    }
 }
