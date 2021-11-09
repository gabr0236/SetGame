//
//  CardView.swift
//  Set
//
//  Created by Gabriel Haugbøl on 25/09/2021.
//

import SwiftUI

struct CardView: View {
    
    var card: SetCard
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 10)
                
                    shape.strokeBorder(lineWidth: 4).foregroundColor(card.isMatched ? .green : (card.isWrongGuess ? .red : (card.isSelected ? .purple : .blue)))
            
                VStack {
                    Spacer(minLength: 0)
                    ForEach(0..<card.numberOfShapes.rawValue, id: \.self) { index in
                        cardShape().frame(height: geometry.size.height/6)
                    }
                    Spacer(minLength: 0)
                }.padding()
                .foregroundColor(setColor())
                .aspectRatio(CGFloat(6.0/8.0), contentMode: .fit)
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
    }
    
    @ViewBuilder private func cardShape() -> some View {
        switch card.shape {
        case .one:          shapeFill(shape: Squiggle())
        case .two:  shapeFill(shape: Capsule())
        case .three:           shapeFill(shape: Diamond())
        }
    }
    
    private func setColor() -> Color {
        switch card.color {
        case .one: return Color.pink
        case .two: return Color.orange
        case .three: return Color.green
        }
    }
    
    @ViewBuilder private func shapeFill<setShape>(shape: setShape) -> some View
    //TODO: se løsning, brug rawvalues for cleanness
    where setShape: Shape {
        switch card.fill {
        case .one:       shape.fillAndBorder()
        case .two:    shape.stripe()
        case .three:       shape.stroke(lineWidth: 2)
        }
    }
}


















struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = SetCard(shape: .one, color: .two, fill: .two, numberOfShapes: .two, isSelected: true, id: 1)
        CardView(card: card)
            .overlay(
                RoundedRectangle( cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding()
    }
}
