//
//  ListWidgetPreview.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/26/20.
//

import SwiftUI

struct ListWidgetPreview: View {
    
    var imgObject: Entity
    
    var body: some View {
        guard let imgIds = imgObject.imageIdentifiers else { return AnyView(Text("")) }
        guard let transformsData = imgObject.transforms else { return AnyView(Text("")) }
        guard let scaleFactorsData = imgObject.scaleFactors else { return AnyView(Text("")) }
        guard let croppingData = convertToData(transformsData: transformsData, scaleFactorsData: scaleFactorsData) else { return AnyView(Text("")) }
        guard let customColor = imgObject.customColor else { return AnyView(Text("")) }
        let categoryId = Int(imgObject.categoryId)
        let frameId = Int(imgObject.frameId)
        guard let images = getSmallAssetThumbnailsFromIds(IDs: imgIds) else { return AnyView(Text("")) }
        
        return getFrameArray(img: images, transforms: croppingData.transforms, scaleFactors: croppingData.scaleFactors, customColor: Color(UIColor(hex: customColor) ?? UIColor.gray), isPreview: true)[categoryId][frameId]
    }
}
