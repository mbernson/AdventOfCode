import Foundation

public struct Day4 {
  public init() {}

  public func runPart1() {
    let passcodes = passcodesMatchingRequirements(inRange: 124075...580769)
    print("\(passcodes.count) passcodes match the requirements")
  }

  public func passcodesMatchingRequirements(inRange range: ClosedRange<Int>) -> [Int] {
    (0..<1_000_000)
      .filter { range.contains($0) }
      .filter(twoAdjacentDigitsAreTheSame)
      .filter(digitsNeverDecrease)
  }

  func twoAdjacentDigitsAreTheSame(_ number: Int) -> Bool {
    let digits = number.digits
    return digits.enumerated().filter { (index, digit) in
      digits.indices.contains(index + 1) && digits[index + 1] == digit
    }.count > 0
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

extension Int {
  var digits: [Int] {
    var digits: [Int] = []
    var num = self
    repeat {
      digits.append(num % 10)
      num /= 10
    } while num != 0
    return digits.reversed()
  }
}
