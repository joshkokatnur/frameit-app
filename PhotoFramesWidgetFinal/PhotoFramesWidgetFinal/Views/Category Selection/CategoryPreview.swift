//
//  CategoryPreview.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/5/20.
//

import SwiftUI

struct CategoryPreview: View {
    
    @Binding var images: [UIImage]?
    @Binding var goHome: Bool
    
    //passed vars
    var content: [[AnyView]]
    @Binding var scaleFactors: [CGFloat]?
    @Binding var transforms: [CGSize]?
    @Binding var imgIds: [String]?
    var i: Int
    var pagerOffset: CGFloat
    
    //local vars
    @State var showingDetail = false
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    var parentGeoSize: CGSize
    @Binding var customColor: Color
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        HStack {
            CategoryStyles(styleIndex: 5, content: content[i])
        }
        .offset(x: i < Int(pagerOffset + 3) ? (CGFloat(i) - pagerOffset) * 30 : 60)
        .offset(x: pagerOffset >= CGFloat(content.count - 2) ? (pagerOffset - CGFloat(content.count - 3)) * 15 : 0)
        .scaleEffect(downscaleComponents(i: i))
        .onTapGesture {
            showingDetail.toggle()
        }
        .overlay(
            FrameSelectionTimer(images: $images, goHome: $goHome, showingDetail: $showingDetail, content: content[i], scaleFactors: $scaleFactors, transforms: $transforms, imgIds: $imgIds, catIndex: i, parentGeoSize: CGSize(width: parentGeoSize.width < 834 ? parentGeoSize.width : 834, height: parentGeoSize.height < 1092 ? parentGeoSize.height : 1092), customColor: $customColor, storeManager: storeManager)
        )
    }
    
    func downscaleComponents(i: Int) -> CGFloat {
        return i < Int(pagerOffset + 3) ? 1 - ((CGFloat(i) - pagerOffset) / 20) : 1 - (CGFloat(pagerOffset + 3) / 20)
    }
}
