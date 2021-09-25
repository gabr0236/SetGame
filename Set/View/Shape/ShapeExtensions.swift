//
//  ShapeExtensions.swift
//  Set
//
//  Created by Gabriel Haugbøl on 25/09/2021.
//

import SwiftUI

extension Shape {
    
    func stripe(_ lineWidth: CGFloat = 2) -> some View {
        ZStack {
            StripedRect().stroke().clipShape(self)
            self.stroke(lineWidth: lineWidth)
        }
    }
    
    func fillAndBorder(_ lineWidth: CGFloat = 2) -> some View {
        ZStack {
            self.fill()
            self.stroke(lineWidth: lineWidth)
        }
    }
}
