import Foundation
import Intcode

public struct Day6 {
  public let inputURL = Bundle.module.url(forResource: "day6", withExtension: "txt")!

  public init() {}

  public func runPart1() throws {
    let string = try String(contentsOf: inputURL)
    let definitions: [OrbitDefinition] = parseDefinitions(from: string)
  }

  public func runPart2() throws {
  }

  func parseDefinitions(from string: String) -> [OrbitDefinition] {
    string
      .components(separatedBy: "\n")
      .compactMap { line -> OrbitDefinition? in
        let parts = line.split(separator: ")")
        guard parts.count == 2 else { return nil }
        return OrbitDefinition(parent: String(parts[0]), child: String(parts[1]))
      }
  }

  func buildTree(from definitions: [OrbitDefinition]) -> Body {
    let root = Body(id: "COM")
    for def in definitions {
      let child = Body(id: def.child)
      let parentId = def.parent
      root.deepAppend(child: child, to: parentId)
    }
    return root
  }

  func countDirectOrbits(of body: Body) -> Int {
    body.deepChildrenCount
  }

  struct OrbitDefinition: Equatable {
    let parent: String
    let child: String
  }

  class Body: Equatable {
    let id: String
    var children: [Body]

    var deepChildrenCount: Int {
      return children.count + children.map(\.deepChildrenCount).reduce(0, +)
    }

    init(id: String, children: [Day6.Body] = []) {
      self.id = id
      self.children = children
    }

    func deepAppend(child: Body, to parentId: String) {
      if parentId == id {
        self.children.append(child)
      } else {
        self.children.forEach {
          $0.deepAppend(child: child, to: parentId)
        }
      }
    }

    static func == (lhs: Day6.Body, rhs: Day6.Body) -> Bool {
      return lhs.id == rhs.id && lhs.children == rhs.children
    }
  }
}
