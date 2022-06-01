//
//  MainTabView.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/6/20.
//

import SwiftUI

struct MainTabView: View {
    
    @State var currentTab = 0
    var parentGeoSize: CGSize
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Picker(selection: $currentTab.animation(.spring()), label: Text("")) {
                    Text("Instructions").tag(0)
                    Text("My Frames").tag(1)
                }.pickerStyle(SegmentedPickerStyle())
                .padding(.horizontal, geo.size.width / 12)
                .animation(.spring())

                ZStack {
                    InstructionsView(geo: geo.size)
                        .frame(width: geo.size.width)
                        .mask(Rectangle().padding(.vertical, -100))
                        .padding(.top, 17.5)
                        .offset(x: currentTab == 0 ? 0 : parentGeoSize.width * -1)
                    
                    FramesList(parentGeoSize: parentGeoSize)
                        .frame(width: geo.size.width - 50)
                        .mask(RoundedRectangle(cornerRadius: 25, style: .continuous))
                        .frame(width: geo.size.width)
                        .offset(x: currentTab == 1 ? 0 : parentGeoSize.width)
                }
                .padding([.top, .bottom], pow(geo.size.height / 40, geo.size.height / 450) < 35 ? pow(geo.size.height / 40, geo.size.height / 450) : 35)
            }
        }
    }
}
