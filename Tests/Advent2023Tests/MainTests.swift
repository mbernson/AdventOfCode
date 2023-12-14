import XCTest
import class Foundation.Bundle

final class MainTests: XCTestCase {
    let command = "advent2023"

    func test2023Day1() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day1", "part1"]), "55538\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day1", "part2"]), "54875\n")
    }

    func test2023Day2() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day2", "part1"]), "2795\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day2", "part2"]), "75561\n")
    }

    func test2023Day3() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day3", "part1"]), "544664\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day3", "part2"]), "84495585\n")
    }
    
    func test2023Day4() throws {
        XCTAssertEqual(try runAdventCommand(arguments: ["day4", "part1"]), "23028\n")
        XCTAssertEqual(try runAdventCommand(arguments: ["day4", "part2"]), "0\n")
    }

    // MARK: Helpers

    private func runAdventCommand(arguments: [String]?) throws -> String? {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.

        let executable = productsDirectory.appendingPathComponent(command)

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
