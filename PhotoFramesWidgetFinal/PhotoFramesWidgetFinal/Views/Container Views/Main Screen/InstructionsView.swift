//
//  InstructionsView.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/6/20.
//

import SwiftUI

struct InstructionsView: View {

    var geo: CGSize
    
    //pager variables
    @State var pagerOffset: CGFloat = 0
    @State var scrollOffset: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 0) {
            InstructionsTitles(pagerOffset: pagerOffset, parentGeoSize: geo)
                .offset(x: scrollOffset / 5)
                .offset(x: pagerOffset * 100)
                .padding(.leading, geo.width / 6)
                .padding(.bottom)
            
            LazyHStack(spacing: 0) {
                ForEach(0..<3, id: \.self) { i in
                    ZStack {
                        Ins_Container(index: i)
                            .frame(width: 300, height: 300)
                            .scaleEffect(geo.height / 500)
                    }
                    .frame(width: geo.width, height: geo.height)
                    .background(Color.white.opacity(0.0000001))
                }
            }
            .hpager(geometryWidth: geo.width, contentCount: 3, pagerOffset: $pagerOffset, scrollOffset: $scrollOffset)
            .offset(x: geo.width)
            
            ProgressBar(width: 250, numIndices: 3, currentIndex: Int(pagerOffset * -1))
        }
    }
}
