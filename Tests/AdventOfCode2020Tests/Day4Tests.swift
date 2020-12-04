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
      try Day4().parseAndValidatePassport(in: validPassport),
      Day4.Passport(
        byr: 1937,
        iyr: 2017,
        eyr: 2020,
        hgt: .init(value: 183, unit: .cm),
        hcl: 16777213,
        ecl: .gry,
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
      try Day4().parseAndValidatePassport(in: validPassportMissingCid),
      Day4.Passport(
        byr: 1931,
        iyr: 2013,
        eyr: 2024,
        hgt: .init(value: 179, unit: .cm),
        hcl: 11409377,
        ecl: .brn,
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
    XCTAssertThrowsError(try Day4().parseAndValidatePassport(in: invalidPassport), "Missing required field 'hgt'")

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
    XCTAssertThrowsError(try Day4().parseAndValidatePassport(in: invalidPassportMissingByr), "Missing required field 'byr'")
  }

  func testMultiplePassportParsing() throws {
    let input = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd\nbyr:1937 iyr:2017 cid:147 hgt:183cm\n\niyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884\nhcl:#cfa07d byr:1929\n\nhcl:#ae17e1 iyr:2013\neyr:2024\necl:brn pid:760753108 byr:1931\nhgt:179cm\n\nhcl:#cfa07d eyr:2025 pid:166559648\niyr:2011 ecl:brn hgt:59in"
    let passports = Day4().parseAndValidatePassports(in: input)
    XCTAssertEqual(passports, [
      Day4.Passport(
        byr: 1937,
        iyr: 2017,
        eyr: 2020,
        hgt: .init(value: 183, unit: .cm),
        hcl: 16777213,
        ecl: .gry,
        pid: "860033327",
        cid: "147"
      ),
      Day4.Passport(
        byr: 1931,
        iyr: 2013,
        eyr: 2024,
        hgt: .init(value: 179, unit: .cm),
        hcl: 11409377,
        ecl: .brn,
        pid: "760753108",
        cid: nil
      )
    ])
  }

  func testHeightParsing() throws {
    XCTAssertEqual(try Day4().parseHeight("179cm"), Day4.Height(value: 179, unit: .cm))
    XCTAssertEqual(try Day4().parseHeight("42in"), Day4.Height(value: 42, unit: .in))
    XCTAssertThrowsError(try Day4().parseHeight("42bar"))
    XCTAssertThrowsError(try Day4().parseHeight("42"))
  }

  func testMultipleValidPassports() throws {
    let input = "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980\nhcl:#623a2f\n\neyr:2029 ecl:blu cid:129 byr:1989\niyr:2014 pid:896056539 hcl:#a97842 hgt:165cm\n\nhcl:#888785\nhgt:164cm byr:2001 iyr:2015 cid:88\npid:545766238 ecl:hzl\neyr:2022\n\niyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719\n"
    let passports = Day4().parseAndValidatePassports(in: input)
    XCTAssertEqual(passports.count, 4)
  }

  func testMultipleInvalidPassports() throws {
    let input = "eyr:1972 cid:100\nhcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926\n\niyr:2019\nhcl:#602927 eyr:1967 hgt:170cm\necl:grn pid:012533040 byr:1946\n\nhcl:dab227 iyr:2012\necl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277\n\nhgt:59cm ecl:zzz\neyr:2038 hcl:74454a iyr:2023\npid:3556412378 byr:2007"
    XCTAssertEqual(Day4().parseAndValidatePassports(in: input), [])
  }
}
