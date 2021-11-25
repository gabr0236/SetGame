//
//  ContentView.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import SwiftUI

struct SetGameView: View {
    @StateObject var game: ViewModel
    
    @State var dealt = Set<Int>()
    
    var body: some View {
        VStack {
            HStack(alignment: .bottom){
                Text(game.isStreak() ? "️‍🔥Score: \(game.score())🔥" : "Score: \(game.score())") //TODO: Red text if score is negative, green if positive
                    .font(.largeTitle)
                    .foregroundColor(game.isStreak() ? .green : .primary)
            }.padding(10)
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                CardView(card: card)
                    .padding(4)
                    .onTapGesture {
                        game.choose(card)
                    }
            }.foregroundColor(CardConstants.color)
            .padding(.horizontal)
            HStack{
                Button("Show Hint"){
                    game.hint()
                }.frame(maxWidth: .infinity)
                .disabled(!game.isHintAvailible())
                deckBody
                discardPileBody
                Button("New Game"){
                    game.newGame()
                }.frame(maxWidth: .infinity)
            }.padding(10)
        }
    }
    
    private func deal(_ card: SetCard) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: SetCard) -> Bool {
        !dealt.contains(card.id)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.deck()){ card in
                CardView(card: card)
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            game.showThreeMoreCardsFromDeck()
        }
    }
    
    var discardPileBody: some View {
        ZStack {
            ForEach(game.descardPile()) { card in
                CardView(card: card)
            }
        }.frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
    }
    
    
    private struct CardConstants {
        static let color = Color.blue
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
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
