//
//  NumSelector.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 9/23/20.
//

import SwiftUI

struct NumSelector: View {
    
    //passed variables
    @Binding var num: Int
    var width: CGFloat
    var numIndices: Int
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 75/CGFloat(numIndices)) {
            ForEach(0..<numIndices, id: \.self) { i in
                Button(action: {
                    withAnimation(.easeInOut) {
                        num = i
                    }
                }) {
                    Image(systemName: "\(i+1).square\(i == num ? ".fill" : "")")
                        .font(.system(size: width / 8, weight: .regular, design: .rounded))
                        .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                }
            }
        }
        .frame(width: width, height: 10)
    }
}

struct NumSelector_Previews: PreviewProvider {
    static var previews: some View {
        NumSelector(num: .constant(3), width: 250, numIndices: 5)
    }
}
