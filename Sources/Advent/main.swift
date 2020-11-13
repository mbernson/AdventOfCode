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
case "day3-part1":
  try! AdventOfCode2019.Day3Runner().runPart1()
case "day3-part2":
  try! AdventOfCode2019.Day3Runner().runPart2()
case let .some(subcommand):
  print("Unrecognized subcommand '\(subcommand)'"); exit(1)
case .none:
  print("No subcommand given"); exit(1)
}
