//
//  SetGame.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import Foundation

struct Model {
    private(set) var cards: Array<Card> = []
    
    private(set) var player: Player

    
    mutating func choose(_ card: Card) {
    }
    
    //init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
    //    cards = Array<Card>()
    //    // add number of pairs of cards x 2 cards to card array
    //    for pairIndex in 0..<numberOfPairsOfCards {
    //        let content: CardContent = createCardContent(pairIndex)
    //        cards.append(Card(content: content, id: pairIndex*2))
    //        cards.append(Card(content: content, id: pairIndex*2+1))
    //    }
    //    cards.shuffle()
    //}

    struct Card: Identifiable {
        let shape: String
        let color: String
        let gradient: String
        let numberOfShapes: Int
        let isClaimed = false
        let id: Int
    }
}

struct Player {
    var score = 0
    var collectedSetsOfCards = [Model.Card]()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}
