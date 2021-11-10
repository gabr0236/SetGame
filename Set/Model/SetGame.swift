//
//  SetGame.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import Foundation

struct SetGame {
    private(set) var deckOfCards = [SetCard]()
    private(set) var shownCards = [SetCard]()
    var score = 0
    let numberOfCardsToMatch = 3
    let numberOfStartCards = 12
    private(set) var streak = 0
    let maxStreak = 3
    var hintsUsed = 0
    let maxHints = 10
    let gameTimer = GameTimer()
    
    //---- Scoring ----//
    let maxBonusPoints = 1000
    let pointsPerCorrect = 500
    let maxPenaltyForMoreCardsShown = 500
    let timeSpentBonusLimit = 40
    let extraCardsShownForMaxPenalty = 18
    var extraCardsShown: Int {
        shownCards.count-numberOfStartCards>0 ? shownCards.count-numberOfStartCards : 0
    }
    
    
    
    var matchedIndices: [Int] {
        shownCards.indices.filter { shownCards[$0].isSelected && shownCards[$0].isMatched }
    }
    
    mutating func choose(_ card: SetCard) {
        print("choose called")
        if let chosenIndex = shownCards.firstIndex(where: { $0.id == card.id})
        {
            
            // ---- If 3 cards were already selected ---- //
            if shownCards.filter({$0.isSelected}).count==3 {
                let potentialMatchingCards1 = shownCards.filter({$0.isSelected == true})
                if (isMatch(cards: potentialMatchingCards1)){
                    // ---- Match ---- //
                    changeCards()
                    return
                } else {
                    // ---- Not Match ---- //
                    shownCards.indices.filter { shownCards[$0].isSelected == true }
                        .forEach { shownCards[$0].isSelected = false
                            shownCards[$0].isWrongGuess = false
                        }
                }
            }
            
            shownCards[chosenIndex].isSelected.toggle()
            
            
            let potentialMatchingCards = shownCards.filter({$0.isSelected == true})
            
            // ---- If 3 cards is now selected ---- //
            if  potentialMatchingCards.count == numberOfCardsToMatch {
                if (isMatch(cards: potentialMatchingCards)) {
                    // ---- Match ---- //
                    
                    shownCards.indices.filter { shownCards[$0].isSelected == true }
                        .forEach { shownCards[$0].isMatched = true }
                   
                    updateScoreCorrectGuess(timeSpent: gameTimer.secondsElapsed)
                    gameTimer.restart()

                    deHint()
                } else {
                    // ---- Not Match ---- //
                    shownCards.indices.filter { shownCards[$0].isSelected == true }
                        .forEach { shownCards[$0].isWrongGuess = true }
                    score-=1
                    streak=0
                }
            }
        }
    }
    
    mutating func updateScoreCorrectGuess(timeSpent: Int) {
        guard matchedIndices.count==3 else { return }
        
        var addToScore = 0
        streak+=(streak<maxStreak ? 1 : 0)
        
        //---- Add Time Bonus ----//
        let timeBonusPercent = timeSpent<timeSpentBonusLimit ? timeSpent/timeSpentBonusLimit : 0
        
        addToScore += timeBonusPercent==0 ? 0 : maxBonusPoints*(1-timeBonusPercent)
        
        //---- Add Extra Cards Shown Penalty ----//
        addToScore += -maxPenaltyForMoreCardsShown/(extraCardsShownForMaxPenalty*extraCardsShown)
        
        //---- Add Standard Points ----//
        addToScore += pointsPerCorrect
        
        //---- Add Streak Multiplier ----//
        addToScore += addToScore*(1+streak/10)
        
        score+=addToScore
    }
    
    mutating func changeCards(){
        guard matchedIndices.count == numberOfCardsToMatch else { return }
        let replaceIndices = matchedIndices
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
        deckOfCards = Array<SetCard>()
        createCards()
        deckOfCards.shuffle()
        showStartingCards()
        gameTimer.start()
    }
    
    mutating func createCards() {
        var j = 0
        for number in Variant.allCases {
            for shape in Variant.allCases {
                for color in Variant.allCases {
                    for gradient in Variant.allCases {
                        deckOfCards.append(
                            SetCard(shape: shape,
                                    color: color,
                                    fill: gradient,
                                    numberOfShapes: number,
                                    id: j
                            ))
                        j+=1
                    }
                }
            }
        }
        print("There is this many uniqe cards in deck: \(NSSet(array: deckOfCards).count) \nThere is a total of \(deckOfCards.count) in deck.")
    }
    
    func isMatch(cards: [SetCard]) -> Bool {
        guard cards.count==3 else { return false }
        let sum = [
            cards.reduce(0, { $0 + $1.color.rawValue }),
            cards.reduce(0, { $0 + $1.fill.rawValue }),
            cards.reduce(0, { $0 + $1.numberOfShapes.rawValue }),
            cards.reduce(0, { $0 + $1.shape.rawValue })
        ]
        return sum.reduce(true, { $0 && ($1 % 3 == 0) })
    }
    
    
    mutating func showStartingCards() {
        for _ in 1...numberOfStartCards {
            shownCards.append(deckOfCards.removeFirst())
        }
    }
    
    mutating func showThreeMoreCardsFromDeck()  {
        if deckOfCards.count >= 3 {
            if matchedIndices.count==3 {
                //---- Replace if 3 cards is already matched ----//
                for index in matchedIndices {
                    shownCards.remove(at: index)
                    shownCards.insert(deckOfCards.remove(at: 0), at: index)
                }
            } else {
                //TODO score update
                if indexesOfAllMatches.count>0 { score-=1 }
                //---- Add Three Cards ----//
                for _ in 0...2 {
                    shownCards.append(deckOfCards.remove(at: 0))
                }
            }
        }
    }
    
    var indexesOfAllMatches: [[Int]] {
        var hints = [[Int]]()
        if shownCards.count>=numberOfCardsToMatch {
            for i in 0..<shownCards.count-2 {
                for j in (i+1)..<shownCards.count-1 {
                    for k in (j+1)..<shownCards.count {
                        let currentCards = [shownCards[i], shownCards[j], shownCards[k]]
                        if isMatch(cards: currentCards) { hints.append([i,j,k]) }
                    }
                }
            }
        }
        return hints
    }
    
    mutating func hint() {
        if hintsUsed<=maxHints && matchedIndices.count==0{
            if shownCards.allSatisfy({ !$0.isHint }){
                if let indexOfRandomMatchingSet = indexesOfAllMatches.randomElement() {
                    for i in 0..<indexOfRandomMatchingSet.count {
                        shownCards[indexOfRandomMatchingSet[i]].isHint=true
                    }
                    hintsUsed+=1
                    print(hintsUsed)
                }
            }
        }
    }
    
    mutating func deHint(){
        shownCards.indices.filter({shownCards[$0].isHint}).forEach({shownCards[$0].isHint=false})
    }
}

//extension Array where Element: Equatable {
//    mutating func remove(_ element: Element) {
//        _ = firstIndex(of: element).flatMap {
//            self.remove(at: $0)
//        }
//    }
//}
