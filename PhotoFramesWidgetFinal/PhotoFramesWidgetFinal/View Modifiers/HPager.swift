//
//  PagerView.swift
//  PhotoFramesWidget
//
//  Created by Josh Kokatnur on 8/22/20.
//

import SwiftUI

struct HPagerModifier: ViewModifier {
    
    //passed variables
    var geometryWidth: CGFloat
    var contentCount: Int
    
    @Binding var pagerOffset: CGFloat
    @Binding var scrollOffset: CGFloat
    
    //local variables
    @State private var firstSwipe = true
    
    func body(content: Content) -> some View {
        content
            .offset(x: scrollOffset)
            .offset(x: pagerOffset * geometryWidth)
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        self.scrollOffset = gesture.translation.width
                        if firstSwipe { withAnimation(.spring()) {scrollOffset = 0}; firstSwipe = false } //temp bug fix
                    }
                    
                    .onEnded { gesture in
                        withAnimation(.spring()) {
                            scrollOffset = 0
                        }
                        if pagerOffset < 0 && gesture.predictedEndTranslation.width >= geometryWidth / 2 {
                            withAnimation(.spring()) {
                                pagerOffset += ceil(gesture.predictedEndTranslation.width / geometryWidth / 2) //1
                                if pagerOffset > 0 { pagerOffset = 0 }
                            }
                        }
                        if pagerOffset > CGFloat((contentCount - 1) * -1) && gesture.predictedEndTranslation.width <= geometryWidth / -2 {
                            withAnimation(.spring()) {
                                pagerOffset -= ceil(gesture.predictedEndTranslation.width / geometryWidth / -2) //1
                                if pagerOffset < CGFloat((contentCount - 1) * -1) { pagerOffset = CGFloat((contentCount - 1) * -1) }
                            }
                        }
                    }
            )
    }
}

extension View {
    func hpager(geometryWidth: CGFloat, contentCount: Int, pagerOffset: Binding<CGFloat>, scrollOffset: Binding<CGFloat>) -> some View {
        self.modifier(HPagerModifier(geometryWidth: geometryWidth, contentCount: contentCount, pagerOffset: pagerOffset, scrollOffset: scrollOffset))
    }
}
