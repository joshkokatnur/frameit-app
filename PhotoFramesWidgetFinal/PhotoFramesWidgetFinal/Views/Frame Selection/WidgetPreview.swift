//
//  WidgetPreview.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/5/20.
//

import SwiftUI

struct WidgetPreview: View {
    
    //passed vars
    var i: Int
    var randRotation: [Double]
    var content: [AnyView]
    
    //local vars
    var rotRadius: Double = 5
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .foregroundColor(colorScheme == .light ? Color.black.opacity(0.35) : Color.black.opacity(0.75))
                .rotation3DEffect(Angle(degrees: 35), axis: (trigXY(sine: false, num: randRotation[i]), trigXY(sine: true, num: randRotation[i]), 0))
                .blur(radius: colorScheme == .light ? 30 : 40)
            content[i]
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                .rotation3DEffect(Angle(degrees: rotRadius * cos(randRotation[i])), axis: (1, 0, 0))
                .rotation3DEffect(Angle(degrees: rotRadius * sin(randRotation[i])), axis: (0, 1, 0))
                .rotation3DEffect(Angle(degrees: rotRadius/2 * sin(randRotation[i])), axis: (0, 0, 1))
        }
    }
    
    func trigXY(sine: Bool, num: Double) -> CGFloat {
        if sine {
            return CGFloat(sin(num))
        } else {
            return CGFloat(cos(num))
        }
    }
}
