import Foundation

public struct Day4 {
  public let inputURL = Bundle.module.url(forResource: "day4", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let validPassports = parseRawPassports(in: try String(contentsOf: inputURL))
    return validPassports.count
  }

  public func runPart2() throws -> Int {
    let validPassports = parseAndValidatePassports(in: try String(contentsOf: inputURL))
    return validPassports.count
  }

  func parseRawPassports(in input: String) -> [RawPassport] {
    return input
      .components(separatedBy: "\n\n")
      .compactMap { line in
        try? parseRawPassport(in: line)
      }
  }
  
  func parseAndValidatePassports(in input: String) -> [Passport] {
    return input
      .components(separatedBy: "\n\n")
      .compactMap { line in
        try? parseAndValidatePassport(in: line)
      }
  }

  func parseRawPassport(in input: String) throws -> RawPassport {
    let fields = parseFields(in: input)
    guard let byr = fields["byr"] else { throw PassportParsingError.missingField(name: "byr") }
    guard let iyr = fields["iyr"] else { throw PassportParsingError.missingField(name: "iyr") }
    guard let eyr = fields["eyr"] else { throw PassportParsingError.missingField(name: "eyr") }
    guard let hgt = fields["hgt"] else { throw PassportParsingError.missingField(name: "hgt") }
    guard let hcl = fields["hcl"] else { throw PassportParsingError.missingField(name: "hcl") }
    guard let ecl = fields["ecl"] else { throw PassportParsingError.missingField(name: "ecl") }
    guard let pid = fields["pid"] else { throw PassportParsingError.missingField(name: "pid") }
    let cid = fields["cid"]
    return RawPassport(
      byr: byr,
      iyr: iyr,
      eyr: eyr,
      hgt: hgt,
      hcl: hcl,
      ecl: ecl,
      pid: pid,
      cid: cid
    )
  }

  private let validPassportNumberDigits = Set(0...9)
  private let validByrYearRange = 1920...2002
  private let validIyrearRange = 2010...2020
  private let validEyrYearRange = 2020...2030

  func parseAndValidatePassport(in input: String) throws -> Passport {
    let fields = parseFields(in: input)
    guard let _byr = fields["byr"] else { throw PassportParsingError.missingField(name: "byr") }
    guard let _iyr = fields["iyr"] else { throw PassportParsingError.missingField(name: "iyr") }
    guard let _eyr = fields["eyr"] else { throw PassportParsingError.missingField(name: "eyr") }
    guard let _hgt = fields["hgt"] else { throw PassportParsingError.missingField(name: "hgt") }
    guard var _hcl = fields["hcl"] else { throw PassportParsingError.missingField(name: "hcl") }
    guard let _ecl = fields["ecl"] else { throw PassportParsingError.missingField(name: "ecl") }
    guard let pid = fields["pid"] else { throw PassportParsingError.missingField(name: "pid") }

    // Validate birth/issued/expiry years
    guard let byr = Int(_byr), validByrYearRange.contains(byr) else { throw PassportParsingError.invalidBirthYear }
    guard let iyr = Int(_iyr), validIyrearRange.contains(iyr) else { throw PassportParsingError.invalidIssuedYear }
    guard let eyr = Int(_eyr), validEyrYearRange.contains(eyr) else { throw PassportParsingError.invalidExpiryYear }

    // Validate height
    let hgt = try parseHeight(_hgt)
    switch hgt.unit {
    case .cm:
      guard (150...193).contains(hgt.value) else { throw PassportParsingError.invalidHeight }
    case .in:
      guard (59...76).contains(hgt.value) else { throw PassportParsingError.invalidHeight }
    }

    // Validate hair color
    guard _hcl.starts(with: "#") else { throw PassportParsingError.invalidHaircolor }
    _hcl.removeFirst()
    guard let hcl = Int(_hcl, radix: 16) else { throw PassportParsingError.invalidHaircolor }

    // Validate eye color
    guard let ecl = EyeColor(rawValue: _ecl) else { throw PassportParsingError.invalidEyeColor(color: _ecl) }

    // Validate passport number
    let passportNumberDigits: [Int] = pid.map(String.init).compactMap(Int.init)
    guard passportNumberDigits.count == 9,
          passportNumberDigits.filter({ validPassportNumberDigits.contains($0) }).count == 9
    else { throw PassportParsingError.invalidPassportNumber }

    let cid = fields["cid"]
    return Passport(
      byr: byr,
      iyr: iyr,
      eyr: eyr,
      hgt: hgt,
      hcl: hcl,
      ecl: ecl,
      pid: pid,
      cid: cid
    )
  }

