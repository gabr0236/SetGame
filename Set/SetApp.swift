//
//  SetApp.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import SwiftUI

@main
struct SetApp: App {
    var body: some Scene {
        let game = ViewModel()
        WindowGroup {
            SetGameView(game: game)
        }
    }
}

