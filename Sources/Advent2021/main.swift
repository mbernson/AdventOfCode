import AdventOfCode2021
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

case []:
  print("No subcommand given"); exit(1)
default:
  print("Unrecognized subcommand '\(commands.joined(separator: " "))'"); exit(1)
}
