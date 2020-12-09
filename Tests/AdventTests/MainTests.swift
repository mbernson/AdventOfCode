import Foundation
import XCTest

class MainTests: XCTestCase {
  let executableName = "advent"

  func testUnknownSubCommand() throws {
    XCTAssertEqual(try runAdventCommand(arguments: []), "No subcommand given\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["foobar"]), "Unrecognized subcommand 'foobar'\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["foo", "bar"]), "Unrecognized subcommand 'foo bar'\n")
  }

  func test2019Day1() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day1", "part1"]), "3308377\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day1", "part2"]), "4959709\n")
  }

  func test2019Day2() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day2", "part1"]), "3765464\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day2", "part2"]), "7610\n")
  }

  func test2019Day3() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day3", "part1"]), "Intersection distance: 8015\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day3", "part2"]), "Lowest costing intersection: 163676 steps\n")
  }

  func test2019Day4() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day4", "part1"]), "2150 passcodes match the requirements\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day4", "part2"]), "1462 passcodes match the requirements\n")
  }

  func test2019Day5() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day5", "part1"]), "Output: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 14155342\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2019", "day5", "part2"]), "Output: 8684145\n")
  }

  func test2020Day1() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day1", "part1"]), "121396\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day1", "part2"]), "73616634\n")
  }

  func test2020Day2() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day2", "part1"]), "660\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day2", "part2"]), "530\n")
  }

  func test2020Day3() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day3", "part1"]), "274\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day3", "part2"]), "6050183040\n")
  }

  func test2020Day4() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day4", "part1"]), "202\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day4", "part2"]), "137\n")
  }

  func test2020Day5() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day5", "part1"]), "858\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day5", "part2"]), "557\n")
  }

  func test2020Day6() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day6", "part1"]), "7128\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day6", "part2"]), "3640\n")
  }

  func test2020Day7() throws {
  }

  func test2020Day8() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day8", "part1"]), "1317\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day8", "part2"]), "1033\n")
  }

  func test2020Day9() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["2020", "day9", "part1"]), "1930745883\n")
  }

  // MARK: Helpers

  private func runAdventCommand(arguments: [String]? = nil) throws -> String? {
    // Some of the APIs that we use below are available in macOS 10.13 and above.
    guard #available(macOS 10.13, *) else {
      throw XCTSkip("This test case requires macOS 10.13 or higher")
    }

    let fooBinary = productsDirectory.appendingPathComponent(executableName)

    let process = Process()
    process.executableURL = fooBinary
    process.arguments = arguments

    let pipe = Pipe()
    process.standardOutput = pipe

    try process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)

    return output
  }

  /// Returns path to the built products directory.
  private var productsDirectory: URL {
    #if os(macOS)
    for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
      return bundle.bundleURL.deletingLastPathComponent()
    }
    fatalError("couldn't find the products directory")
    #else
    return Bundle.main.bundleURL
    #endif
  }
}
