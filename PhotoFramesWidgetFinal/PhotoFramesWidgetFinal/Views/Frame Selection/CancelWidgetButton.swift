//
//  CancelWidgetButton.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 1/5/21.
//

import SwiftUI

struct CancelWidgetButton: View {
    
    @Binding var usersName: String?
    var parentGeoSize: CGSize
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                usersName = nil
            }
        }) {
            //VStack {
            ZStack {
                Capsule()
                    .fill(Color(#colorLiteral(red: 1, green: 0.2891697336, blue: 0.2661444429, alpha: 1)))
                    .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.9455142617, green: 0.9456467032, blue: 0.9454725385, alpha: 1)) : Color(#colorLiteral(red: 0.09797564894, green: 0.09799588472, blue: 0.09796922654, alpha: 1)), radius: 20)
                    .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.9455142617, green: 0.9456467032, blue: 0.9454725385, alpha: 1)) : Color(#colorLiteral(red: 0.09797564894, green: 0.09799588472, blue: 0.09796922654, alpha: 1)), radius: 20)
                    .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.9455142617, green: 0.9456467032, blue: 0.9454725385, alpha: 1)) : Color(#colorLiteral(red: 0.09797564894, green: 0.09799588472, blue: 0.09796922654, alpha: 1)), radius: 20)
                    .shadow(color: colorScheme == .light ? Color(#colorLiteral(red: 0.9455142617, green: 0.9456467032, blue: 0.9454725385, alpha: 1)) : Color(#colorLiteral(red: 0.09797564894, green: 0.09799588472, blue: 0.09796922654, alpha: 1)), radius: 20)
                Image(systemName: "xmark")
                    .font(.system(size: parentGeoSize.width / 20 < 30 ? parentGeoSize.width / 20 : 30, weight: .heavy, design: .rounded))
                    .foregroundColor(.white)
            }
            .frame(width: parentGeoSize.height / 10 < 75 ? parentGeoSize.height / 10 : 75, height: parentGeoSize.height / 12 < 60 ? parentGeoSize.height / 12 : 60)
        }
    }
}
