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
}