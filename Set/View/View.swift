//
//  ContentView.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import SwiftUI

struct SetGameView: View {
    @StateObject var game: ViewModel
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Text(game.isStreak() ? "️‍🔥Score: \(game.score())🔥" : "Score: \(game.score())")
                    .font(.largeTitle)
                    .foregroundColor(game.isStreak() ? .green : .primary)
            }
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }.foregroundColor(.blue)
            .padding(.horizontal)
            HStack{
                Spacer()
                Spacer()
                Button("Add Three Cards"){
                    game.showThreeMoreCardsFromDeck()
                }.disabled(!game.isMoreThanThreeCardsInDeck())
                .frame(maxWidth: .infinity)
                Button("New Game"){
                    game.newGame()
                }.frame(maxWidth: .infinity)
                Spacer()
                Spacer()
            }
        }
    }
}






















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ViewModel()
        Group {
            SetGameView(game: game)
        }
    }
}
