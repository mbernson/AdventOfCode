// swift-tools-version:5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AdventOfCode",
  // The new Swift regex features are only supported as of macOS 13 and iOS 16.
  platforms: [.macOS(.v13), .iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, and make them visible to other packages.

    // 2019 solutions
    .library(name: "AdventOfCode2019", targets: ["AdventOfCode2019"]),
    .executable(name: "advent2019", targets: ["Advent2019"]),

    // Intcode library & cli
    .library(name: "Intcode", targets: ["Intcode"]),
    .executable(name: "intcodecli", targets: ["IntcodeCli"]),

    // 2020 solutions
    .library(name: "AdventOfCode2020", targets: ["AdventOfCode2020"]),
    .executable(name: "advent2020", targets: ["Advent2020"]),

    // 2021 solutions
    .library(name: "AdventOfCode2021", targets: ["AdventOfCode2021"]),
    .executable(name: "advent2021", targets: ["Advent2021"]),

    // 2022 solutions
    .library(name: "AdventOfCode2022", targets: ["AdventOfCode2022"]),
    .executable(name: "advent2022", targets: ["Advent2022"]),

    // 2023 solutions
    .library(name: "AdventOfCode2023", targets: ["AdventOfCode2023"]),
    .executable(name: "advent2023", targets: ["Advent2023"]),
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

    .executableTarget(name: "Advent2019", dependencies: ["AdventOfCode2019"]),
    .testTarget(name: "Advent2019Tests", dependencies: ["Advent2019"]),

    // Intcode library & cli
    .target(name: "Intcode"),
    .testTarget(name: "IntcodeTests", dependencies: ["Intcode"]),
    .executableTarget(name: "IntcodeCli", dependencies: ["Intcode"]),

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

    .executableTarget(name: "Advent2020", dependencies: ["AdventOfCode2020"]),
    .testTarget(name: "Advent2020Tests", dependencies: ["Advent2020"]),

    // 2021 solutions
    .target(name: "AdventOfCode2021", resources: [.copy("Input")]),
    .testTarget(name: "AdventOfCode2021Tests", dependencies: ["AdventOfCode2021"]),

    .executableTarget(name: "Advent2021", dependencies: ["AdventOfCode2021"]),
    .testTarget(name: "Advent2021Tests", dependencies: ["Advent2021"]),

    // 2022 solutions
    .target(name: "AdventOfCode2022", resources: [.copy("Input")]),
    .testTarget(name: "AdventOfCode2022Tests", dependencies: ["AdventOfCode2022"]),

    .executableTarget(name: "Advent2022", dependencies: ["AdventOfCode2022"]),
    .testTarget(name: "Advent2022Tests", dependencies: ["Advent2022"]),

    // 2023 solutions
    .target(name: "AdventOfCode2023", resources: [.copy("Input")]),
    .testTarget(name: "AdventOfCode2023Tests", dependencies: ["AdventOfCode2023"]),

    .executableTarget(name: "Advent2023", dependencies: ["AdventOfCode2023"]),
    .testTarget(name: "Advent2023Tests", dependencies: ["Advent2023"]),
  ]
)
