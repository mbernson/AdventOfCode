import XCTest
@testable import Intcode


final class InstructionParsingTests: XCTestCase {

  func testPositionMode() throws {
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(1).opCode, .add)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(1).parameterModes, [.position, .position, .position])
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(2).opCode, .multiply)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(2).parameterModes, [.position, .position, .position])
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(3).opCode, .input)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(3).parameterModes, [.position, .position, .position])
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(4).opCode, .output)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(4).parameterModes, [.position, .position, .position])
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(99).opCode, .halt)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(99).parameterModes, [.position, .position, .position])
  }

  func testParamMode1() throws {
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(102).opCode, .multiply)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(102).parameterModes, [.immediate, .position, .position])
  }

  func testParamMode2() throws {
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(1002).opCode, .multiply)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(1002).parameterModes, [.position, .immediate, .position])
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(1102).opCode, .multiply)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(1102).parameterModes, [.immediate, .immediate, .position])
  }

  func testParamMode3() throws {
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(10002).opCode, .multiply)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(10002).parameterModes, [.position, .position, .immediate])
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(10102).opCode, .multiply)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(10102).parameterModes, [.immediate, .position, .immediate])
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(11102).opCode, .multiply)
    XCTAssertEqual(try IntcodeMachine.InstructionParser.parse(11102).parameterModes, [.immediate, .immediate, .immediate])
  }

  /// ABCDE
  ///  1002
  ///
  /// DE - two-digit opcode,      02 == opcode 2
  ///  C - mode of 1st parameter,  0 == position mode
  ///  B - mode of 2nd parameter,  1 == immediate mode
  ///  A - mode of 3rd parameter,  0 == position mode,
  ///                                   omitted due to being a leading zero
  func testExample() throws {
    let instruction = try IntcodeMachine.InstructionParser.parse(1002)
    XCTAssertEqual(instruction.opCode, .multiply)
    XCTAssertEqual(instruction.parameterModes[0], .position)
    XCTAssertEqual(instruction.parameterModes[1], .immediate)
    XCTAssertEqual(instruction.parameterModes[2], .position)
  }
}
