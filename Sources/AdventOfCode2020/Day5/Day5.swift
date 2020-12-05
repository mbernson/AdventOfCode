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
    let input: [BinaryHalf] = seats.compactMap { seat in
      switch seat {
      // F means to take the lower half
      case .front: return .lower
      // B means to take the upper half
      case .back: return .upper
      default: return nil
      }
    }
    assert(input.count == 7)
    return calculate(input: input, min: 0, max: 127)
  }

  func calculateColumn(seats: [Seat]) -> Int {
    let input: [BinaryHalf] = seats.compactMap { seat in
      switch seat {
      // L means to take the lower half
      case .left: return .lower
      // R means to take the upper half
      case .right: return .upper
      default: return nil
      }
    }
    assert(input.count == 3)
    return calculate(input: input, min: 0, max: 7)
  }

  private func calculate(input: [BinaryHalf], min _min: Int, max _max: Int) -> Int {
    var range = _min..._max

    for current in input {
      switch current {
      case .upper:
        range = upperHalf(range: range)
      case .lower:
        range = lowerHalf(range: range)
      }
    }

    return input.last! == .upper ? range.upperBound : range.lowerBound
  }

  func lowerHalf(range: ClosedRange<Int>) -> ClosedRange<Int> {
    let newUpper = (range.upperBound + range.lowerBound) / 2
    return range.lowerBound...newUpper
  }

  func upperHalf(range: ClosedRange<Int>) -> ClosedRange<Int> {
    let newLower = (range.upperBound + range.lowerBound + 1) / 2
    return newLower...range.upperBound
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
