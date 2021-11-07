//
//  SetTests.swift
//  SetTests
//
//  Created by Gabriel Haugbøl on 06/11/2021.
//

import XCTest
@testable import Set

class SetTests: XCTestCase {

    var sut: Model!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = Model()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut = nil
        
    }

    func testExample() throws {
        let shownCards = [   Model.Card(
                shape: Model.Shape.diamond,
                color: Model.SetColor.green,
                fill: Model.Fill.fill,
                                numberOfShapes: Model.Number.three,
                isSelected: true,
                id: 1),
            Model.Card(
                shape: Model.Shape.diamond,
                color: Model.SetColor.orange,
                fill: Model.Fill.fill,
                numberOfShapes: Model.Number.three,
                isSelected: true,
                id: 2),
            Model.Card(
                shape: Model.Shape.diamond,
                color: Model.SetColor.pink,
                fill: Model.Fill.fill,
                numberOfShapes: Model.Number.three,
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
