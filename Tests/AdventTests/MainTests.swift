import Foundation
import XCTest

class MainTests: XCTestCase {
  let executableName = "advent"

  func testUnknownSubCommand() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["foobar"]), "Unrecognized subcommand 'foobar'\n")
  }

  func testDay3() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day3-part1"]), "Intersection distance: 8015\n")
    XCTAssertEqual(try runAdventCommand(arguments: ["day3-part2"]), "Lowest costing intersection: 163676 steps\n")
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
