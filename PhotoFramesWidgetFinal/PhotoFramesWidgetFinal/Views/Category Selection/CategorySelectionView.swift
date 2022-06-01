//
//  CategorySelectionView.swift
//  PhotoFramesWidget
//
//  Created by Josh Kokatnur on 8/30/20.
//

import SwiftUI

struct CategorySelectionView: View {
    
    @Binding var images: [UIImage]?

    var content: [[AnyView]]
    @Binding var scaleFactors: [CGFloat]?
    @Binding var transforms: [CGSize]?
    @Binding var imgIds: [String]?
    @Binding var goHome: Bool
    
    @State var contentNames: [[String]] = [
        ["Modern", "Contemporary Frames"],
        ["Colorful", "Brighten Up Your Homescreen"],
        ["Classic", "Timeless Frames"],
        ["Collages", "Pushing Boundaries"]
    ]
    
    //pager variables
    @State var pagerOffset: CGFloat = 0
    @State var scrollOffset: CGFloat = 0
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    var parentGeoSize: CGSize
    @Binding var customColor: Color
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                    .frame(width: 50, height: 7.5)
                    .foregroundColor(.secondary)
                    .opacity(0.50)
                    .padding(.top, 20)
                
                VStack(spacing: parentGeoSize.height / 40) {
                    CategoryTitles(contentNames: contentNames, pagerOffset: pagerOffset, parentGeoSize: parentGeoSize)
                        .offset(x: scrollOffset / 5)
                        .offset(x: pagerOffset * 100)
                        .padding(.leading, (parentGeoSize.width - geo.size.width))
                        .padding(.leading, parentGeoSize.width / 10)
                    
                    ZStack {
                        ForEach((0..<content.count).reversed(), id: \.self) { i in
                            CategoryPreview(images: $images, goHome: $goHome, content: content, scaleFactors: $scaleFactors, transforms: $transforms, imgIds: $imgIds, i: i, pagerOffset: pagerOffset * -1, parentGeoSize: parentGeoSize, customColor: $customColor, storeManager: storeManager)
                                .offset(x: i == Int(pagerOffset * -1) ? scrollOffset / 2 : 0)
                                .offset(x: i < Int(pagerOffset * -1) ? -1000 : 0)
                        }
                        .offset(x: -15)
                    }
                    .padding(.horizontal)
                    .spager(geometryWidth: parentGeoSize.width, contentCount: content.count, pagerOffset: $pagerOffset, scrollOffset: $scrollOffset)
                    .scaleEffect(parentGeoSize.height / 850 < 1.15 ? parentGeoSize.height / 850 : 1.15)
                    .frame(height: (parentGeoSize.height / 850 < 1.15 ? parentGeoSize.height / 850 : 1.15) * 560)
                }
                .padding(.top, parentGeoSize.height / 60)
                
                Spacer()
                
                ProgressBar(width: 250, numIndices: content.count, currentIndex: Int(pagerOffset * -1))
                
                Spacer()
            }
            .frame(width: parentGeoSize.width - (parentGeoSize.width - geo.size.width), height: parentGeoSize.height - (parentGeoSize.height - geo.size.height))
        }
        .ignoresSafeArea(.keyboard)
    }
}
