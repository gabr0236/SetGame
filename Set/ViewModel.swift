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
        model = Model(player: player)
    }
    private var player: Player
    
    var score: Int { player.score }

}
