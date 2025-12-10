import Algorithms

struct Day10: AdventDay {
    var data: String

    var input: [Machine] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map(parseMachine)
    }

    struct Machine {
        /// Bitmask for the desired state
        let desiredState: UInt16
        /// Array with bitmasks for the button combinations
        let buttons: [UInt16]
        let joltages: [Int]
    }

    func parseMachine(_ string: Substring) -> Machine {
        var parts = string.split(separator: " ")
        // First part, the desired state
        let stateBooleans = parts.removeFirst()
            .replacing(/\[|\]/, with: "")
            .map { $0 == "#" }
        var state: UInt16 = 0
        for i in stateBooleans.indices {
            // Set the desired bits to true
            if stateBooleans[i] == true {
                state |= (1 << i)
            }
        }
        // Last part, the joltages
        let joltages = parts.removeLast()
            .replacing(/\{|\}/, with: "")
            .split(separator: ",")
            .map { Int($0)! }
        // Middle part, the button presses
        let buttons: [UInt16] = parts.map {
            let ns = $0.replacing(/\(|\)/, with: "")
                .compactMap(\.wholeNumberValue)
            var n: UInt16 = 0
            for k in ns {
                n |= (1 << k)
            }
            return n
        }
        return Machine(desiredState: state, buttons: buttons, joltages: joltages)
    }

    func keypressesToTurnOn(machine: Machine) -> [UInt16] {
        let initialState: UInt16 = 0
        var visited: Set<[UInt16]> = []
        var queue: Deque<[UInt16]> = Deque(machine.buttons.map { [$0] })
        while !queue.isEmpty {
            let v = queue.popFirst()!
            visited.insert(v)
            if apply(combinations: v, to: initialState) == machine.desiredState {
                return v
            }
            for combination in machine.buttons {
                let w = v + [combination]
                if !visited.contains(w) {
                    queue.append(w)
                }
            }
        }
        fatalError("No solution found")
    }

    func apply(combinations: [UInt16], to state: UInt16) -> UInt16 {
        var state = state
        for combination in combinations {
            state ^= combination
        }
        return state
    }

    func part1() -> Any {
        let output = input.map(keypressesToTurnOn)
        return output.map(\.count).reduce(0, +)
    }
}
