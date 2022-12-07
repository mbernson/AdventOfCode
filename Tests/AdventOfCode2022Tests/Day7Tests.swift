import XCTest
@testable import AdventOfCode2022

final class Day7Tests: XCTestCase {
    let exampleInput: [String] = [
        "$ cd /",
        "$ ls",
        "dir a",
        "14848514 b.txt",
        "8504156 c.dat",
        "dir d",
        "$ cd a",
        "$ ls",
        "dir e",
        "29116 f",
        "2557 g",
        "62596 h.lst",
        "$ cd e",
        "$ ls",
        "584 i",
        "$ cd ..",
        "$ cd ..",
        "$ cd d",
        "$ ls",
        "4060174 j",
        "8033020 d.log",
        "5626152 d.ext",
        "7214296 k",
    ]

    func testParsing() throws {
        let day7 = Day7()
        let root = day7.createDirectoryStructure(from: exampleInput)

        XCTAssertNotNil(root.directories["a"])
        XCTAssertNotNil(root.directories["a"]?.directories["e"])
        XCTAssertNotNil(root.directories["d"])

        XCTAssertNil(root.parent)
        XCTAssertEqual(root.directories["d"]?.parent, root)

        XCTAssertEqual(root.directories["a"]?.files["f"]?.size, 29116)
        XCTAssertEqual(root.directories["a"]?.files["g"]?.size, 2557)
        XCTAssertEqual(root.directories["a"]?.files["h.lst"]?.size, 62596)

        XCTAssertNotNil(root.files["b.txt"])
        XCTAssertNotNil(root.files["c.dat"])

        XCTAssertEqual(root.files["b.txt"]?.size, 14848514)
        XCTAssertEqual(root.files["c.dat"]?.size, 8504156)

        XCTAssertEqual(root.directories["a"]?.directories["e"]?.files["i"]?.size, 584)

        XCTAssertEqual(root.directories["d"]?.files["j"]?.size, 4060174)
        XCTAssertEqual(root.directories["d"]?.files["d.log"]?.size, 8033020)
        XCTAssertEqual(root.directories["d"]?.files["d.ext"]?.size, 5626152)
        XCTAssertEqual(root.directories["d"]?.files["k"]?.size, 7214296)
    }

    func testCalculatingSizes() throws {
        let day7 = Day7()
        let root = day7.createDirectoryStructure(from: exampleInput)
        let calculator = Day7.SizeCalculator()

        let a = root.directories["a"]!
        let e = a.directories["e"]!
        XCTAssertEqual(calculator.calculateTotalSize(of: e), 584)
        XCTAssertEqual(calculator.calculateTotalSize(of: a), 94853)

        let d = root.directories["d"]!
        XCTAssertEqual(calculator.calculateTotalSize(of: d), 24933642)

        XCTAssertEqual(calculator.calculateTotalSize(of: root), 48381165)
    }

    func testSolutionPart1() throws {
        let day7 = Day7()
        let root = day7.createDirectoryStructure(from: exampleInput)
        let directories = day7.flatten(directory: root)
        XCTAssertEqual(directories.count, 4)

        let calculator = Day7.SizeCalculator()
        let sizes = directories.map(calculator.calculateTotalSize)
        print(sizes)
        XCTAssertEqual(sizes.filter({ $0 < day7.limitPart1 }).reduce(0, +), 95437)
    }
}
