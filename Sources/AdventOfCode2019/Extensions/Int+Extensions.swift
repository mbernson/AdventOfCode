import Foundation

extension Int {
  /// Returns an array of the digits of the integer.
  ///
  /// Example:
  ///
  ///     print(12345.digits)
  ///     // Prints "[1, 2, 3, 4, 5]"
  ///
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