  func parseFields(in input: String) -> [String : String] {
    var fields: [String : String] = [:]
    input.replacingOccurrences(of: "\n", with: " ")
      .split(separator: " ")
      .map(String.init)
      .map { string -> [String] in string.split(separator: ":").map(String.init) }
      .forEach { array -> Void in
        if array.count == 2 {
          fields[array[0]] = array[1]
        }
      }
    return fields
  }

  func parseHeight(_ string: String) throws -> Height {
    let range = NSRange(location: 0, length: string.utf16.count)
    let regex = try NSRegularExpression(pattern: "(\\d+)(\\w+)", options: .caseInsensitive)
    guard let match = regex.firstMatch(in: string, options: [], range: range),
          let intValueRange = Range(match.range(at: 1), in: string), // 0 is the complete match
          let unitRange = Range(match.range(at: 2), in: string)
      else { throw PassportParsingError.invalidHeight }
    let intValueMatch = String(string[intValueRange])
    let unitMatch = String(string[unitRange])
    guard let heightValue = Int(intValueMatch), heightValue > 0 else { throw PassportParsingError.invalidHeight }
    guard let unitValue = Height.Unit(rawValue: unitMatch) else { throw PassportParsingError.invalidHeight }
    return Height(value: heightValue, unit: unitValue)
  }

  /// Basic passport type without input validation
  struct RawPassport: Equatable {
    /// Birth Year
    let byr: String
    /// Issue Year
    let iyr: String
    /// Expiration Year
    let eyr: String
    /// Height
    let hgt: String
    /// Hair Color
    let hcl: String
    /// Eye Color
    let ecl: String
    /// Passport ID
    let pid: String
    /// Country ID (optional)
    let cid: String?
  }

  /// Fully validated passport type
  struct Passport: Equatable {
    /// Birth Year
    let byr: Int
    /// Issue Year
    let iyr: Int
    /// Expiration Year
    let eyr: Int
    /// Height
    let hgt: Height
    /// Hair Color
    let hcl: Int
    /// Eye Color
    let ecl: EyeColor
    /// Passport ID
    let pid: String
    /// Country ID (optional)
    let cid: String?
  }

  enum EyeColor: String {
    case amb, blu, brn, gry, grn, hzl, oth
  }

  struct Height: Equatable {
    let value: Int
    let unit: Unit

    enum Unit: String {
      case cm, `in`
    }
  }

  enum PassportParsingError: Error, LocalizedError {
    case missingField(name: String)
    case invalidEyeColor(color: String)
    case invalidBirthYear
    case invalidIssuedYear
    case invalidExpiryYear
    case invalidHeight
    case invalidHaircolor
    case invalidPassportNumber

    var errorDescription: String? {
      switch self {
      case let .missingField(name): return "Missing required field '\(name)'"
      case let .invalidEyeColor(color): return "Invalid eye color value '\(color)'"
      case .invalidBirthYear: return "Invalid birth year"
      case .invalidIssuedYear: return "Invalid issued year"
      case .invalidExpiryYear: return "Invalid expiry year"
      case .invalidHeight: return "Invalid height value"
      case .invalidHaircolor: return "Invalid hair color"
      case .invalidPassportNumber: return "Invalid passport number"
      }
    }
  }
}
