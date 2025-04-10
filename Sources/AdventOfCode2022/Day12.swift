//
//  Day12.swift
//  
//
//  Created by Mathijs Bernson on 01/03/2023.
//

import Foundation

public struct Day12 {
    let grid: Grid<UInt8>
    let exampleGrid: Grid<UInt8>

    typealias Point = Grid<UInt8>.Point

    public init() {
        let inputURL = Bundle.module.url(forResource: "Input/day12", withExtension: "txt")!
        let input = try! String(contentsOf: inputURL)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .filter { !$0.isNewline }
        grid = .init(width: 61, height: 41, memory: input.compactMap(\.asciiValue))
        let exampleInputURL = Bundle.module.url(forResource: "Input/day12_example", withExtension: "txt")!
        let exampleInput = try! String(contentsOf: exampleInputURL)
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .filter { !$0.isNewline }
        exampleGrid = .init(width: 8, height: 5, memory: exampleInput.compactMap(\.asciiValue))
    }

    func solve(grid: Grid<UInt8>, start: Grid<UInt8>.Point, end: Grid<UInt8>.Point) -> Int {
        var unvisited: Set<Point> = Set(grid.points)
        unvisited.remove(start)

        var distances: [Point: Int] = [:]
        for point in grid.points {
            distances[point] = Int.max - 10 // Hack to fix Int overflow... :P
        }
        distances[start] = 0

        var current = start

        while !unvisited.isEmpty {
            let neighbors = grid.adjacentPointsNonDiagonal(to: current)
            for neighbor in neighbors {
                if grid[neighbor] <= grid[current] + 1 {
                    let distance = distances[current]! + 1
                    if distance < distances[neighbor]! {
                        distances[neighbor] = distance
                    }
                }
            }
            unvisited.remove(current)

            let closest = unvisited.min(by: { lhs, rhs in
                distances[lhs]! < distances[rhs]!
            })
            if let closest {
                // Move on to the closest unvisited point
                current = closest
            }
        }

        return distances[end]!
    }

    public func runPart1() -> Int {
        var grid = self.grid
        let startIndex = grid.memory.firstIndex(of: Character("S").asciiValue!)!
        let start = grid.point(at: startIndex)
        let endIndex = grid.memory.firstIndex(of: Character("E").asciiValue!)!
        let end = grid.point(at: endIndex)
        grid.memory[startIndex] = Character("a").asciiValue!
        grid.memory[endIndex] = Character("z").asciiValue!
        return solve(grid: grid, start: start, end: end)
    }

    public func runPart2() -> Int {
        var grid = self.grid
        let startIndex = grid.memory.firstIndex(of: Character("S").asciiValue!)!
        let endIndex = grid.memory.firstIndex(of: Character("E").asciiValue!)!
        let end = grid.point(at: endIndex)
        grid.memory[startIndex] = Character("a").asciiValue!
        grid.memory[endIndex] = Character("z").asciiValue!
        let startValue = Character("a").asciiValue!
        let startingPoints: [Point] = grid.points.filter { point in
            grid[point.x, point.y] == startValue
        }
        // Brute-force it
        var solutions: [Int] = []
        for index in 0..<startingPoints.count {
            let start = startingPoints[index]
            let shortestDistance = solve(grid: grid, start: start, end: end)
            print("\(solutions.count)/\(startingPoints.count)")
            solutions.append(shortestDistance)
        }
        return solutions.min()!
    }
}
