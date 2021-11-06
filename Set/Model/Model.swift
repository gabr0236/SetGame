//
//  SetGame.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import Foundation

struct Model {
    private(set) var deckOfCards = [Card]()
    private(set) var shownCards = [Card]()
    private(set) var matchedCards = [Card]()
    
    let numberOfCardsToMatch = 3
    let numberOfStartCards = 12
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = shownCards.firstIndex(where: { $0.id == card.id}),
           !shownCards[chosenIndex].isMatched
        {
            shownCards[chosenIndex].isSelected.toggle()
            
            let potentialMatchingCards = shownCards.filter({$0.isSelected == true})
            if  potentialMatchingCards.count == numberOfCardsToMatch {
                if (isMatch(cards: potentialMatchingCards)) {
                    shownCards.indices.filter { shownCards[$0].isSelected == true }
                        .forEach { shownCards[$0].isMatched = true }
                    changeCards()
                } else {
                shownCards.indices.filter { shownCards[$0].isSelected == true }
                    .forEach { shownCards[$0].isSelected = false }
            }
        }
        }
    }
    
    var matchedIndices: [Int] {
        shownCards.indices.filter { shownCards[$0].isSelected && shownCards[$0].isMatched }
    }
    
    mutating func changeCards(){
        guard matchedIndices.count == numberOfCardsToMatch else { return }
        let replaceIndices = matchedIndices
        //TODO: hvorfor && shownCards.count==numberOfStartCards??
        if deckOfCards.count>=numberOfCardsToMatch && shownCards.count==numberOfStartCards {
            //Replace
            for index in replaceIndices {
                shownCards.remove(at: index)
                shownCards.insert(deckOfCards.remove(at: 0), at: index)
            }
        } else {
            //Remove
            shownCards = shownCards.enumerated()
            .filter { !replaceIndices.contains($0.offset) }
            .map { $0.element }
        }
    }
    
    init() {
        deckOfCards = Array<Card>()
        createCards()
        deckOfCards.shuffle()
        showStartingCards()
    }
    
    mutating func createCards() {
        var j = 0
        for i in 1...3 {
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
        print("There is this many uniqe cards in deck: \(NSSet(array: deckOfCards).count) \nThere is a total of \(deckOfCards.count) in deck.")
    }
    
    func isMatch(cards: [Card]) -> Bool {
        if(cards.count==numberOfCardsToMatch){
            if((cards[0].isSelected && cards[1].isSelected && cards[2].isSelected)
                && (!cards[0].isMatched && !cards[1].isMatched && !cards[2].isMatched)){
                //Check for number of shapes, if shapes are not all diffrent or all the same return false
                if(!((cards[0].numberOfShapes==cards[1].numberOfShapes && cards[1].numberOfShapes==cards[2].numberOfShapes)
                        || ((cards[0].numberOfShapes != cards[1].numberOfShapes) && (cards[0].numberOfShapes != cards[2].numberOfShapes)
                                && (cards[2].numberOfShapes != cards[1].numberOfShapes)))){
                    print("MATCH FAIL: numberofshape")
                    return false
                }
                else if(!((cards[0].color==cards[1].color && cards[1].color==cards[2].color)
                            || ((cards[0].color != cards[1].color) && (cards[0].color != cards[2].color)
                                    && (cards[2].color != cards[1].color)))){
                    print("MATCH FAIL: color")
                    return false
                }
                else if(!((cards[0].fill==cards[1].fill && cards[1].fill==cards[2].fill)
                            || ((cards[0].fill != cards[1].fill) && (cards[0].fill != cards[2].fill)
                                    && (cards[2].fill != cards[1].fill)))){
                    print("MATCH FAIL: fill")
                    return false
                }
                else if(!((cards[0].shape==cards[1].shape && cards[1].shape==cards[2].shape)
                            || ((cards[0].shape != cards[1].shape) && (cards[0].shape != cards[2].shape)
                                    && (cards[2].shape != cards[1].shape)))){
                    print("MATCH FAIL: shape")
                    return false
                }
                else {
                    print("MATCH!!")
                    return true
                }
            }
        }
        return false
    }
    
    
    mutating func showStartingCards() {
        for _ in 1...numberOfStartCards {
            shownCards.append(deckOfCards.removeFirst())
        }
    }
    
    mutating func showThreeMoreCardsFromDeck()  {
        if deckOfCards.count >= 3 {
            for _ in 0...2 {
                shownCards.append(deckOfCards.remove(at: 0))
            }
        }
    }
    
    struct Card: Identifiable, Equatable {
        public var description: String { "CARD - Shape: \(shape), Color: \(color), Fill: \(fill), NumberOfShapes: \(numberOfShapes)"}
        let shape: Shape
        let color: SetColor
        let fill: Fill
        let numberOfShapes: Int
        var isMatched = false
        var isSelected = false
        let id: Int
    }
    
    enum Shape: Int,CaseIterable {
        case diamond=1, roundedRectangle, squiglle
    }
    
    enum SetColor: Int, CaseIterable {
        case green=1, orange, pink
    }
    
    enum Fill: Int, CaseIterable {
        case fill=1, stripes, none
    }
    
    //TODO slet?
    mutating func setShownCards(cards: Array<Card>) {
        shownCards=cards
    }
}

extension Array where Element: Equatable {
    mutating func remove(_ element: Element) {
        _ = firstIndex(of: element).flatMap {
            self.remove(at: $0)
        }
    }
}
