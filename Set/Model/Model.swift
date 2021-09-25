//
//  SetGame.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import Foundation

struct Model {
    private(set) var deckOfCards: Array<Card> = []
    private(set) var shownCards: Array<Card> = []
    private(set) var player: Player
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = shownCards.firstIndex(where: { $0.id == card.id}),
           !shownCards[chosenIndex].isMatched
        {
            shownCards[chosenIndex].isSelected = shownCards[chosenIndex].isSelected ? false : true;
        }
    }
    
    init() {
        self.player = Player(name: "testplayer")
        deckOfCards = Array<Card>()
        createCards()
        showStartingCards()
        deckOfCards.shuffle()
    }
    
    mutating func createCards() {
        var j = 0
        for i in 0...2 {
            for shape in Shape.allCases {
                for color in SetColor.allCases {
                    for gradient in Fill.allCases {
                        deckOfCards.append(
                            Card(shape: shape,
                                 color: color,
                                 fill: gradient,
                                 numberOfShapes: i,
                                 id: j
                            ))
                        j+=1
                    }
                }
            }
        }
    }
    
    mutating func showStartingCards() {
        for _ in 0...12 {
            shownCards.append(deckOfCards.removeFirst())
        }
    }
    
    mutating func showThreeMoreCardsFromDeck()  {
        if deckOfCards.count >= 3 {
            for _ in 0...2 {
                shownCards.append(deckOfCards.removeFirst())
            }
        } else {
            for _ in deckOfCards {
                shownCards.append(deckOfCards.removeFirst())
            }
        }
    }
    
    struct Card: Identifiable {
        //lav til constant
        let shape: Shape
        let color: SetColor
        let fill: Fill
        let numberOfShapes: Int
        var isMatched = false
        var isSelected = false
        let id: Int
    }
    
    enum Shape: CaseIterable {
        case diamond, roundedRectangle, squiglle
    }
    
    enum SetColor: CaseIterable {
        case green, orange, pink
    }
    
    enum Fill: CaseIterable {
        case fill, stripes, none
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
