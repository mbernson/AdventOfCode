// swift-tools-version: 6.0
import PackageDescription

let dependencies: [Target.Dependency] = [
  .product(name: "Algorithms", package: "swift-algorithms"),
  .product(name: "Collections", package: "swift-collections"),
  .product(name: "ArgumentParser", package: "swift-argument-parser"),
]

let package = Package(
  name: "AdventOfCode",
  platforms: [.macOS(.v13), .iOS(.v16), .watchOS(.v9), .tvOS(.v16)],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-algorithms.git",
      .upToNextMajor(from: "1.2.1")),
    .package(
      url: "https://github.com/apple/swift-collections.git",
      .upToNextMajor(from: "1.3.0")),
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      .upToNextMajor(from: "1.6.2")),
//    .package(
//      url: "https://github.com/swiftlang/swift-format.git",
//      .upToNextMajor(from: "602.0.0")),
  ],
  targets: [
    // 2025 solutions
    .executableTarget(
        name: "AdventOfCode2025",
        dependencies: dependencies,
        resources: [.copy("Data")]
    ),
    .testTarget(
        name: "AdventOfCode2025Tests",
        dependencies: ["AdventOfCode2025"] + dependencies
    ),

    // 2024 solutions
    .executableTarget(
      name: "AdventOfCode2024",
      dependencies: dependencies,
      resources: [.copy("Data")]
    ),
    .testTarget(
      name: "AdventOfCode2024Tests",
      dependencies: ["AdventOfCode2024"] + dependencies
    ),

    // 2023 solutions
    .target(name: "AdventOfCode2023", resources: [.copy("Input")]),
    .testTarget(name: "AdventOfCode2023Tests", dependencies: ["AdventOfCode2023"]),

    .executableTarget(name: "Advent2023", dependencies: ["AdventOfCode2023"]),
    .testTarget(name: "Advent2023Tests", dependencies: ["Advent2023"]),

    // 2022 solutions
    .target(name: "AdventOfCode2022", resources: [.copy("Input")]),
    .testTarget(name: "AdventOfCode2022Tests", dependencies: ["AdventOfCode2022"]),

    .executableTarget(name: "Advent2022", dependencies: ["AdventOfCode2022"]),
    .testTarget(name: "Advent2022Tests", dependencies: ["Advent2022"]),

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

    // 2021 solutions
    .target(name: "AdventOfCode2021", resources: [.copy("Input")]),
    .testTarget(name: "AdventOfCode2021Tests", dependencies: ["AdventOfCode2021"]),

    .executableTarget(name: "Advent2021", dependencies: ["AdventOfCode2021"]),
    .testTarget(name: "Advent2021Tests", dependencies: ["Advent2021"]),

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

    // Intcode library & cli
    .target(name: "Intcode"),
    .testTarget(name: "IntcodeTests", dependencies: ["Intcode"]),
    .executableTarget(name: "IntcodeCli", dependencies: ["Intcode"]),

  ],
  swiftLanguageModes: [.v6]
)
