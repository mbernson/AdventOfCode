# AdventOfCode

[![Build status](https://github.com/mbernson/AdventOfCode/workflows/Tests/badge.svg)](https://github.com/mbernson/AdventOfCode/actions)

This repository contains my Advent of Code (AoC) solutions, written in Swift.

## How to use the code

1. Download and install Xcode, for example from the Mac App Store.
1. Clone this repository and double-click on the `Package.swift` file. An Xcode workspace should open.

The directory structure is based on the years and days of AoC. There are seperate directories for reused components such as the intcode machine.

### Running all tests

For all the AoC problems I have solved so far, there is a unit test included to verify that the solution is still working.

Most of the solutions were written using test-driven development (TDD), so there are also lots of additional tests for the subcomponents of the solutions.

To run the tests:

```
swift build
swift test
```

### Running code for a specific problem

There is a CLI runner for the puzzle solutions.

To run a solution:

```
swift run advent2019 day1 part1
swift run advent2019 day1 part2
swift run advent2019 day2 part1
swift run advent2019 day2 part2
swift run advent2020 day1 part1
swift run advent2020 day1 part2
# You get the idea
```

## Running an intcode interpreter

```
swift run intcodecli
Please enter an intcode program > 3,0,4,0,99
Please enter input > 42
Output: 42
```

## Project structure

This project is a Swift package containing a number of different targets and executables.

Each AoC year gets a library target (such as `AdventOfCode2019`) and a runner (such as `Advent2019`).
Both of these also have a matching unit test target.
