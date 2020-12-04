@testable import AdventOfCode2020
import XCTest

final class Day4Tests: XCTestCase {
  func testValidPassportParsing() throws {
    /// Valid
    let validPassport = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm"

    XCTAssertEqual(
      Day4().parseFields(in: validPassport),
      [
        "byr" : "1937",
        "iyr" : "2017",
        "eyr" : "2020",
        "hgt" : "183cm",
        "hcl" : "#fffffd",
        "ecl" : "gry",
        "pid" : "860033327",
        "cid" : "147",
      ]
    )
    XCTAssertEqual(
      try Day4().parsePassport(in: validPassport),
      Day4.Passport(
        byr: "1937",
        iyr: "2017",
        eyr: "2020",
        hgt: "183cm",
        hcl: "#fffffd",
        ecl: "gry",
        pid: "860033327",
        cid: "147"
      )
    )

    /// missing optional cid fields
    let validPassportMissingCid = "hcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm"

    XCTAssertEqual(
      Day4().parseFields(in: validPassportMissingCid),
      [
        "byr" : "1931",
        "iyr" : "2013",
        "eyr" : "2024",
        "hgt" : "179cm",
        "hcl" : "#ae17e1",
        "ecl" : "brn",
        "pid" : "760753108",
      ]
    )
    XCTAssertEqual(
      try Day4().parsePassport(in: validPassportMissingCid),
      Day4.Passport(
        byr: "1931",
        iyr: "2013",
        eyr: "2024",
        hgt: "179cm",
        hcl: "#ae17e1",
        ecl: "brn",
        pid: "760753108",
        cid: nil
      )
    )
  }

  func testInvalidPassportParsing() throws {
    /// missing hgt (the Height field)
    let invalidPassport = "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929"

    XCTAssertEqual(
      Day4().parseFields(in: invalidPassport),
      [
        "byr" : "1929",
        "iyr" : "2013",
        "eyr" : "2023",
        "hcl" : "#cfa07d",
        "ecl" : "amb",
        "pid" : "028048884",
        "cid" : "350",
      ]
    )
    XCTAssertThrowsError(try Day4().parsePassport(in: invalidPassport), "Missing required field 'hgt'")

    /// missing byr (birth year field)
    let invalidPassportMissingByr = "hcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in"

    XCTAssertEqual(
      Day4().parseFields(in: invalidPassportMissingByr),
      [
        "iyr" : "2011",
        "eyr" : "2025",
        "hgt" : "59in",
        "hcl" : "#cfa07d",
        "ecl" : "brn",
        "pid" : "166559648",
      ]
    )
    XCTAssertThrowsError(try Day4().parsePassport(in: invalidPassportMissingByr), "Missing required field 'byr'")
  }

  func testMultiplePassportParsing() throws {
    let input = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm\n\niyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929\n\nhcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm\n\nhcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in"
    let passports = Day4().parsePassports(in: input)
    XCTAssertEqual(passports, [
      Day4.Passport(byr: "1937", iyr: "2017", eyr: "2020", hgt: "183cm", hcl: "#fffffd", ecl: "gry", pid: "860033327", cid: "147"),
      Day4.Passport(byr: "1931", iyr: "2013", eyr: "2024", hgt: "179cm", hcl: "#ae17e1", ecl: "brn", pid: "760753108", cid: nil),
    ])
  }
}
