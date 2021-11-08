//
//  SetTests.swift
//  SetTests
//
//  Created by Gabriel Haugbøl on 06/11/2021.
//

import XCTest
@testable import Set

class SetTests: XCTestCase {

    var sut: SetGame!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SetGame()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        
    }

    func testExample() throws {
        let shownCards = [   SetGame.Card(
                shape: SetGame.Shape.diamond,
                color: SetGame.SetColor.green,
                fill: SetGame.Fill.fill,
                                numberOfShapes: SetGame.Variant.three,
                isSelected: true,
                id: 1),
            SetGame.Card(
                shape: SetGame.Shape.diamond,
                color: SetGame.SetColor.orange,
                fill: SetGame.Fill.fill,
                numberOfShapes: SetGame.Variant.three,
                isSelected: true,
                id: 2),
            SetGame.Card(
                shape: SetGame.Shape.diamond,
                color: SetGame.SetColor.pink,
                fill: SetGame.Fill.fill,
                numberOfShapes: SetGame.Variant.three,
                isSelected: true,
                id: 3),]
        
        XCTAssert(sut.isMatch(cards: shownCards), "This should be a match")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
