//
//  VPager.swift
//  PhotoFramesWidget
//
//  Created by Josh Kokatnur on 8/30/20.
//

import SwiftUI

struct VPagerModifier: ViewModifier {
    
    //passed variables
    var geometryHeight: CGFloat
    var contentCount: Int

    @Binding var pagerOffset: CGFloat
    @Binding var scrollOffset: CGFloat
    
    //local variables
    @State private var firstSwipe = true
    
    func body(content: Content) -> some View {
        content
            .offset(y: scrollOffset)
            .offset(y: pagerOffset * geometryHeight)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.scrollOffset = gesture.translation.height
                        if firstSwipe { withAnimation(.spring()) {scrollOffset = 0}; firstSwipe = false } //temp bug fix
                    }

                    .onEnded { gesture in
                        withAnimation(.spring()) {
                            scrollOffset = 0
                        }
                        if pagerOffset < 0 && gesture.predictedEndTranslation.height >= geometryHeight / 2 {
                            withAnimation(.spring()) {
                                pagerOffset += ceil(gesture.predictedEndTranslation.height / geometryHeight / 2) //1
                                if pagerOffset > 0 { pagerOffset = 0 }
                                //pagerOffset += 1
                            }
                        }
                        if pagerOffset > CGFloat((contentCount - 1) * -1) && gesture.predictedEndTranslation.height <= geometryHeight / -2 {
                            withAnimation(.spring()) {
                                pagerOffset -= ceil(gesture.predictedEndTranslation.height / geometryHeight / -2) //1
                                if pagerOffset < CGFloat((contentCount - 1) * -1) { pagerOffset = CGFloat((contentCount - 1) * -1) }
                                //pagerOffset -= 1
                            }
                        }
                    }
            )
    }
}

extension View {
    func vpager(geometryHeight: CGFloat, contentCount: Int, pagerOffset: Binding<CGFloat>, scrollOffset: Binding<CGFloat>) -> some View {
        self.modifier(VPagerModifier(geometryHeight: geometryHeight, contentCount: contentCount, pagerOffset: pagerOffset, scrollOffset: scrollOffset))
    }
}
