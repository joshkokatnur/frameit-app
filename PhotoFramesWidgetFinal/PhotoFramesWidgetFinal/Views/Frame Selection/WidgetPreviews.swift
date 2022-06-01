//
//  WidgetPreviews.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/5/20.
//

import SwiftUI

struct WidgetPreviews: View {
    
    var content: [AnyView]
    var randRotation: [Double]
    var loaded: Bool
    var usersName: String?
    
    //pager variables
    @Binding var pagerOffset: CGFloat
    @Binding var scrollOffset: CGFloat
    
    //misc
    var parentGeoSize: CGSize
    
    var body: some View {
        LazyHStack(spacing: 0) {
            ForEach(0..<content.count, id: \.self) { i in
                ZStack {
                    if loaded {
                        WidgetPreview(i: i, randRotation: randRotation, content: content)
                            .frame(width: 250 * (parentGeoSize.height / 650), height: 250 * (parentGeoSize.height / 650))
                    }
                }
                .frame(width: parentGeoSize.width, height: parentGeoSize.height - 400)
            }
        }
        .hpager(geometryWidth: parentGeoSize.width, contentCount: content.count, pagerOffset: usersName != nil ? .constant(pagerOffset) : $pagerOffset, scrollOffset: usersName != nil ? .constant(scrollOffset): $scrollOffset)
        .offset(x: parentGeoSize.width * CGFloat(content.count - 1) / 2)
    }
}
