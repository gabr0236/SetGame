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
        player = Player(name: "TestPlayer")
        model = Model()
    }
    private var player: Player
    
    var score: Int { player.score }
    
    var cards: Array<Model.Card> {
        return model.shownCards
    }
    
    func choose(_ card: Model.Card) {
        model.choose(card)
    }
    
    func showCards() {
        model.showThreeMoreCardsFromDeck()
    }
}
