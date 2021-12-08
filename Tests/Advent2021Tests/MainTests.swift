import XCTest
import class Foundation.Bundle

final class MainTests: XCTestCase {

  func test2021Day1() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day1", "part1"]), "1228\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day1", "part2"]), "1257\n")
  }

  func test2021Day2() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day2", "part1"]), "1938402\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day2", "part2"]), "1947878632\n")
  }

  func test2021Day3() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day3", "part1"]), "3923414\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day3", "part2"]), "5852595\n")
  }

  func test2021Day4() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day4", "part1"]), "2496\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day4", "part2"]), "25925\n")
  }

  func test2021Day5() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day5", "part1"]), "7468\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day5", "part2"]), "22364\n")
  }

  func test2021Day6() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day6", "part1"]), "390923\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day6", "part2"]), "1749945484935\n")
  }

  func test2021Day7() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day7", "part1"]), "354129\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day7", "part2"]), "0\n")
  }

  // MARK: Helpers

  private func runAdventCommand(arguments: [String]?) throws -> String? {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct
    // results.

    // Some of the APIs that we use below are available in macOS 10.13 and above.
    guard #available(macOS 10.13, *) else {
      XCTFail("Unsupported macOS version")
    }

    let executable = productsDirectory.appendingPathComponent("advent2021")

    let process = Process()
    process.executableURL = executable
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
  var productsDirectory: URL {
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
