import Algorithms

struct Day07: AdventDay {
    var data: String

    var input: [[Tile]] {
        data.replacingOccurrences(of: "S", with: "|")
            .split(separator: "\n")
            .filter { !$0.isEmpty }
            .map { $0.compactMap(Tile.init) }
    }

    enum Tile: Character, Hashable {
        case empty = "."
        case splitter = "^"
        case beam = "|"
    }

    func part1() -> Any {
        let input = input
        let width = input[0].count
        var splits = 0
        var beams: [Bool] = input[0].map { $0 == .beam }
        for line in input {
            for i in 0..<width {
                if beams[i] == true && line[i] == .splitter {
                    splits += 1
                    beams[i - 1] = true
                    beams[i] = false
                    beams[i + 1] = true
                }
            }
        }
        return splits
    }
}
