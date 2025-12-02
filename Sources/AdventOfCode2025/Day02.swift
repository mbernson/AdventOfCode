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
                xs.append(contentsOf: x.filter(isInvalidID))
            }
            .reduce(0, +)
    }

    func isInvalidID(_ id: Int) -> Bool {
        let string = String(id)
        guard string.count > 1, string.count % 2 == 0 else { return false }
        let half = string.index(string.startIndex, offsetBy: string.count / 2)
        let firstHalf = string[string.startIndex..<half]
        let secondHalf = string[half..<string.endIndex]
        return firstHalf == secondHalf
    }
}
