//
//  main.swift
//  
//
//  Created by Mathijs on 11/11/2020.
//

import Foundation
import AdventOfCode2019

let subcommand = CommandLine.arguments.dropFirst().first

switch subcommand {
case "day1-part1":
  let answer = try! Day1().runPart1()
  print(String(format: "%d", Int(answer)))
case "day1-part2":
  let answer = try! Day1().runPart2()
  print(String(format: "%d", Int(answer)))
case "day2-part1":
  print(String(format: "%d", try! Day2().runPart1()))
case "day2-part2":
  print(String(format: "%d", try! Day2().runPart2(desiredOutput: 19690720)))
case "day3-part1":
  try! AdventOfCode2019.Day3Runner().runPart1()
case "day3-part2":
  try! AdventOfCode2019.Day3Runner().runPart2()
case "day4-part1":
  AdventOfCode2019.Day4().runPart1()
case "day4-part2":
  AdventOfCode2019.Day4().runPart2()
case "day5-part1":
  try! AdventOfCode2019.Day5().runPart1()
case "day5-part2":
  try! AdventOfCode2019.Day5().runPart2()
case let .some(subcommand):
  print("Unrecognized subcommand '\(subcommand)'"); exit(1)
case .none:
  print("No subcommand given"); exit(1)
}
