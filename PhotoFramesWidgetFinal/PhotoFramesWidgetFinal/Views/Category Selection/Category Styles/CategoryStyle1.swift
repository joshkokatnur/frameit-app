//
//  CategoryStyle1.swift
//  PhotoFramesWidget
//
//  Created by Josh Kokatnur on 8/30/20.
//

import SwiftUI

struct CategoryStyle1: View {
    
    //content
    var content: [AnyView]
    //var content: [Color]
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(colorScheme == .light ? .white : #colorLiteral(red: 0.1740885377, green: 0.1891232431, blue: 0.2092809081, alpha: 1)))
                .shadow(color: (colorScheme == .light ? Color.black.opacity(0.10) : Color.black.opacity(0.50)), radius: 25)
            
            VStack {
                HStack {
                    content[0]
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    content[1]
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
                HStack {
                    content[2]
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    content[3]
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
                HStack {
                    content[4]
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    content[5]
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
                HStack {
                    content[6]
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                    content[7]
                        .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
                }
            }
            .padding(.all, 25)
            .compositingGroup()
            .shadow(color: (colorScheme == .light ? Color.black.opacity(0.25) : Color.black.opacity(0.90)), radius: 25)
        }
        .frame(width: 300, height: 560)
    }
}

struct CategoryStyle1_Previews: PreviewProvider {
    static var previews: some View {
        CategoryStyle1(content: [AnyView(Color.red), AnyView(Color.blue), AnyView(Color.green), AnyView(Color.orange), AnyView(Color.purple), AnyView(Color.pink), AnyView(Color.orange), AnyView(Color.yellow)])
            .frame(width: 300, height: 560)
    }
}
