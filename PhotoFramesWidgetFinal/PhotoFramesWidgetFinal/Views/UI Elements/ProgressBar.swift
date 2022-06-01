//
//  ProgressBar.swift
//  PhotoFramesWidget
//
//  Created by Josh Kokatnur on 8/28/20.
//

import SwiftUI

struct ProgressBar: View {
    
    //passed variables
    var width: CGFloat
    var numIndices: Int
    var currentIndex: Int
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: width/CGFloat(numIndices * 2)) {
            ForEach(0..<numIndices, id: \.self) { i in
                RoundedRectangle(cornerRadius: i == currentIndex ? 4 : .infinity, style: .continuous)
                    .fill(colorScheme == .light ? Color.black.opacity(i == currentIndex ? 1 : 0.25) : Color.white.opacity(i == currentIndex ? 1 : 0.25))
                    .frame(width: 10, height: 10)
                    .scaleEffect(i == currentIndex ? 1.8 : 1)
            }
        }
        .frame(width: width, height: 10)
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(width: 250, numIndices: 5, currentIndex: 2)
    }
}
