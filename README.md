# AdventOfCode

This repository contains my Advent Of Code (AOC) solutions, written in Swift.

## How to use the code

1. Download and install Xcode, for example from the Mac App Store.
1. Clone this repository and double-click on the `Package.swift` file. An Xcode workspace should open.

The directory structure is based on the years and days of AOC. There are seperate directories for reused components such as the intcode machine.

### Running all tests

For all the AOC problems I have solved so far, there is a unit test included to verify that the solution is still working.

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
swift run advent day1-part1
swift run advent day1-part2
swift run advent day2-part1
swift run advent day2-part2
swift run advent day3-part1
swift run advent day3-part2
# You get the idea
```

## Running an intcode interpreter

```
swift run intcodecli
Please enter an intcode program > 3,0,4,0,99
Please enter input > 42
Output: 42
```
