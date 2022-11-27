import XCTest
@testable import AdventOfCode2021

class Day11Tests: XCTestCase {
  let exampleInput: [[Int]] = [
    [5,4,8,3,1,4,3,2,2,3],
    [2,7,4,5,8,5,4,7,1,1],
    [5,2,6,4,5,5,6,1,7,3],
    [6,1,4,1,3,3,6,1,4,6],
    [6,3,5,7,3,8,5,4,7,8],
    [4,1,6,7,5,2,4,6,4,5],
    [2,1,7,6,8,4,1,7,2,1],
    [6,8,8,2,8,8,1,1,3,4],
    [4,8,4,6,8,4,8,5,5,4],
    [5,2,8,3,7,5,1,5,2,6],
  ]

  func testPointsAround() {
    let bowl = Day11.Fishbowl(input: exampleInput)

    XCTAssertEqual(bowl.pointsAround(point: .init(x: 0, y: 0)), [
      Day11.Point(x: 1, y: 0),
      Day11.Point(x: 0, y: 1),
      Day11.Point(x: 1, y: 1),
    ])

    XCTAssertEqual(bowl.pointsAround(point: .init(x: 1, y: 1)), [
      Day11.Point(x: 0, y: 0),
      Day11.Point(x: 1, y: 0),
      Day11.Point(x: 2, y: 0),

      Day11.Point(x: 0, y: 1),
      Day11.Point(x: 2, y: 1),

      Day11.Point(x: 0, y: 2),
      Day11.Point(x: 1, y: 2),
      Day11.Point(x: 2, y: 2),
    ])

    XCTAssertEqual(bowl.pointsAround(point: .init(x: 9, y: 9)), [
      Day11.Point(x: 8, y: 8),
      Day11.Point(x: 9, y: 8),
      Day11.Point(x: 8, y: 9),
    ])
  }

  func testPointsMatching() {
    let bowl = Day11.Fishbowl(input: exampleInput)
    let fives = bowl.pointsMatching { $0 == 5 }
    XCTAssertEqual(fives.count, 15)
    XCTAssertEqual(fives[0], Day11.Point(x: 0, y: 0))
    XCTAssertEqual(fives[1], Day11.Point(x: 3, y: 1))
    XCTAssertEqual(fives[2], Day11.Point(x: 5, y: 1))
  }

