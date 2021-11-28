//
//  SetTests.swift
//  SetTests
//
//  Created by Gabriel Haugbøl on 06/11/2021.
//
//  score scenarios refers to the scoring excel file in project root

import XCTest
@testable import Set

class SetTests: XCTestCase {
    
    var sut: SetGame!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = SetGame()
        sut.showCards()
    }
    
    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }
    
    func testIsMatch() {
        let shownCards = [   SetCard(
                                shape: Variant.one,
                                color: Variant.one,
                                fill: Variant.one,
                                numberOfShapes: Variant.three,
                                isSelected: true,
                                id: 1),
                             SetCard(
                                shape: Variant.one,
                                color: Variant.three,
                                fill: Variant.one,
                                numberOfShapes: Variant.three,
                                isSelected: true,
                                id: 2),
                             SetCard(
                                shape: Variant.one,
                                color: Variant.two,
                                fill: Variant.one,
                                numberOfShapes: Variant.three,
                                isSelected: true,
                                id: 3),]
        
        XCTAssert(sut.isMatch(cards: shownCards), "This should be a match")
    }
    
    func testScoreScenario1() {
        //Time spent: 30
        //Extrashowncards: 6
        //Streak: 0
        
        sut.showThreeMoreCardsFromDeck()
        sut.showThreeMoreCardsFromDeck()
        sut.updateScoreCorrectGuess(timeSpent: 30)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==583, "Test of scenario 1 failed")
    }
    
    func testScoreScenario2() {
        //Time spent: 10
        //Extrashowncards: 0
        //Streak: 0
        
        sut.updateScoreCorrectGuess(timeSpent: 10)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==1250, "Test of scenario 2 failed")
    }
    
    func testScoreScenario3() {
        //Time spent: 10
        //Extrashowncards: 18
        //Streak: 0
        for _ in 0..<6{
            sut.showThreeMoreCardsFromDeck()
        }
        
        sut.updateScoreCorrectGuess(timeSpent: 10)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==750, "Test of scenario 3 failed")
    }
    
    func testScoreScenario4() {
        //Time spent: 40
        //Extrashowncards: 18
        //Streak: 0
        for _ in 0..<6{
            sut.showThreeMoreCardsFromDeck()
        }
        
        sut.updateScoreCorrectGuess(timeSpent: 40)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==0, "Test of scenario 4 failed")
    }
    
    func testScoreScenario5() {
        //Time spent: 40
        //Extrashowncards: 3
        //Streak: 0
            sut.showThreeMoreCardsFromDeck()
        
        sut.updateScoreCorrectGuess(timeSpent: 40)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==416, "Test of scenario 5 failed")
    }
    
    func testScoreScenario6() {
        //Time spent: 20
        //Extrashowncards: 12
        //Streak: 0
        for _ in 0..<4{
            sut.showThreeMoreCardsFromDeck()
        }
        sut.updateScoreCorrectGuess(timeSpent: 20)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==666, "Test of scenario 6 failed")
    }
    
    func testScoreScenario7() {
        //Time spent: 20
        //Extrashowncards: 3
        //Streak: 0
            sut.showThreeMoreCardsFromDeck()
        
        sut.updateScoreCorrectGuess(timeSpent: 20)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==916, "Test of scenario 7 failed")
    }
    
    func testScoreScenario8() {
        //Time spent: 5
        //Extrashowncards: 18
        //Streak: 0
        for _ in 0..<6{
            sut.showThreeMoreCardsFromDeck()
        }
        
        sut.updateScoreCorrectGuess(timeSpent: 5)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==875, "Test of scenario 8 failed")
    }
    
    func testScoreScenario9() {
        //Time spent: 5
        //Extrashowncards: 6
        //Streak: 0
        sut.showThreeMoreCardsFromDeck()
        sut.showThreeMoreCardsFromDeck()

        sut.updateScoreCorrectGuess(timeSpent: 5)
        
        print("SCORE: \(sut.score)")
        XCTAssert(sut.score==1208, "Test of scenario 9 failed")
    }
    
    func testMultipleScoreScenarios() {
        //Time spent: 10
        //Extrashowncards: 0
        //Streak: 0
        //Points: +1250
        sut.updateScoreCorrectGuess(timeSpent: 10)
        
        print("SCORE CASE 1: \(sut.score)")
        XCTAssert(sut.score==1250, "Case 1 correct guess - FAILED")
        
        sut.updateScoreWrongGuess()
        XCTAssert(sut.score==450, "Case 1 wrong guess - FAILED")
        
        //Time spent: 40
        //Extrashowncards: 3
        //Streak: 0
        //Points: +416
            sut.showThreeMoreCardsFromDeck()
        
        sut.updateScoreCorrectGuess(timeSpent: 40)
        
        print("SCORE CASE 2: \(sut.score)")
        XCTAssert(sut.score==866, "Case 2 correct guess - FAILED")
        
        //Time spent: 20
        //Extrashowncards: 3
        //Streak: 0
        //Points: +1008 (Streak 1)
        sut.updateScoreCorrectGuess(timeSpent: 20)
        
        print("SCORE CASE 3: \(sut.score)")
        XCTAssert(sut.score==1874, "Case 3 correct guess - FAILED")
        
        //Time spent: 30
        //Extrashowncards: 6
        //Streak: 0
        //Points: +583 (Streak 2)
        
        sut.showThreeMoreCardsFromDeck()
        sut.updateScoreCorrectGuess(timeSpent: 30)
        
        print("SCORE CASE 4: \(sut.score)")
        XCTAssert(sut.score==2573, "Case 4 correct guess - FAILED")
        
        //Time spent: 5
        //Extrashowncards: 18
        //Streak: 0
        //Points: +875 (Streak 3)
        for _ in 0..<4{
            sut.showThreeMoreCardsFromDeck()
        }
        
        sut.updateScoreCorrectGuess(timeSpent: 5)
        
        print("SCORE CASE 5: \(sut.score)")
        XCTAssert(sut.score==3710, "Case 5 failed")
    }
    
    //func testPerformanceExample() throws {
    //    // This is an example of a performance test case.
    //    measure {
    //        // Put the code you want to measure the time of here.
    //    }
    //}
}
