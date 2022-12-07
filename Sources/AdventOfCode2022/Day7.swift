import Foundation

public struct Day7 {
    public let inputURL = Bundle.module.url(forResource: "Input/day7", withExtension: "txt")!

    public init() {}

    class Directory: Hashable, Equatable {
        private(set) var files: [String: File]
        private(set) var directories: [String : Directory]
        private(set) weak var parent: Directory?

        init(files: [String : Day7.File] = [:], directories: [String : Day7.Directory] = [:]) {
            self.files = files
            self.directories = directories
        }

        func addChild(_ directory: Directory, named name: String) {
            guard directories[name] == nil else { fatalError() }
            directories[name] = directory
            directory.parent = self
        }

        func addChild(_ file: File, named name: String) {
            guard files[name] == nil else { fatalError() }
            files[name] = file
        }

        static func == (lhs: Day7.Directory, rhs: Day7.Directory) -> Bool {
            lhs.directories == rhs.directories && lhs.files == rhs.files && lhs.parent == rhs.parent
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(files.hashValue)
            hasher.combine(directories.hashValue)
        }
    }

    struct File: Hashable, Equatable {
        let size: Int
    }

    func createDirectoryStructure(from lines: [String]) -> Directory {
        let root = Directory(files: [:], directories: [:])
        var currentDirectory = root
        var lineNumber = 1

        let fileRegex = #/^(\d+) (.+)$/#

        for line in lines {
            if line.starts(with: "$ ") {
                // Handle command
                let parts = line.split(separator: " ")
                let command = parts[1]
                switch command {
                case "ls":
                    break
                case "cd":
                    let targetName = String(parts[2])
                    if targetName == ".." {
                        // Move up a directory
                        currentDirectory = currentDirectory.parent!
                    } else if targetName == "/" {
                        // Move to root node
                        currentDirectory = root
                    } else {
                        // Move into directory
                        if let targetDir = currentDirectory.directories[targetName] {
                            currentDirectory = targetDir
                        } else {
                            // Create it
                            let targetDir = Directory()
                            currentDirectory.addChild(targetDir, named: targetName)
                            currentDirectory = targetDir
                        }
                    }
                default:
                    fatalError("Unrecognized command: \(command)")
                }
            } else if line.starts(with: "dir") {

            } else if let match = line.wholeMatch(of: fileRegex) {
                let (_, sizeString, fileName) = match.output
                let size = Int(sizeString)!
                let newFile = File(size: size)
                currentDirectory.addChild(newFile, named: String(fileName))
            } else if line.isEmpty {
                // Ignore
            } else {
                fatalError("Don't know what to do with line \(lineNumber): \(line)")
            }
            lineNumber += 1
        }

        return root
    }

    class SizeCalculator {
        private var sizeCache: [Directory: Int] = [:]

        func calculateTotalSize(of directory: Directory) -> Int {
            if let cachedSize = sizeCache[directory] {
                return cachedSize
            }
            var totalSize: Int = 0
            for (_, file) in directory.files {
                totalSize += file.size
            }
            for (_, directory) in directory.directories {
                totalSize += calculateTotalSize(of: directory)
            }
            sizeCache[directory] = totalSize
            return totalSize
        }
    }

    func flatten(directory: Directory) -> [Directory] {
        var result: [Directory] = [directory]
        for (_, child) in directory.directories {
            result.append(contentsOf: flatten(directory: child))
        }
        return result
    }

    func countDirectories(input: [String]) -> Int {
        input.filter { $0.starts(with: "dir") }
            .count
    }

    let limitPart1: Int = 100_000

    public func runPart1() throws -> Int {
        let lines = try String(contentsOf: inputURL)
            .components(separatedBy: "\n")

        let root = createDirectoryStructure(from: lines)
        let directories = flatten(directory: root)

        let calculator = SizeCalculator()
        let sizes = directories.map(calculator.calculateTotalSize)
        return sizes.filter({ $0 < limitPart1 }).reduce(0, +)
    }

    public func runPart2() throws -> Int {
        return 0
    }
}
