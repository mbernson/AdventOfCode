import Algorithms

struct Day09: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var input: [GridPoint] {
        data.split(separator: "\n")
            .filter { !$0.isEmpty }
            .map {
                let parts = $0.split(separator: ",")
                return GridPoint(x: Int(parts[0])!, y: Int(parts[1])!)
            }
    }

    enum Tile: Hashable, CustomStringConvertible {
        case empty
        case red

        var description: String {
            switch self {
            case .empty: "."
            case .red: "#"
            }
        }
    }

    typealias Area = Int
    func computeAllAreas() -> [Pair<GridPoint> : Area] {
        let points = input
        var areas: [Pair<GridPoint> : Area] = [:]
        for point in points {
            for other in points where other != point {
                let pair = Pair(point, other)
                if areas[pair] == nil {
                    areas[pair] = area(p: point, q: other)
                }
            }
        }
        return areas
    }

    func area(p: GridPoint, q: GridPoint) -> Int {
        let smallestX = min(p.x, q.x)
        let smallestY = min(p.y, q.y)
        let largestX = max(p.x, q.x)
        let largestY = max(p.y, q.y)
        let width = largestX - smallestX + 1
        let height = largestY - smallestY + 1
        return width * height
    }

    func part1() -> Any {
        let areas = computeAllAreas()
        let largestRectangle = areas.max { $0.value < $1.value }!
        return largestRectangle.value
    }
}
