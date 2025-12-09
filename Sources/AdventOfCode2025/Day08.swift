import Algorithms
import Collections

struct Day08: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String

    // Splits input data into its component parts and convert from string.
    var input: [Point] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map {
                let parts = $0.split(separator: ",")
                return Point(x: Int(parts[0])!, y: Int(parts[1])!, z: Int(parts[2])!)
            }
    }

    struct Point: Hashable, CustomStringConvertible {
        let x, y, z: Int
        var description: String { "\(x),\(y),\(z)"}
    }
    typealias Distance = Double
    typealias Circuit = Set<Point>

    func distanceBetween(p: Point, q: Point) -> Distance {
        let (x, y, z) = (p.x - q.x, p.y - q.y, p.z - q.z)
        return Double(x * x + y * y + z * z).squareRoot()
    }

    func computeAllDistances() -> [Pair<Point> : Distance] {
        let points = input
        var distances: [Pair<Point> : Distance] = [:]
        for point in points {
            for other in points where other != point {
                let pair = Pair(point, other)
                if distances[pair] == nil {
                    distances[pair] = distanceBetween(p: point, q: other)
                }
            }
        }
        return distances
    }

    func circuits(numberOfConnections: Int) -> [Circuit] {
        let closestPairs = computeAllDistances()
            .sorted(by: { lhs, rhs in
                lhs.value < rhs.value
            })
            .map { $0.key }

        var circuits: [Circuit] = input.map { Circuit([$0]) }

        // Loop through the pairs from closest to furthest
        for i in 0..<numberOfConnections {
            let pair = closestPairs[i]
            let circuitIndexA = circuits.firstIndex(where: { $0.contains(pair.a) })
            let circuitIndexB = circuits.firstIndex(where: { $0.contains(pair.b) })
            if let circuitIndexA, let circuitIndexB, circuitIndexA != circuitIndexB {
                // Merge the circuits
                let union = circuits[circuitIndexA].union(circuits[circuitIndexB])
                let smallerIndex = min(circuitIndexA, circuitIndexB)
                let largerIndex = max(circuitIndexA, circuitIndexB)
                circuits[smallerIndex] = union
                circuits.remove(at: largerIndex)
            } else if circuitIndexA != nil || circuitIndexB != nil {
                // Add the pair to the existing circuit
                let circuitIndex = (circuitIndexA ?? circuitIndexB)!
                circuits[circuitIndex].insert(pair.a)
                circuits[circuitIndex].insert(pair.b)
            }
        }

        return circuits
    }

    func part1() -> Any {
        circuits(numberOfConnections: input.count == 20 ? 10 : 1000)
            .map(\.count).max(count: 3).reduce(1, *)
    }

    func part2() -> Any {
        let closestPairs = computeAllDistances()
            .sorted(by: { lhs, rhs in
                lhs.value < rhs.value
            })
            .map { $0.key }

        var circuits: [Circuit] = input.map { Circuit([$0]) }

        var i = 0
        while true {
            let pair = closestPairs[i]
            let circuitIndexA = circuits.firstIndex(where: { $0.contains(pair.a) })
            let circuitIndexB = circuits.firstIndex(where: { $0.contains(pair.b) })
            if let circuitIndexA, let circuitIndexB, circuitIndexA != circuitIndexB {
                // Exit condition
                if circuits.count == 2 {
                    return pair.a.x * pair.b.x
                }

                // Merge the circuits
                let union = circuits[circuitIndexA].union(circuits[circuitIndexB])
                let smallerIndex = min(circuitIndexA, circuitIndexB)
                let largerIndex = max(circuitIndexA, circuitIndexB)
                circuits[smallerIndex] = union
                circuits.remove(at: largerIndex)
            } else if circuitIndexA != nil || circuitIndexB != nil {
                // Add the pair to the existing circuit
                let circuitIndex = (circuitIndexA ?? circuitIndexB)!
                circuits[circuitIndex].insert(pair.a)
                circuits[circuitIndex].insert(pair.b)
            }
            i += 1
        }
    }
}
