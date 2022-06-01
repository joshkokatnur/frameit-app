//
//  FrameSelectionTimer.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/5/20.
//

import SwiftUI

struct FrameSelectionTimer: View {
    
    @Binding var images: [UIImage]?
    @Binding var goHome: Bool
    
    ///The timer must be invalidated after sheet is dismissed to prevent memory leak
    //passed variables
    @Binding var showingDetail: Bool
    var content: [AnyView]
    @Binding var scaleFactors: [CGFloat]?
    @Binding var transforms: [CGSize]?
    @Binding var imgIds: [String]?
    var catIndex: Int
    
    //local variables
    @State var randRotation: [Double] = []
    @State var loaded = false
    @State var timer: Timer?
    @State var photoPickerImages: [UIImage]?
    @State private var selectedImages = false
    @State private var notEnoughPhotos = false
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    var parentGeoSize: CGSize
    @Binding var customColor: Color
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        EmptyView()
            .sheet(isPresented: $showingDetail, onDismiss: { timer?.invalidate(); customColor = Color.gray }) {
                ZStack {
                    Color(.white)
                        .edgesIgnoringSafeArea(.all)
                    
                    Rectangle()
                        .fill(RadialGradient(gradient: Gradient(colors: colorScheme == .light ? [Color.black.opacity(0.05), Color.white, Color.black.opacity(0.05)] : [Color.black.opacity(0.90), Color.black, Color.black.opacity(0.90)]), center: .center, startRadius: 0, endRadius: 1))
                        .edgesIgnoringSafeArea(.all)
                        .padding(-10)
                    
                    FrameSelectionView(images: $images, goHome: $goHome, content: content, scaleFactors: $scaleFactors, transforms: $transforms, imgIds: $imgIds, randRotation: randRotation, loaded: loaded, catIndex: catIndex, parentGeoSize: parentGeoSize, customColor: $customColor, storeManager: storeManager)
                        .alert(isPresented: $notEnoughPhotos) {
                            Alert(title: Text("Not Enough Photos"), message: Text("Please go back to the photo picker and select more than one photo."), dismissButton: .default(Text("Dismiss")))
                        }
                }
                .onAppear {
                    for _ in 0..<content.count {
                        randRotation.append(Double.random(in: 1...360))
                    }
                    
                    loaded = true
                    timer = Timer.scheduledTimer(withTimeInterval: 1/60, repeats: true) { timer in
                        for i in 0..<randRotation.count {
                            //randRotation[i] += 0.005
                            if randRotation[i] > 360 {
                                randRotation[i] = 0
                            }
                            randRotation[i] += 0.005
                        }
                    }
                    
                    if catIndex == 3 {
                        if let imgs = images {
                            if imgs.count <= 1 {
                                notEnoughPhotos = true
                            }
                        }
                    }
                }
            }
            .onChange(of: goHome) { _ in
                if goHome {
                    showingDetail = false
                }
            }
    }
}
