import Foundation

public struct Day5 {
  public let inputURL = Bundle.module.url(forResource: "day5", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    return try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map(calculateSeat(string:))
      .reduce(0, { max, seat in
        seat.seatID > max ? seat.seatID : max
      })
  }

  public func runPart2() throws -> Int {
    let seatNumbers = try String(contentsOf: inputURL)
      .components(separatedBy: "\n")
      .filter { !$0.isEmpty }
      .map(calculateSeat(string:))
      .map(\.seatID)
      .sorted()

    for (index, seatNumber) in seatNumbers.enumerated() {
      let nextIndex = index + 1
      let nextExpectedSeatNumber = seatNumber + 1
      if seatNumbers.indices.contains(nextIndex), seatNumbers[nextIndex] != nextExpectedSeatNumber {
        return nextExpectedSeatNumber
      }
    }

    throw Day5Error.noAnswerFound
  }

  enum Day5Error: Error {
    case noAnswerFound
  }

  struct CalculatedSeat: Equatable {
    let row: Int
    let column: Int
    let seatID: Int
  }

  func calculateSeat(string: String) -> CalculatedSeat {
    let seats: [Seat] = string.map(String.init)
      .compactMap(Day5.Seat.init(rawValue:))
    return calculateSeat(seats: seats)
  }

  func calculateSeat(seats: [Seat]) -> CalculatedSeat {
    let row = calculateRow(seats: seats)
    let column = calculateColumn(seats: seats)
    let seatID = row * 8 + column
    return CalculatedSeat(row: row, column: column, seatID: seatID)
  }

  func calculateRow(seats: [Seat]) -> Int {
    return binaryPartition(input: seats.compactMap { seat in
      switch seat {
      // F means to take the lower half
      case .front: return .lower
      // B means to take the upper half
      case .back: return .upper
      default: return nil
      }
    })
  }

  func calculateColumn(seats: [Seat]) -> Int {
    return binaryPartition(input: seats.compactMap { seat in
      switch seat {
      // L means to take the lower half
      case .left: return .lower
      // R means to take the upper half
      case .right: return .upper
      default: return nil
      }
    })
  }

  private func binaryPartition(input: [BinaryHalf]) -> Int {
    let max: Int = Int(pow(2, Double(input.count))) - 1 // Why does it have to be like this, Swift
    var range = 0...max

    for current in input {
      switch current {
      case .upper:
        let newLowerBound = (range.upperBound + range.lowerBound + 1) / 2
        range = newLowerBound...range.upperBound
      case .lower:
        let newUpperBound = (range.upperBound + range.lowerBound) / 2
        range = range.lowerBound...newUpperBound
      }
    }

    return input.last! == .upper ? range.upperBound : range.lowerBound
  }

  enum Seat: String {
    case front = "F"
    case back = "B"
    case left = "L"
    case right = "R"
  }

  enum BinaryHalf {
    case upper, lower
  }
}
