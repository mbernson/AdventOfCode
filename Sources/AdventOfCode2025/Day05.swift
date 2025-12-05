import Algorithms

struct Day05: AdventDay {
    var data: String

    var input: ([ClosedRange<Int>], [Int]) {
        let parts = data.split(separator: "\n\n")
        let freshRanges = parts[0].split(separator: "\n").map { line in
            let parts = line.split(separator: "-")
            return Int(parts[0])!...Int(parts[1])!
        }
        let ingredients = parts[1].split(separator: "\n").filter { !$0.isEmpty }.map { line in
            return Int(line)!
        }
        return (freshRanges, ingredients)
    }

    func part1() -> Any {
        let (freshRanges, ingredients) = input
        return ingredients.filter { ingredient in
            freshRanges.contains { range in
                range.contains(ingredient)
            }
        }.count
    }

    /// Merges the ranges where the lower bound of the next one overlaps with the upper bound of the previous one.
    /// This function assumes that the input is sorted already.
    func mergeRanges(ranges: [ClosedRange<Int>]) -> [ClosedRange<Int>] {
        var result: [ClosedRange<Int>] = []

        var i = 1
        var current = ranges[0]
        while i < ranges.count {
            let next = ranges[i]

            if next.lowerBound <= current.upperBound {
                current = min(current.lowerBound, next.lowerBound)...max(current.upperBound, next.upperBound)
            } else {
                result.append(current)
                current = next
            }
            i += 1
        }
        result.append(current)

        return result
    }

    func part2() -> Any {
        var (freshRanges, _) = input

        freshRanges = freshRanges.sorted(by: { lhs, rhs in
            lhs.lowerBound < rhs.lowerBound && lhs.upperBound < rhs.upperBound
        })

        freshRanges = mergeRanges(ranges: freshRanges)

        return freshRanges.map(\.count).reduce(0, +)
    }
}
