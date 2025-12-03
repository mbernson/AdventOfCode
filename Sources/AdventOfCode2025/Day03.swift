import Algorithms

struct Day03: AdventDay {
    var data: String

    var lines: [Substring] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
    }

    func part1() -> Any {
        lines.reduce(0) { acc, line in
            return acc + maximumJoltage(line, length: 2)
        }
    }

    func maximumJoltage(_ substring: Substring, length: Int, startIndex: Int = 0) -> Int {
        let characters = substring.map(String.init)

        let endIndex = characters.count - length
        var max = 0
        if length == 1 {
            for i in startIndex...endIndex {
                let total = Int(characters[i])!
                if total > max {
                    max = total
                }
            }
        } else {
            for i in startIndex...endIndex {
                let total = Int(characters[i] + String(maximumJoltage(substring, length: length - 1, startIndex: i + 1)))!
                if total > max {
                    max = total
                }
            }
        }
        return max
    }
 }
