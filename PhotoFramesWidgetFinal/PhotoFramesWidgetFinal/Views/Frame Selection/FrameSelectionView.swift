//
//  FrameSelectionView.swift
//  PhotoFramesWidget
//
//  Created by Josh Kokatnur on 8/22/20.
//

import SwiftUI
import CoreData
import WidgetKit

struct FrameSelectionView: View {
    
    @Binding var images: [UIImage]?
    
    @Binding var goHome: Bool
    
    //Animation
    @State var showingWidgetPage: Bool = false
    @State var usersName: String?
    @State var successCase: Int = 0
    @State var appeared = false
    @State var rotAngle: Double = 0
    
    //content
    var content: [AnyView]
    @Binding var scaleFactors: [CGFloat]?
    @Binding var transforms: [CGSize]?
    @Binding var imgIds: [String]?
    var contentNames: [[[String]]] =
        [
            [
                ["Rounded", "black border with white offset"],
                ["White Border", "with white glow"],
                ["Thin", "black border"],
                ["Classic", "black border with white offset"],
                ["Thin", "white border"],
                ["Simple", "without border"]
            ],
            [
                ["Red", "thin border"],
                ["Blue", "thin border"],
                ["Purple", "thin border"],
                ["Green", "thin border"],
                ["Yellow", "thin border"],
                ["Custom", "thin border"],
                ["Custom", "thick border"],
                ["Red", "thick border"],
                ["Blue", "thick border"],
                ["Purple", "thick border"],
                ["Green", "thick border"],
                ["Yellow", "thick border"],
                ["Custom", "thick border"]
            ],
            [
                ["Birch", "with gray offset"],
                ["Oak", "with white offset"],
                ["Walnut", "with white offset"],
                ["Oak", "with no offset"],
                ["Walnut", "with gray offset"],
                ["Birch", "with no offset"],
                ["Birch", "with white offset"],
                ["Walnut", "with no offset"],
                ["Oak", "with gray offset"]
            ],
            [
                ["2 images", "style #1"],
                ["2 images", "style #2"],
                ["3 images", "style #1"],
                ["3 images", "style #2"],
                ["3 images", "style #3"],
                ["3 images", "style #4"],
                ["2 images", "with triangular frames"],
                ["4 images", "style #1"],
                ["2 images", "with circular frames"],
                ["3 images", "with circular frames"]
            ]
        ]
    
    var randRotation: [Double]
    var loaded: Bool
    var catIndex: Int
    
    //pager variables
    @State var pagerOffset: CGFloat = 0
    @State var scrollOffset: CGFloat = 0
    
    //local anim vars
    var duration: Double = 3
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    var parentGeoSize: CGSize
    @Binding var customColor: Color
    @State var presentPromotion = false
    
    //iaps
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
                    ZStack {
                        WidgetTitles(contentNames: contentNames[catIndex], pagerOffset: pagerOffset, parentGeoSize: parentGeoSize)
                            .offset(x: scrollOffset / 5)
                            .offset(x: pagerOffset * 100)
                            .padding(.leading, (parentGeoSize.width - geo.size.width))
                            .padding(.leading, parentGeoSize.width / 10)
                        
                        HStack {
                            Spacer()
                            
                            if usersName == nil {
                                PurchasableControls(catIndex: catIndex, pagerOffset: pagerOffset, parentGeoSize: parentGeoSize, randRotation: randRotation, presentPromotion: $presentPromotion, customColor: $customColor, images: $images, scaleFactors: $scaleFactors, transforms: $transforms, imgIds: $imgIds, storeManager: storeManager)
                            } else {
                                CancelWidgetButton(usersName: $usersName, parentGeoSize: parentGeoSize)
                            }
                        }
                        .frame(width: parentGeoSize.width - (parentGeoSize.width - geo.size.width))
                        .padding(.trailing, parentGeoSize.width / 8)
                    }
                    
                    WidgetPreviews(content: content, randRotation: randRotation, loaded: loaded, usersName: usersName, pagerOffset: $pagerOffset, scrollOffset: $scrollOffset, parentGeoSize: parentGeoSize)
                        .frame(width: 300 * (parentGeoSize.height / 650), height: 300 * (parentGeoSize.height / 650))
                }
                .padding(.top, parentGeoSize.height / 60)
                
                Spacer()
                
                ZStack {
                    if let name = usersName {
                        HStack(spacing: 0) {
                            Text("\"\(name)")
                                .font(.system(size: 35, weight: .heavy, design: .default))
                            Text("\"")
                                .font(.system(size: 35, weight: .heavy, design: .default))
                        }
                    } else {
                        ProgressBar(width: parentGeoSize.height / 2.85 < 350 ? parentGeoSize.height / 2.85 : 350, numIndices: content.count, currentIndex: Int(pagerOffset * -1))
                    }
                }
                
                Spacer()
                
                AddWidgetButton(goHome: $goHome, presentPromotion: $presentPromotion, showingWidgetPage: $showingWidgetPage, usersName: $usersName, successCase: $successCase, pagerIndex: Int(pagerOffset), content: content, scaleFactors: scaleFactors, transforms: transforms, imgIds: imgIds, randRotation: randRotation, catIndex: catIndex, parentGeoSize: parentGeoSize, customColor: customColor, needsPayment: (catIndex == 1 ? (pagerOffset == -5 || pagerOffset == -6 ? true : false) : (catIndex == 3 ? true : false)), paidForService: UserDefaults.standard.bool(forKey: catIndex == 1 ? "com.JoshK.customFrameColor" : "com.JoshK.collageFrames"))
                
                Spacer()
            }
            .frame(width: parentGeoSize.width - (parentGeoSize.width - geo.size.width))
        }
        .ignoresSafeArea(.keyboard)
        .scaleEffect(showingWidgetPage ? 1.1 : (successCase != 0 ? 1.05 : 1))
        .blur(radius: showingWidgetPage ? 25 : (successCase != 0 ? 15 : 0))
        .opacity(showingWidgetPage ? 0.25 : (successCase != 0 ? 0.25 : 1))
        .textFieldAlert(isPresented: $showingWidgetPage) { () -> TextFieldAlert in
            TextFieldAlert(title: "Name Your Frame:", message: nil, text: $usersName)
        }
        .overlay(
            ResponseAlert(successCase: $successCase)
                .frame(width: 250, height: 250)
        )
    }
}
