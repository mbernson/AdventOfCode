//
//  File.swift
//  
//
//  Created by Mathijs on 11/11/2020.
//

import Foundation

public struct Day1 {
  public let inputURL = Bundle.module.url(forResource: "day1", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Int] = inputString
      .components(separatedBy: "\n")
      .compactMap(Int.init)

    if let answer = findMultiples(addingUpTo: 2020, in: input) {
      assert(answer.count == 2)
      return answer[0] * answer[1]
    } else {
      fatalError("Solution not found")
    }
  }

  func findMultiples(addingUpTo total: Int, in input: [Int]) -> [Int]? {
    for i in input {
      for j in input {
        if i + j == total {
          return [i, j]
        }
      }
    }
    return nil
  }
}
