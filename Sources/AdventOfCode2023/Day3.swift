import Foundation

public struct Day3 {
    public let inputURL = Bundle.module.url(forResource: "Input/day3", withExtension: "txt")!

    public init() {}

    func part1(inputString: String, width: Int, height: Int) -> Int {
        let grid = Grid(width: width, height: height, memory: inputString
            .replacingOccurrences(of: "\n", with: "")
            .map { $0 })
        var numbers: [Int] = []
        var currentNumber = ""
        var hasSeenSymbol = false


        for point in grid.points {
            if isNumber(grid[point]) {
                if grid.adjacentTiles(to: point).contains(where: isSymbol) {
                    hasSeenSymbol = true
                }

                currentNumber.append(grid[point])

                if point.x == grid.width - 1 {
                    if !currentNumber.isEmpty && hasSeenSymbol {
                        numbers.append(Int(currentNumber)!)
                    }
                    currentNumber.removeAll()
                    hasSeenSymbol = false
                }
            } else {
                if !currentNumber.isEmpty && hasSeenSymbol {
                    numbers.append(Int(currentNumber)!)
                }
                currentNumber.removeAll()
                hasSeenSymbol = false
            }
        }
        return numbers.reduce(0, +)
    }

    public func runPart1() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        return part1(inputString: inputString, width: 140, height: 140)
    }

    func part2(inputString: String, width: Int, height: Int) -> Int {
        let grid = Grid(width: width, height: height, memory: inputString
            .replacingOccurrences(of: "\n", with: "")
            .map { $0 })
        var numbers: [Grid<Character>.Point : Set<Int>] = [:]

        for point in grid.points {
            if grid[point] == "*" {
                numbers[point] = []
            }
        }

        var currentNumber = ""
        var currentGears: [Grid<Character>.Point] = []

        for point in grid.points {
            if isNumber(grid[point]) {
                currentGears += grid.adjacentPoints(to: point).filter { point in
                    grid[point] == "*"
                }

                currentNumber.append(grid[point])

                if point.x == grid.width - 1 {
                    if !currentNumber.isEmpty {
                        for gearPos in currentGears {
                            numbers[gearPos]!.insert(Int(currentNumber)!)
                        }
                    }
                    currentNumber.removeAll()
                    currentGears.removeAll()
                }
            } else {
                if !currentNumber.isEmpty {
                    for gearPos in currentGears {
                        numbers[gearPos]!.insert(Int(currentNumber)!)
                    }
                }
                currentNumber.removeAll()
                currentGears.removeAll()
            }
        }
        var total = 0
        for numbersSet in numbers.values {
            let xs = Array(numbersSet)
            if xs.count == 2 {
                total += xs[0] * xs[1]
            }
        }
        return total
    }

    public func runPart2() throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        return part2(inputString: inputString, width: 140, height: 140)
    }

    let symbols = Set("/&$+-%#=*@".map { $0 })

    func isSymbol(_ character: Character) -> Bool {
        symbols.contains(character)
    }

    let numbers = Set("1234567890".map { $0 })

    func isNumber(_ character: Character) -> Bool {
        numbers.contains(character)
    }
}
