import AdventOfCode2019
import AdventOfCode2020
import Foundation

let commands = CommandLine.arguments.dropFirst()

switch commands {
case ["2019", "day1", "part1"]:
  let answer = try! AdventOfCode2019.Day1().runPart1()
  print(Int(answer))
case ["2019", "day1", "part2"]:
  let answer = try! AdventOfCode2019.Day1().runPart2()
  print(Int(answer))
case ["2019", "day2", "part1"]:
  print(try! AdventOfCode2019.Day2().runPart1())
case ["2019", "day2", "part2"]:
  print(try! AdventOfCode2019.Day2().runPart2(desiredOutput: 19_690_720))
case ["2019", "day3", "part1"]:
  try! AdventOfCode2019.Day3Runner().runPart1()
case ["2019", "day3", "part2"]:
  try! AdventOfCode2019.Day3Runner().runPart2()
case ["2019", "day4", "part1"]:
  AdventOfCode2019.Day4().runPart1()
case ["2019", "day4", "part2"]:
  AdventOfCode2019.Day4().runPart2()
case ["2019", "day5", "part1"]:
  try! AdventOfCode2019.Day5().runPart1()
case ["2019", "day5", "part2"]:
  try! AdventOfCode2019.Day5().runPart2()

case ["2020", "day1", "part1"]:
  print(try! AdventOfCode2020.Day1().runPart1())
case ["2020", "day1", "part2"]:
  print(try! AdventOfCode2020.Day1().runPart2())
case ["2020", "day2", "part1"]:
  print(try! AdventOfCode2020.Day2().runPart1())
case ["2020", "day2", "part2"]:
  print(try! AdventOfCode2020.Day2().runPart2())
case ["2020", "day3", "part1"]:
  print(try! AdventOfCode2020.Day3().runPart1())
case ["2020", "day3", "part2"]:
  print(try! AdventOfCode2020.Day3().runPart2())
case ["2020", "day4", "part1"]:
  print(try! AdventOfCode2020.Day4().runPart1())
case ["2020", "day4", "part2"]:
  print(try! AdventOfCode2020.Day4().runPart2())

case []:
  print("No subcommand given"); exit(1)
default:
  print("Unrecognized subcommand '\(commands.joined(separator: " "))'"); exit(1)
}
