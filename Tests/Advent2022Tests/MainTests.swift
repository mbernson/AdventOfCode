import XCTest
import class Foundation.Bundle

final class MainTests: XCTestCase {

  func test2022Day1() throws {
    XCTAssertEqual(try runAdventCommand(arguments: ["day1", "part1"]), "68775\n")
    // XCTAssertEqual(try runAdventCommand(arguments: ["day1", "part2"]), "0\n")
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

    let executable = productsDirectory.appendingPathComponent("advent2022")

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
