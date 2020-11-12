import XCTest
@testable import AdventOfCode2019

final class IntcodeTestsDay2: XCTestCase {
  func testAdd() throws {
    XCTAssertEqual(
      try IntcodeMachine(program: [1,0,0,0,99]).execute(),
      [2,0,0,0,99]
    )
  }

  func testMultiply() throws {
    XCTAssertEqual(
      try IntcodeMachine(program: [2,3,0,3,99]).execute(),
      [2,3,0,6,99]
    )
    XCTAssertEqual(
      try IntcodeMachine(program: [2,4,4,5,99,0]).execute(),
      [2,4,4,5,99,9801]
    )
  }

  func testAddAndMultiply() throws {
    XCTAssertEqual(
      try IntcodeMachine(program: [1,1,1,4,99,5,6,0,99]).execute(),
      [30,1,1,4,2,5,6,0,99]
    )
  }
}
