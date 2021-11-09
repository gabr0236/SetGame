//
//  ViewModel.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import SwiftUI

class ViewModel: ObservableObject {
    @Published private var model: SetGame
    
    
    init() {
        model = SetGame()
    }
        
    var cards: Array<SetCard> {
        return model.shownCards
    }
    
    func choose(_ card: SetCard) {
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
        model = SetGame()
    }
    
    func isStreak() -> Bool {
        return model.streak>1
    }
    
    func hint() {
        model.hint()
    }
}
