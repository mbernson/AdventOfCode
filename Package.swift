// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AdventOfCode",
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.
    .library(name: "AdventOfCode2019", targets: ["AdventOfCode2019"]),
    .library(name: "AdventOfCode2020", targets: ["AdventOfCode2020"]),
    .executable(name: "advent", targets: ["Advent"]),

    .library(name: "Intcode", targets: ["Intcode"]),
    .executable(name: "intcodecli", targets: ["IntcodeCli"]),
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages this package depends on.

    // 2019 solutions
    .target(name: "AdventOfCode2019", dependencies: ["Intcode"], resources: [
      .copy("Day1/day1.txt"),
      .copy("Day2/day2.txt"),
      .copy("Day3/day3.txt"),
      .copy("Day5/day5.txt"),
    ]),
    .testTarget(name: "AdventOfCode2019Tests", dependencies: ["AdventOfCode2019"]),

    // Intcode library & cli
    .target(name: "Intcode"),
    .testTarget(name: "IntcodeTests", dependencies: ["Intcode"]),
    .target(name: "IntcodeCli", dependencies: ["Intcode"]),

    // 2020 solutions
    .target(name: "AdventOfCode2020", resources: [
      .copy("Day1/day1.txt"),
      .copy("Day2/day2.txt"),
      .copy("Day3/day3.txt"),
      .copy("Day4/day4.txt"),
      .copy("Day5/day5.txt"),
      .copy("Day6/day6.txt"),
      .copy("Day7/day7.txt"),
      .copy("Day8/day8.txt"),
      .copy("Day9/day9.txt"),
      .copy("Day10/day10.txt"),
      .copy("Day12/day12.txt"),
    ]),
    .testTarget(name: "AdventOfCode2020Tests", dependencies: ["AdventOfCode2020"]),

    // Solution runner
    .target(name: "Advent", dependencies: [
      "AdventOfCode2019",
      "AdventOfCode2020",
    ]),
    .testTarget(name: "AdventTests", dependencies: ["Advent"]),
  ]
)
