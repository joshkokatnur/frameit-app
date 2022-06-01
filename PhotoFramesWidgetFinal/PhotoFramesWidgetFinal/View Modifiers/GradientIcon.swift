//
//  test.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 9/21/20.
//

import SwiftUI

struct GradientIcon: View {
    
    var name: String
    var size: CGFloat
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9490196078, green: 0.7568627451, blue: 0.3058823529, alpha: 1)), Color(#colorLiteral(red: 0.968627451, green: 0.5058823529, blue: 0.3294117647, alpha: 1)), Color(#colorLiteral(red: 0.7058823529, green: 0.262745098, blue: 0.4235294118, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
            .frame(width: size, height: size)
            .mask(Image(systemName: name).font(.system(size: size * 0.85, weight: .semibold, design: .rounded)))
    }
}

struct GradientIcon_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color(#colorLiteral(red: 0.1806417031, green: 0.1806417031, blue: 0.1806417031, alpha: 1))
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            GradientIcon(name: "crop", size: 200)
        }
    }
}
