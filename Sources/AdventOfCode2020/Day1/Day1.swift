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

    if let answer = findTwoMultiples(addingUpTo: 2020, in: input) {
      assert(answer.count == 2)
      return answer[0] * answer[1]
    } else {
      fatalError("Solution not found")
    }
  }

  public func runPart2() throws -> Int {
    let inputString = try String(contentsOf: inputURL)
    let input: [Int] = inputString
      .components(separatedBy: "\n")
      .compactMap(Int.init)

    if let answer = findThreeMultiples(addingUpTo: 2020, in: input) {
      assert(answer.count == 3)
      return answer[0] * answer[1] * answer[2]
    } else {
      fatalError("Solution not found")
    }
  }

  func findTwoMultiples(addingUpTo total: Int, in input: [Int]) -> [Int]? {
    for i in input {
      for j in input {
        if i + j == total {
          return [i, j]
        }
      }
    }
    return nil
  }

  func findThreeMultiples(addingUpTo total: Int, in input: [Int]) -> [Int]? {
    for i in input {
      for j in input {
        for k in input {
          if i + j + k == total {
            return [i, j, k]
          }
        }
      }
    }
    return nil
  }
}
