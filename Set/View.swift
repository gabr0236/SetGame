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
            Text("Score: \(game.score)")
            
            AspectVGrid(items: game.cards, aspectRatio: 2/3) { card in
                if card.isMatched {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card)
                        .padding(4)
                        .onTapGesture {
                            //TODO: inplement
                            //game.choose(card)
                        }
                }
            }
            .foregroundColor(.blue)
            .padding(.horizontal)
            
            Button("show 3 more cards"){
                game.showCards()
            }
        }
    }
}

struct CardView: View {
    let card: Model.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 10)
                if !card.isMatched {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 4)
                    //Text(card.content).font(font(in: geometry.size))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill()
                }
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
