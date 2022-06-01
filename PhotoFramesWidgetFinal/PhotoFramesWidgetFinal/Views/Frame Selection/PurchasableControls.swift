//
//  PurchasableControls.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 1/5/21.
//

import SwiftUI

struct PurchasableControls: View {
    
    //passed vars
    var catIndex: Int
    var pagerOffset: CGFloat
    var parentGeoSize: CGSize
    var randRotation: [Double]
    @Binding var presentPromotion: Bool
    @Binding var customColor: Color
    @Binding var images: [UIImage]?
    @Binding var scaleFactors: [CGFloat]?
    @Binding var transforms: [CGSize]?
    @Binding var imgIds: [String]?
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        if let iapProduct = storeManager.productDict[catIndex == 1 ? "com.JoshK.customFrameColor" : "com.JoshK.collageFrames"] {
            ZStack {
                if UserDefaults.standard.bool(forKey: catIndex == 1 ? "com.JoshK.customFrameColor" : "com.JoshK.collageFrames") {
                    HStack(spacing: parentGeoSize.width / 20) {
                        if catIndex == 3 {
                            Button(action: {
                                //Check for nil values
                                guard let imgs = images else { return }
                                guard let sfs = scaleFactors else { return }
                                guard let transf = transforms else { return }
                                guard let ids = imgIds else { return }
                                
                                //Generate shuffled indices
                                let shuffled_indices = imgs.indices.shuffled()
                                
                                //Apply indices to each array
                                images = shuffled_indices.map { imgs[$0] }
                                scaleFactors = shuffled_indices.map { sfs[$0] }
                                transforms = shuffled_indices.map { transf[$0] }
                                imgIds = shuffled_indices.map { ids[$0] }
                            }) {
                                Image(systemName: "arrow.right.arrow.left.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.secondary)
                            }
                            .frame(width: parentGeoSize.height / 15 < 55 ? parentGeoSize.height / 15 : 55, height: parentGeoSize.height / 15 < 55 ? parentGeoSize.height / 15 : 55)
                        } else {
                            Color.clear
                                .frame(width: parentGeoSize.height / 15 < 55 ? parentGeoSize.height / 15 : 55, height: parentGeoSize.height / 15 < 55 ? parentGeoSize.height / 15 : 55)
                        }
                        
                        ColorPicker(selection: $customColor, supportsOpacity: false, label: {})
                            .labelsHidden()
                            .scaleEffect(1.6)
                    }
                } else {
                    Button(action: {
                        presentPromotion = true
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: .infinity)
                                .foregroundColor(.blue)
                            
                            Text(iapProduct.getFormattedPrice() ?? "$-.--")
                                .foregroundColor(.white)
                                .bold()
                        }
                        .frame(width: parentGeoSize.height / 8 < 100 ? parentGeoSize.height / 8 : 100, height: parentGeoSize.height / 15 < 50 ? parentGeoSize.height / 15 : 50)
                    }
                    .sheet(isPresented: $presentPromotion) {
                        if catIndex == 1 { //ASDFASDFASDFASDFASDFASDFASDF
                            CustomColorPromotion(parentGeoSize: parentGeoSize, product: iapProduct, rotationAngle: randRotation[0], presentSheet: $presentPromotion, storeManager: storeManager)
                        } else {
                            CollagesPromotion(parentGeoSize: parentGeoSize, product: iapProduct, rotationAngle: randRotation[0], presentSheet: $presentPromotion, storeManager: storeManager)
                        }
                    }
                }
            }
            .opacity(catIndex == 1 ? (pagerOffset == -5 || pagerOffset == -6 ? 1 : 0) : (catIndex == 3 ? 1 : 0))
        }
    }
}
