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
            freshRanges.contains(where: { range in
                range.contains(ingredient)
            })
        }.count
    }
}
