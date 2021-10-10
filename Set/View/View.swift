//
//  ContentView.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import SwiftUI

struct SetGameView: View {
    @ObservedObject var game: ViewModel
    
    var body: some View {
        VStack{
            HStack(alignment: .bottom){
                Text("Set Game")
                    .font(.largeTitle)
            }
            //Text("Score: \(game.score)")
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            game.choose(card)
                        }
                }
            }.foregroundColor(.blue)
            .padding(.horizontal)
            
            Button("show 3 more cards"){
                game.showThreeMoreCardsFromDeck()
            }
        }
    }
}






















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = ViewModel()
        SetGameView(game: game)
    }
}
