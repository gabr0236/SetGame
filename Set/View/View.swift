//
//  ContentView.swift
//  Set
//
//  Created by Gabriel Haugbøl on 22/09/2021.
//

import SwiftUI

struct SetGameView: View {
    @StateObject var game: ViewModel
    @Namespace private var dealingNamespace
    @State var shouldDelay = true

    
    var body: some View {
            VStack {
                // --------- Top Of Screen -------- //
                HStack(alignment: .bottom){
                    Text(game.isStreak() ? "️‍🔥Score: \(game.score())🔥" : "Score: \(game.score())").animation(.none) //TODO: Red text if score is negative, green if positive
                        .font(.largeTitle)
                        .foregroundColor(game.isStreak() ? .green : .primary)
                }.padding(10)
                
                // ------------ Cards ------------- //
                gameBody
                
                // ------- Bottom Of Screen ------- //
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
                }.padding(6)
            }
        }
    
    let cardTransitionDelay = 0.2
    
    private func dealDelay(card: SetCard) -> Double {
    //guard shouldDelay else { return 0 }
    return Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0) * cardTransitionDelay
    }
    
    var gameBody: some View {
        AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .transition(.asymmetric(insertion: .identity, removal: .opacity))
                .animation(.easeInOut(duration: 1.0)
                            .delay(dealDelay(card: card)))
                .padding(4)
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation(.spring()){
                            game.choose(card)
                    }
                }
        }.foregroundColor(CardConstants.color)
        .padding(.horizontal)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(game.deck()){ card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(.asymmetric(insertion: .identity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .padding(0)
        .onTapGesture {
            withAnimation(.spring().speed(0.1)){
                
                game.showCards()
            }
        }
        .zIndex(5)
    }
    
    private func zIndex(of card: SetCard) -> Double {
        -Double(game.cards.firstIndex(where: { $0.id == card.id }) ?? 0)
    }
    
    var discardPileBody: some View {
        ZStack {
            ForEach(game.descardPile()) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
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
            SetGameView(game: game)
        }
    }
}
