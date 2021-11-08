//
//  ViewModel.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model: Model
    
    
    init() {
        model = Model()
    }
        
    var cards: Array<Model.Card> {
        return model.shownCards
    }
    
    func choose(_ card: Model.Card) {
        model.choose(card)
    }
    
    func showThreeMoreCardsFromDeck() {
        model.showThreeMoreCardsFromDeck()
    }
    
    func score() -> Int {
        return model.score
    }
    
    func isMoreThanThreeCardsInDeck() -> Bool {
        return model.deckOfCards.count>=3
    }
    
    func newGame() {
        model = Model()
    }
}
