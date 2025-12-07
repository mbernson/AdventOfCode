import Algorithms

struct Day07: AdventDay {
    var data: String

    var input: [[Tile]] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map { $0.compactMap(Tile.init) }
    }

    enum Tile: Character, Hashable {
        case start = "S"
        case empty = "."
        case splitter = "^"
        case beam = "|"
    }

    func part1() -> Any {
        let input = input
        let width = input[0].count
        var splits = 0
        var beams: [Bool] = input[0].map { $0 == .start }
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

    func part2() -> Any {
        let input = input
        let width = input[0].count
        var timelines: [Int] = input[0].map { $0 == .start ? 1 : 0 }
        for line in input {
            for i in 0..<width {
                let n = timelines[i]
                if line[i] == .splitter && n > 0 {
                    timelines[i] = 0
                    timelines[i - 1] += n
                    timelines[i + 1] += n
                }
            }
        }
        return timelines.reduce(0, +)
    }
}
