import AdventOfCode2022
import Foundation

let commands = CommandLine.arguments.dropFirst()

switch commands {
case ["day1", "part1"]:
    print(try! Day1().runPart1())
case ["day1", "part2"]:
    print(try! Day1().runPart2())
case ["day2", "part1"]:
    print(try! Day2().runPart1())
case ["day2", "part2"]:
    print(try! Day2().runPart2())
case ["day3", "part1"]:
    print(try! Day3().runPart1())
case ["day3", "part2"]:
    print(try! Day3().runPart2())
case ["day4", "part1"]:
    print(try! Day4().runPart1())
case ["day4", "part2"]:
    print(try! Day4().runPart2())
case ["day5", "part1"]:
    print(try! Day5().runPart1())
case ["day5", "part2"]:
    print(try! Day5().runPart2())
case ["day6", "part1"]:
    print(try! Day6().runPart1())
case ["day6", "part2"]:
    print(try! Day6().runPart2())
case ["day7", "part1"]:
    print(try! Day7().runPart1())
case ["day7", "part2"]:
    print(try! Day7().runPart2())
case ["day8", "part1"]:
    print(try! Day8().runPart1())
case ["day8", "part2"]:
    print(try! Day8().runPart2())
case ["day9", "part1"]:
    print(try! Day9().runPart1())
case ["day9", "part2"]:
    print(try! Day9().runPart2())
case ["day10", "part1"]:
    let day10 = Day10()
    print(try! day10.runPart1(inputURL: day10.inputURL))
case ["day10", "part2"]:
    print(try! Day10().runPart2())
case ["day11", "part1"]:
    print(Day11().runPart1())
case ["day11", "part2"]:
    print(Day11().runPart2())
case ["day12", "part1"]:
    print(Day12().runPart1())
case ["day12", "part2"]:
    print(Day12().runPart2())

case []:
    print("No subcommand given"); exit(1)
default:
    print("Unrecognized subcommand '\(commands.joined(separator: " "))'"); exit(1)
}
