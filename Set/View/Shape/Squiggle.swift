//
//  Squiggle.swift
//  Set
//
//  Created by Gabriel Haugbøl on 25/09/2021.
//

import SwiftUI


struct Squiggle: Shape {
    
    func path(in rect: CGRect) -> Path {
        var upper =  Path()
        let sqdx = rect.width * 0.1
        let sqdy = rect.height * 0.2
        
        upper.move(to: CGPoint(x: rect.minX,y: rect.midY))
        upper.addCurve(to: CGPoint(x: rect.minX + rect.width * 1/2,
                                   y: rect.minY + rect.height / 8),
            control1: CGPoint(x: rect.minX,y: rect.minY),
            control2: CGPoint(x: rect.minX + rect.width * 1/2 - sqdx,
                              y: rect.minY + rect.height / 8 - sqdy))
        
        upper.addCurve(to: CGPoint(x: rect.minX + rect.width * 4/5,
                                   y: rect.minY + rect.height / 8),
            control1: CGPoint(x: rect.minX + rect.width * 1/2 + sqdx,
                              y: rect.minY + rect.height / 8 + sqdy),
            control2: CGPoint(x: rect.minX + rect.width * 4/5 - sqdx,
                              y: rect.minY + rect.height / 8 + sqdy))
 
        upper.addCurve(to: CGPoint(x: rect.minX + rect.width,
                                   y: rect.minY + rect.height / 2),
            control1: CGPoint(x: rect.minX + rect.width * 4/5 + sqdx,
                              y: rect.minY + rect.height / 8 - sqdy ),
            control2: CGPoint(x: rect.minX + rect.width,
                              y: rect.minY))
   
        var lower = upper
        lower = lower.applying(CGAffineTransform.identity.rotated(by: CGFloat.pi))
        lower = lower.applying(CGAffineTransform.identity
                    .translatedBy(x: rect.size.width, y: rect.size.height))
        upper.move(to: CGPoint(x: rect.minX, y: rect.midY))
        upper.addPath(lower)
        return upper
    }
}

struct Squiggle_Preview: PreviewProvider {
    static var previews: some View {
        VStack {
            Squiggle().stroke(lineWidth: 5)
            Squiggle().fillAndBorder(5)
            Squiggle().stripe(5)
            
        }.padding()
    }
}

