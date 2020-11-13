# AdventOfCode

My Advent Of Code (AOC) solutions, written in Swift.

## How to use the code

1. Download and install Xcode, for example from the Mac App Store.
1. Clone this repository and double-click on the `Package.swift` file. An Xcode workspace should open.

The directory structure is based on the years and days of AOC. There are seperate directories for reused components such as the intcode machine.

### Running all tests

For all the AOC problems I have solved so far, there is a unit test included to verify that the solution is still working.

Most of the solutions were written using test-driven development (TDD), so there are also lots of additional tests for the subcomponents of the solutions.

To run the tests:

1. In the top left dropdowns, select "AdventOfCode-Package" and "My Mac".
1. Press command-U to run all tests.

### Running code for a specific problem

There is a CLI program that can be used to run some code outside of unit tests.

To use it:

1. Edit the file `Sources/Advent/main.swift` to call into whatever code you want it to. Solutions for the AOC problems are contained within the `AdventOfCode2019` and `AdventOfCode2020` Swift modules.
1. In the top left dropdowns, select "advent" and "My Mac".
1. Press play or command-R to run.
