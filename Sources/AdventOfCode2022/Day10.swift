import Foundation

public struct Day10 {
    public let inputURL = Bundle.module.url(forResource: "Input/day10", withExtension: "txt")!
    public let exampleInputURL = Bundle.module.url(forResource: "Input/day10_example", withExtension: "txt")!

    public init() {}

    func parseInstructions(from input: String) -> [CPU.Instruction] {
        input
            .components(separatedBy: "\n")
            .flatMap { string -> [CPU.Instruction] in
                let parts = string.components(separatedBy: " ")
                switch parts[0] {
                case "noop":
                    return [.noop]
                case "addx":
                    if let V = Int(parts[1]) {
                        return [.noop, .addx(V)]
                    } else {
                        fatalError("Invalid addx instruction")
                    }
                default:
                    return []
                }
            }
    }

    public func runPart1(inputURL: URL) throws -> Int {
        let inputString = try String(contentsOf: inputURL)
        let input = parseInstructions(from: inputString)

        let cycleNumbersOfInterest: Set<Int> = [
            20, 60, 100, 140, 180, 220
        ]
        var cpu = CPU(program: input)
        var result: [Int] = []
        for cycle in 1...220 {
            if cycleNumbersOfInterest.contains(cycle) {
                result.append(cpu.x * cycle)
            }

            cpu.runCycle()

            if cpu.program.isEmpty {
                print("Program ran out!")
                break
            }
        }

        return result.reduce(0, +)
    }

    public func runPart2(inputURL: URL) throws {
        let inputString = try String(contentsOf: inputURL)
        let input = parseInstructions(from: inputString)

        let width = 40
        let height = 6
        let max = width * height

        var screen: [Bool] = Array(repeating: false, count: width * height)
        var cpu = CPU(program: input)

        for cycle in 0..<Int.max {
            cpu.runCycle()

            let spritePosition = (cpu.x - 1)...(cpu.x + 1)
            let correctedRange = spritePosition.clamped(to: 0...max)
            screen[cycle] = correctedRange.contains(position)

            if cpu.program.isEmpty {
                print("Program ran out!")
                break
            }
        }

        for y in 0..<height {
            let rowStart = y * width
            let rowEnd = rowStart + width
            let row = screen[rowStart..<rowEnd]
            print(row.map({ $0 == true ? "#" : "." }).joined())
        }
    }

    struct CPU {
        var program: [Instruction]
        var x: Int = 1

        enum Instruction {
            case addx(Int)
            case noop
        }

        mutating func runCycle() {
            let instruction = program.removeFirst()
            switch instruction {
            case .addx(let V):
                x += V
            case .noop:
                break
            }
        }
    }
}