  func testExample() {
    let bowl = Day11.Fishbowl(input: exampleInput)

    // Before any steps:
    let initialState: [[Int]] = [
      [5,4,8,3,1,4,3,2,2,3],
      [2,7,4,5,8,5,4,7,1,1],
      [5,2,6,4,5,5,6,1,7,3],
      [6,1,4,1,3,3,6,1,4,6],
      [6,3,5,7,3,8,5,4,7,8],
      [4,1,6,7,5,2,4,6,4,5],
      [2,1,7,6,8,4,1,7,2,1],
      [6,8,8,2,8,8,1,1,3,4],
      [4,8,4,6,8,4,8,5,5,4],
      [5,2,8,3,7,5,1,5,2,6],
    ]
    XCTAssertEqual(bowl.totalFlashes, 0)
    XCTAssertEqual(bowl.state, initialState)

    bowl.tick()
    // After step 1:
    let afterStep1: [[Int]] = [
      [6,5,9,4,2,5,4,3,3,4],
      [3,8,5,6,9,6,5,8,2,2],
      [6,3,7,5,6,6,7,2,8,4],
      [7,2,5,2,4,4,7,2,5,7],
      [7,4,6,8,4,9,6,5,8,9],
      [5,2,7,8,6,3,5,7,5,6],
      [3,2,8,7,9,5,2,8,3,2],
      [7,9,9,3,9,9,2,2,4,5],
      [5,9,5,7,9,5,9,6,6,5],
      [6,3,9,4,8,6,2,6,3,7],
    ]
    XCTAssertEqual(bowl.totalFlashes, 0)
    XCTAssertEqual(bowl.state, afterStep1)

    bowl.dumpState()
    bowl.tick()
    // After step 2:
    let afterStep2: [[Int]] = [
      [8,8,0,7,4,7,6,5,5,5],
      [5,0,8,9,0,8,7,0,5,4],
      [8,5,9,7,8,8,9,6,0,8],
      [8,4,8,5,7,6,9,6,0,0],
      [8,7,0,0,9,0,8,8,0,0],
      [6,6,0,0,0,8,8,9,8,9],
      [6,8,0,0,0,0,5,9,4,3],
      [0,0,0,0,0,0,7,4,5,6],
      [9,0,0,0,0,0,0,8,7,6],
      [8,7,0,0,0,0,6,8,4,8],
    ]
    bowl.dumpState()
    XCTAssertEqual(bowl.totalFlashes, 35)
    XCTAssertEqual(bowl.state, afterStep2)
//
//    bowl.tick()
//    // After step 3:
//    let afterStep3: [[Int]] = [
//      [0,0,5,0,9,0,0,8,6,6],
//      [8,5,0,0,8,0,0,5,7,5],
//      [9,9,0,0,0,0,0,0,3,9],
//      [9,7,0,0,0,0,0,0,4,1],
//      [9,9,3,5,0,8,0,0,6,3],
//      [7,7,1,2,3,0,0,0,0,0],
//      [7,9,1,1,2,5,0,0,0,9],
//      [2,2,1,1,1,3,0,0,0,0],
//      [0,4,2,1,1,2,5,0,0,0],
//      [0,0,2,1,1,1,9,0,0,0],
//    ]
//    XCTAssertEqual(bowl.state, afterStep3)
//
//    bowl.tick()
//    // After step 4:
//    let afterStep4: [[Int]] = [
//      [2,2,6,3,0,3,1,9,7,7],
//      [0,9,2,3,0,3,1,6,9,7],
//      [0,0,3,2,2,2,1,1,5,0],
//      [0,0,4,1,1,1,1,1,6,3],
//      [0,0,7,6,1,9,1,1,7,4],
//      [0,0,5,3,4,1,1,1,2,2],
//      [0,0,4,2,3,6,1,1,2,0],
//      [5,5,3,2,2,4,1,1,2,2],
//      [1,5,3,2,2,4,7,2,1,1],
//      [1,1,3,2,2,3,0,2,1,1],
//    ]
//    XCTAssertEqual(bowl.state, afterStep4)
//
//    bowl.tick()
//    // After step 5:
//    let afterStep5: [[Int]] = [
//     [4,4,8,4,1,4,4,0,0,0],
//     [2,0,4,4,1,4,4,0,0,0],
//     [2,2,5,3,3,3,3,4,9,3],
//     [1,1,5,2,3,3,3,2,7,4],
//     [1,1,8,7,3,0,3,2,8,5],
//     [1,1,6,4,6,3,3,2,3,3],
//     [1,1,5,3,4,7,2,2,3,1],
//     [6,6,4,3,3,5,2,2,3,3],
//     [2,6,4,3,3,5,8,3,2,2],
//     [2,2,4,3,3,4,1,3,2,2],
//    ]
//    XCTAssertEqual(bowl.state, afterStep5)
//
//    bowl.tick()
//    // After step 6:
//    let afterStep6: [[Int]] = [
//     [5,5,9,5,2,5,5,1,1,1],
//     [3,1,5,5,2,5,5,2,2,2],
//     [3,3,6,4,4,4,4,6,0,5],
//     [2,2,6,3,4,4,4,4,9,6],
//     [2,2,9,8,4,1,4,3,9,6],
//     [2,2,7,5,7,4,4,3,4,4],
//     [2,2,6,4,5,8,3,3,4,2],
//     [7,7,5,4,4,6,3,3,4,4],
//     [3,7,5,4,4,6,9,4,3,3],
//     [3,3,5,4,4,5,2,4,3,3],
//    ]
//    XCTAssertEqual(bowl.state, afterStep6)

    // After step 7:
    // 6707366222
    // 4377366333
    // 4475555827
    // 3496655709
    // 3500625609
    // 3509955566
    // 3486694453
    // 8865585555
    // 4865580644
    // 4465574644

    // After step 8:
    // 7818477333
    // 5488477444
    // 5697666949
    // 4608766830
    // 4734946730
    // 4740097688
    // 6900007564
    // 0000009666
    // 8000004755
    // 6800007755

    // After step 9:
    // 9060000644
    // 7800000976
    // 6900000080
    // 5840000082
    // 5858000093
    // 6962400000
    // 8021250009
    // 2221130009
    // 9111128097
    // 7911119976

    // After step 10:
    // 0481112976
    // 0031112009
    // 0041112504
    // 0081111406
    // 0099111306
    // 0093511233
    // 0442361130
    // 5532252350
    // 0532250600
    // 0032240000
  }
}
