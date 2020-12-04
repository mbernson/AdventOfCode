import Foundation

public struct Day4 {
  public let inputURL = Bundle.module.url(forResource: "day4", withExtension: "txt")!

  public init() {}

  public func runPart1() throws -> Int {
    let validPassports = parsePassports(in: try String(contentsOf: inputURL))
    return validPassports.count
  }
  
  func parsePassports(in input: String) -> [Passport] {
    return input
      .components(separatedBy: "\n\n")
      .compactMap { line in
        do {
          return try parsePassport(in: line)
        } catch {
          return nil
        }
      }
  }

  enum PassportParsingError: Error, LocalizedError {
    case missingField(name: String)

    var errorDescription: String? {
      switch self {
      case let .missingField(name): return "Missing required field '\(name)'"
      }
    }
  }

  func parsePassport(in input: String) throws -> Passport {
    let fields = parseFields(in: input)
    guard let byr = fields["byr"] else { throw PassportParsingError.missingField(name: "byr") }
    guard let iyr = fields["iyr"] else { throw PassportParsingError.missingField(name: "iyr") }
    guard let eyr = fields["eyr"] else { throw PassportParsingError.missingField(name: "eyr") }
    guard let hgt = fields["hgt"] else { throw PassportParsingError.missingField(name: "hgt") }
    guard let hcl = fields["hcl"] else { throw PassportParsingError.missingField(name: "hcl") }
    guard let ecl = fields["ecl"] else { throw PassportParsingError.missingField(name: "ecl") }
    guard let pid = fields["pid"] else { throw PassportParsingError.missingField(name: "pid") }
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

  struct Passport: Equatable {
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
}
