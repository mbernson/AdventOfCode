import XCTest
@testable import AdventOfCode2021

final class Day6Tests: XCTestCase {
  let input: [Int] = [3,4,3,1,2]
  let day6 = Day6()

  func testGeneration() throws {
    let fishbowl = Day6.Fishbowl(input: input)
    // Initial state: 3,4,3,1,2
    XCTAssertEqual(fishbowl.amountOfFish, [3,4,3,1,2].count)

    fishbowl.cycle()
    // After  1 day:
    XCTAssertEqual(fishbowl.amountOfFish, [2,3,2,0,1].count)
    fishbowl.cycle()
    // After  2 days:
    XCTAssertEqual(fishbowl.amountOfFish, [1,2,1,6,0,8].count)
    fishbowl.cycle()
    // After  3 days:
    XCTAssertEqual(fishbowl.amountOfFish, [0,1,0,5,6,7,8].count)
    fishbowl.cycle()
    // After  4 days:
    XCTAssertEqual(fishbowl.amountOfFish, [6,0,6,4,5,6,7,8,8].count)
    fishbowl.cycle()
    // After  5 days:
    XCTAssertEqual(fishbowl.amountOfFish, [5,6,5,3,4,5,6,7,7,8].count)
    fishbowl.cycle()
    // After  6 days:
    XCTAssertEqual(fishbowl.amountOfFish, [4,5,4,2,3,4,5,6,6,7].count)
    fishbowl.cycle()
    // After  7 days:
    XCTAssertEqual(fishbowl.amountOfFish, [3,4,3,1,2,3,4,5,5,6].count)
    fishbowl.cycle()
    // After  8 days:
    XCTAssertEqual(fishbowl.amountOfFish, [2,3,2,0,1,2,3,4,4,5].count)
    fishbowl.cycle()
    // After  9 days:
    XCTAssertEqual(fishbowl.amountOfFish, [1,2,1,6,0,1,2,3,3,4,8].count)
    fishbowl.cycle()
    // After 10 days:
    XCTAssertEqual(fishbowl.amountOfFish, [0,1,0,5,6,0,1,2,2,3,7,8].count)
    fishbowl.cycle()
    // After 11 days:
    XCTAssertEqual(fishbowl.amountOfFish, [6,0,6,4,5,6,0,1,1,2,6,7,8,8,8].count)
    fishbowl.cycle()
    // After 12 days:
    XCTAssertEqual(fishbowl.amountOfFish, [5,6,5,3,4,5,6,0,0,1,5,6,7,7,7,8,8].count)
    fishbowl.cycle()
    // After 13 days:
    XCTAssertEqual(fishbowl.amountOfFish, [4,5,4,2,3,4,5,6,6,0,4,5,6,6,6,7,7,8,8].count)
    fishbowl.cycle()
    // After 14 days:
    XCTAssertEqual(fishbowl.amountOfFish, [3,4,3,1,2,3,4,5,5,6,3,4,5,5,5,6,6,7,7,8].count)
    fishbowl.cycle()
    // After 15 days:
    XCTAssertEqual(fishbowl.amountOfFish, [2,3,2,0,1,2,3,4,4,5,2,3,4,4,4,5,5,6,6,7].count)
    fishbowl.cycle()
    // After 16 days:
    XCTAssertEqual(fishbowl.amountOfFish, [1,2,1,6,0,1,2,3,3,4,1,2,3,3,3,4,4,5,5,6,8].count)
    fishbowl.cycle()
    // After 17 days:
    XCTAssertEqual(fishbowl.amountOfFish, [0,1,0,5,6,0,1,2,2,3,0,1,2,2,2,3,3,4,4,5,7,8].count)
    fishbowl.cycle()
    // After 18 days:
    XCTAssertEqual(fishbowl.amountOfFish, [6,0,6,4,5,6,0,1,1,2,6,0,1,1,1,2,2,3,3,4,6,7,8,8,8,8].count)
    XCTAssertEqual(fishbowl.amountOfFish, 26)

    for _ in 19...80 {
      fishbowl.cycle()
    }
    XCTAssertEqual(fishbowl.amountOfFish, 5934)
  }
}
