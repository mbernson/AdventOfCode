import Foundation

public struct Day4 {
  let inputRange = 124075...580769

  public init() {}

  public func runPart1() {
    let passcodes = inputRange
      .filter(twoAdjacentDigitsAreTheSame)
      .filter(digitsNeverDecrease)
    print("\(passcodes.count) passcodes match the requirements")
  }

  public func runPart2() {
    let passcodes = inputRange
      .filter(digitsNeverDecrease)
      .filter(containsGroupOfTwoMatchingDigits)
    print("\(passcodes.count) passcodes match the requirements")
  }

  func twoAdjacentDigitsAreTheSame(_ number: Int) -> Bool {
    let digits = number.digits
    return digits.enumerated().contains { (index, digit) in
      digits.indices.contains(index + 1) && digits[index + 1] == digit
    }
  }

  func containsGroupOfTwoMatchingDigits(_ number: Int) -> Bool {
    let digitGroups = adjacentNumbersGrouped(number.digits)
    return digitGroups.contains { $0.count == 2 }
  }

  func adjacentNumbersGrouped(_ digits: [Int]) -> [[Int]] {
    digits.reduce([[Int]]()) { _groups, digit in
      var groups = _groups
      if !groups.isEmpty, let lastGroup = groups.last, lastGroup.contains(digit) {
        groups[groups.endIndex - 1].append(digit)
      } else {
        groups.append([digit])
      }
      return groups
    }.filter { $0.count > 1 }
  }

  func digitsNeverDecrease(_ number: Int) -> Bool {
    let digits = number.digits
    return digits.enumerated().allSatisfy { (index, digit) in
      if digits.indices.contains(index + 1) {
        let next = digits[index + 1]
        return digit <= next
      } else {
        return true
      }
    }
  }
}
