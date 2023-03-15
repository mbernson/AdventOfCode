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

    public func runPart2() throws -> Int {
        return 0
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
