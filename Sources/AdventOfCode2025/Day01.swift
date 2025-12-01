import Algorithms

struct Day01: AdventDay {
    var data: String

    // Splits input data into its component parts and convert from string.
    var entities: [String] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map(String.init)
    }

    enum DialDirection: String {
        case right = "R"
        case left = "L"
    }

    private func solve(countClicks: Bool) -> Int {
        let min = 0
        let max = 99
        var dialPosition = 50
        var numberOfTimesPointingAt0 = 0

        for var line in entities {
            let direction = DialDirection(rawValue: String(line.removeFirst()))!
            var amount = Int(String(line))!
            switch direction {
            case .left:
                while amount > 0 {
                    if dialPosition == min {
                        // Handle underflow
                        dialPosition = max
                    } else {
                        dialPosition -= 1
                    }
                    if countClicks && dialPosition == 0 {
                        numberOfTimesPointingAt0 += 1
                    }
                    amount -= 1
                }
            case .right:
                while amount > 0 {
                    if dialPosition == max {
                        // Handle overflow
                        dialPosition = min
                    } else {
                        dialPosition += 1
                    }
                    if countClicks && dialPosition == 0 {
                        numberOfTimesPointingAt0 += 1
                    }
                    amount -= 1
                }
            }

            if !countClicks && dialPosition == 0 {
                numberOfTimesPointingAt0 += 1
            }
        }

        return numberOfTimesPointingAt0
    }

    func part1() -> Any {
        return solve(countClicks: false)
    }

    func part2() -> Any {
        return solve(countClicks: true)
    }
}
