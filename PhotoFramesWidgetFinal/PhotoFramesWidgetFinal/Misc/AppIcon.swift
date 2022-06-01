//
//  test.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

struct AppIcon: View {
    
    var scale: CGFloat
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9490196078, green: 0.7568627451, blue: 0.3058823529, alpha: 1)), Color(#colorLiteral(red: 0.968627451, green: 0.5058823529, blue: 0.3294117647, alpha: 1)), Color(#colorLiteral(red: 0.7058823529, green: 0.262745098, blue: 0.4235294118, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                .frame(width: 250 * scale, height: 250 * scale)
                .clipShape(RoundedRectangle(cornerRadius: 50 * scale, style: .continuous))

            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1047792961)), Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.3485436937)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6031888435))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .frame(width: 150 * scale, height: 150 * scale)
                    .clipShape(RoundedRectangle(cornerRadius: 10 * scale, style: .continuous))

                RoundedRectangle(cornerRadius: 35 * scale, style: .continuous)
                    .stroke(lineWidth: 25 * scale)
                    .fill(Color.white)
                    .frame(width: 155 * scale, height: 155 * scale)
            }
            .rotation3DEffect(.degrees(-5), axis: (x: 0, y: 1, z: 0))
            .rotation3DEffect(.degrees(2), axis: (x: 1, y: 0, z: 0))
            .rotation3DEffect(.degrees(3), axis: (x: 0, y: 0, z: 1))
            .offset(x: -6 * scale, y: -0.5 * scale)
        }
    }
}

struct AppIcon_Previews: PreviewProvider {
    static var previews: some View {
        AppIcon(scale: 1)
    }
}
