//
//  SetCard.swift
//  Set
//
//  Created by Gabriel Haugbøl on 08/11/2021.
//

import Foundation

struct SetCard: Identifiable, Equatable {
    public var description: String { "CARD - Shape: \(shape), Color: \(color), Fill: \(fill), NumberOfShapes: \(numberOfShapes)" }
    let shape: Variant
    let color: Variant
    let fill: Variant
    let numberOfShapes: Variant
    var isMatched = false
    var isSelected = false
    var isWrongGuess = false
    var isFaceDown = true
    var isHint = false
    let id: Int
    
   mutating func setDefaultValues() {
        isMatched = false
        isSelected = false
        isWrongGuess = false
        isHint = false
    }
}
enum Variant: Int, CaseIterable {
    case one=1, two, three
}
