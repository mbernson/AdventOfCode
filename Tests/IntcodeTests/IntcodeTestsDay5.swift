import XCTest
@testable import Intcode

final class IntcodeTestsDay5: XCTestCase {

  func testInputOutput() throws {
    let outputWasProvided = expectation(description: "An output should be generated by the intcode program")
    let machine = IntcodeMachine(program: [3,0,4,0,99], inputProvider: Just([1337]), outputProvider: ClosureOutputProvider { output in
      XCTAssertEqual(output, 1337)
      outputWasProvided.fulfill()
    })

    XCTAssertNoThrow(try machine.execute())

    waitForExpectations(timeout: 1, handler: nil)
  }

  func testImmediateModeParameters() throws {
    let machine = IntcodeMachine(program: [1002,4,3,4,33])
    let memory = try machine.execute()
    XCTAssertEqual(memory[4], 99)
  }

  func testNegativeNumber() throws {
    let machine = IntcodeMachine(program: [1101,100,-1,4,0])
    let memory = try machine.execute()
    XCTAssertEqual(memory[4], 99)
  }

  private func runProgam(program: [Int], input: [Int], expectedOutput: Int) {
    let outputWasProvided = expectation(description: "An output should be generated by the intcode program")
    let machine = IntcodeMachine(program: program, inputProvider: Just(input), outputProvider: ClosureOutputProvider { output in
      XCTAssertEqual(output, expectedOutput)
      outputWasProvided.fulfill()
    })
    XCTAssertNoThrow(try machine.execute())
    waitForExpectations(timeout: 1, handler: nil)
  }

  func testEqualUsingPositionMode() throws {
    runProgam(program: [3,9,8,9,10,9,4,9,99,-1,8], input: [8], expectedOutput: 1)
    runProgam(program: [3,9,8,9,10,9,4,9,99,-1,8], input: [9], expectedOutput: 0)
  }

  func testEqualUsingImmediateMode() throws {
    runProgam(program: [3,3,1108,-1,8,3,4,3,99], input: [8], expectedOutput: 1)
    runProgam(program: [3,3,1108,-1,8,3,4,3,99], input: [9], expectedOutput: 0)
  }

  func testLessThanUsingPositionMode() throws {
    runProgam(program: [3,9,7,9,10,9,4,9,99,-1,8], input: [7], expectedOutput: 1)
    runProgam(program: [3,9,7,9,10,9,4,9,99,-1,8], input: [8], expectedOutput: 0)
    runProgam(program: [3,9,7,9,10,9,4,9,99,-1,8], input: [9], expectedOutput: 0)
  }

  func testLessThanUsingImmediateMode() throws {
    runProgam(program: [3,3,1107,-1,8,3,4,3,99], input: [7], expectedOutput: 1)
    runProgam(program: [3,3,1107,-1,8,3,4,3,99], input: [8], expectedOutput: 0)
    runProgam(program: [3,3,1107,-1,8,3,4,3,99], input: [9], expectedOutput: 0)
  }

  func testJumpsUsingPositionMode() throws {
    runProgam(program: [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], input: [0], expectedOutput: 0)
    runProgam(program: [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], input: [42], expectedOutput: 1)
  }

  func testJumpsUsingImmediateMode() throws {
    runProgam(program: [3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9], input: [0], expectedOutput: 0)
    runProgam(program: [3,3,1105,-1,9,1101,0,0,12,4,12,99,1], input: [42], expectedOutput: 1)
  }

  /// The example program uses an input instruction to ask for a single number. The program will then output 999 if the input value is below 8, output 1000 if the input value is equal to 8, or output 1001 if the input value is greater than 8.
  func testLargerProgram() throws {
    let program: [Int] = [3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,
                          1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,
                          999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99]

    runProgam(program: program, input: [7], expectedOutput: 999)
    runProgam(program: program, input: [8], expectedOutput: 1000)
    runProgam(program: program, input: [9], expectedOutput: 1001)
  }
}
