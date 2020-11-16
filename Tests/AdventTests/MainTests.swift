import Foundation
import XCTest

class MainTests: XCTestCase {
  let executableName = "advent"

  func testUnknownSubCommand() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["foobar"]), "Unrecognized subcommand 'foobar'\n")
  }

  func testDay1() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day1-part1"]), "3308377\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day1-part2"]), "4959709\n")
  }

  func testDay2() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day2-part1"]), "3765464\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day2-part2"]), "7610\n")
  }

  func testDay3() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day3-part1"]), "Intersection distance: 8015\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day3-part2"]), "Lowest costing intersection: 163676 steps\n")
  }

  func testDay4() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day4-part1"]), "2150 passcodes match the requirements\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day4-part2"]), "1462 passcodes match the requirements\n")
  }

  func testDay5() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day5-part1"]), "Output: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 0\nOutput: 14155342\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day5-part2"]), "Output: 8684145\n")
  }

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
