import Algorithms

struct Day02: AdventDay {
    var data: String
    
    var idRanges: [ClosedRange<Int>] {
        let firstLine = data.split(separator: "\n")[0]
        return firstLine.split(separator: ",").map {
            let numbers = $0.split(separator: "-").map(String.init)
            return Int(numbers[0])!...Int(numbers[1])!
        }
    }

    func part1() -> Any {
        return idRanges
            .reduce(into: [Int]()) { xs, x in
                xs.append(contentsOf: x.filter(isInvalidIDPart1))
            }
            .reduce(0, +)
    }

    func isInvalidIDPart1(_ id: Int) -> Bool {
        let string = String(id)
        guard string.count > 1, string.count % 2 == 0 else { return false }
        let half = string.index(string.startIndex, offsetBy: string.count / 2)
        let firstHalf = string[string.startIndex..<half]
        let secondHalf = string[half..<string.endIndex]
        return firstHalf == secondHalf
    }

    func part2() -> Any {
        return idRanges
            .reduce(into: [Int]()) { xs, x in
                xs.append(contentsOf: x.filter(isInvalidIDPart2))
            }
            .reduce(0, +)
    }

    func isInvalidIDPart2(_ id: Int) -> Bool {
        let string = String(id)
        guard string.count > 1 else { return false }
        // Iterate over group sizes
        for groupSize in 1...(string.count / 2) {
            let end = string.index(string.startIndex, offsetBy: groupSize)
            let id = string[string.startIndex..<end]
            if patternRepeats(pattern: id, in: string) {
                return true
            }
        }
        return false
    }

    func patternRepeats(pattern: Substring, in string: String) -> Bool {
        let groupSize = pattern.count
        guard string.count % groupSize == 0 else { return false }
        for groupIndex in 1..<(string.count / groupSize) {
            let start = string.index(string.startIndex, offsetBy: groupSize * groupIndex)
            let end = string.index(string.startIndex, offsetBy: groupSize * groupIndex + groupSize)
            let otherId = string[start..<end]
            if otherId != pattern {
                return false
            }
        }
        return true
    }
}
