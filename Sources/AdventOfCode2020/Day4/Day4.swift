import Foundation

public struct Day4 {
  public let inputURL = Bundle.module.url(forResource: "day4", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let validPassports = parseRawPassports(in: try String(contentsOf: inputURL))
    return validPassports.count
  }

  public func runPart2() throws -> Int {
    let validPassports = parsePassports(in: try String(contentsOf: inputURL))
    return validPassports.count
  }

  func parseRawPassports(in input: String) -> [RawPassport] {
    return input
      .components(separatedBy: "\n\n")
      .compactMap { line in
        try? parseRawPassport(in: line)
      }
  }

  func parseRawPassport(in input: String) throws -> RawPassport {
    let fields = parsePassportFields(in: input)
    guard let byr = fields["byr"] else { throw PassportParsingError.missingField(name: "byr") }
    guard let iyr = fields["iyr"] else { throw PassportParsingError.missingField(name: "iyr") }
    guard let eyr = fields["eyr"] else { throw PassportParsingError.missingField(name: "eyr") }
    guard let hgt = fields["hgt"] else { throw PassportParsingError.missingField(name: "hgt") }
    guard let hcl = fields["hcl"] else { throw PassportParsingError.missingField(name: "hcl") }
    guard let ecl = fields["ecl"] else { throw PassportParsingError.missingField(name: "ecl") }
    guard let pid = fields["pid"] else { throw PassportParsingError.missingField(name: "pid") }
    let cid = fields["cid"]
    return RawPassport(byr: byr, iyr: iyr, eyr: eyr, hgt: hgt, hcl: hcl, ecl: ecl, pid: pid, cid: cid)
  }


  func parsePassports(in input: String) -> [Passport] {
    return input
      .components(separatedBy: "\n\n")
      .compactMap { line in
        try? parsePassport(in: line)
      }
  }

  private let validPassportNumberDigits = Set(0...9)
  private let validBirthYearRange = 1920...2002
  private let validIssueYearRange = 2010...2020
  private let validExpirationYearRange = 2020...2030
  private let validLengthCentimeterRange = 150...193
  private let validLengthInchRange = 59...76

  /// Parse a single passport into a fully validated Passport object, or throw an error
  func parsePassport(in input: String) throws -> Passport {
    let fields = parsePassportFields(in: input)
    guard let byr = fields["byr"] else { throw PassportParsingError.missingField(name: "byr") }
    guard let iyr = fields["iyr"] else { throw PassportParsingError.missingField(name: "iyr") }
    guard let eyr = fields["eyr"] else { throw PassportParsingError.missingField(name: "eyr") }
    guard let hgt = fields["hgt"] else { throw PassportParsingError.missingField(name: "hgt") }
    guard var hcl = fields["hcl"] else { throw PassportParsingError.missingField(name: "hcl") }
    guard let ecl = fields["ecl"] else { throw PassportParsingError.missingField(name: "ecl") }
    guard let passportId = fields["pid"] else { throw PassportParsingError.missingField(name: "pid") }

    // Validate birth/issued/expiry years
    guard let birthYear = Int(byr), validBirthYearRange.contains(birthYear) else { throw PassportParsingError.invalidBirthYear }
    guard let issueYear = Int(iyr), validIssueYearRange.contains(issueYear) else { throw PassportParsingError.invalidIssuedYear }
    guard let expirationYear = Int(eyr), validExpirationYearRange.contains(expirationYear) else { throw PassportParsingError.invalidExpiryYear }

    // Validate height
    let height = try parseHeight(hgt)
    switch height.unit {
    case .cm:
      guard validLengthCentimeterRange.contains(height.value)
        else { throw PassportParsingError.invalidHeight }
    case .in:
      guard validLengthInchRange.contains(height.value)
        else { throw PassportParsingError.invalidHeight }
    }

    // Validate hair color
    guard hcl.starts(with: "#") else { throw PassportParsingError.invalidHaircolor }
    hcl.removeFirst()
    guard let hairColor = Int(hcl, radix: 16) else { throw PassportParsingError.invalidHaircolor }

    // Validate eye color
    guard let eyeColor = EyeColor(rawValue: ecl) else { throw PassportParsingError.invalidEyeColor(color: ecl) }

    // Validate passport number
    let passportIdDigits: [Int] = passportId.map(String.init).compactMap(Int.init)
    guard passportIdDigits.count == 9,
          passportIdDigits.filter({ validPassportNumberDigits.contains($0) }).count == 9
      else { throw PassportParsingError.invalidPassportNumber }

    let countryId = fields["cid"]

    return Passport(
      birthYear: birthYear,
      issueYear: issueYear,
      expirationYear: expirationYear,
      height: height,
      hairColor: hairColor,
      eyeColor: eyeColor,
      passportId: passportId,
      countryId: countryId
    )
  }

  /// Parse the fields from single passport into a dictionary
  func parsePassportFields(in input: String) -> [String : String] {
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

  /// Parse the height value from a passport into a properly validated structure
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
    let birthYear: Int
    let issueYear: Int
    let expirationYear: Int
    let height: Height
    let hairColor: Int
    let eyeColor: EyeColor
    let passportId: String
    let countryId: String?
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
