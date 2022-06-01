//
//  Main.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

struct Main: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                HStack {
                    AppIconFromBundle()
                        .frame(width: ((geo.size.height / 12) + 5) < 75 ? ((geo.size.height / 12) + 5) : 75, height: ((geo.size.height / 12) + 5) < 75 ? ((geo.size.height / 12) + 5) : 75)
                        .clipShape(RoundedRectangle(cornerRadius: geo.size.width / 32 < 15 ? geo.size.width / 32 : 15, style: .continuous)) //15
                        .padding([.trailing, .bottom], geo.size.width > geo.size.height ? geo.size.width / 150 : geo.size.height / 150)
                    
                    Text("FrameIt")
                        .font(.system(size: geo.size.height / 18, weight: .heavy, design: .rounded))
                        .fixedSize()
                        .offset(y: geo.size.width > geo.size.height ? geo.size.width / 125 : geo.size.height / 125)

                    Spacer()
                    
                    SupportPage(geoSize: geo.size, storeManager: storeManager)
                        .padding(.trailing, 2.5)
                        .offset(y: geo.size.height / 125)
                }
                .padding(.top, geo.size.height / 100)
                .padding(.horizontal, geo.size.height / 35) //50
                
                MainTabView(parentGeoSize: geo.size)
                    .padding(.top, geo.size.height / 125)
                    .padding(.bottom, geo.size.height / 75)
                
                AddPhotoButton(parentGeoSize: geo.size, storeManager: storeManager)
                    .padding(.bottom, 25)
            }
        }
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main(storeManager: StoreManager())
    }
}
