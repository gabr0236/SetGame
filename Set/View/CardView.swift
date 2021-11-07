//
//  CardView.swift
//  Set
//
//  Created by Gabriel Haugbøl on 25/09/2021.
//

import SwiftUI

struct CardView: View {
    
    var card: Model.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack{
                let shape = RoundedRectangle(cornerRadius: 10)
                if !card.isMatched {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 4).foregroundColor(card.isSelected ? .red : .blue)
                }
            
                VStack {
                    Spacer(minLength: 0)
                    //TODO: Error here?
                    ForEach(0..<card.numberOfShapes.rawValue) { index in
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
        case .squiglle:          shapeFill(shape: Squiggle())
        case .roundedRectangle:  shapeFill(shape: Capsule())
        case .diamond:           shapeFill(shape: Diamond())
        }
    }
    
    private func setColor() -> Color {
        switch card.color {
        case .pink: return Color.pink
        case .orange: return Color.orange
        case .green: return Color.green
        }
    }
    
    @ViewBuilder private func shapeFill<setShape>(shape: setShape) -> some View
    //TODO: se løsning, brug rawvalues for cleanness
    where setShape: Shape {
        switch card.fill {
        case .fill:       shape.fillAndBorder()
        case .stripes:    shape.stripe()
        case .none:       shape.stroke(lineWidth: 2)
        }
    }
}

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Model.Card(shape: .diamond, color: .pink, fill: .none, numberOfShapes: .two, isSelected: true, id: 1)
        CardView(card: card)
            .overlay(
                RoundedRectangle( cornerRadius: 10)
                    .stroke(Color.blue, lineWidth: 2)
            )
            .padding()
    }
}
