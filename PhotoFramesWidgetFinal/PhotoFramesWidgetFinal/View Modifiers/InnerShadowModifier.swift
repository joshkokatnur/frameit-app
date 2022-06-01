//
//  InnerShadowModifier.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

struct InnerShadow: ViewModifier {
    
    var radius: CGFloat
    var color: Color
    
    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(color, lineWidth: 25)
                    .blur(radius: radius)
            )
    }
}

extension View {
    func innerShadow(radius: CGFloat, color: UIColor) -> some View {
        self.modifier(InnerShadow(radius: radius, color: Color(color)))
    }
}
