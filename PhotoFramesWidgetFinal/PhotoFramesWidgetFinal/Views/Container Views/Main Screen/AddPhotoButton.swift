//
//  AddPhotoButton.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/6/20.
//

import SwiftUI
import PhotosUI

struct AddPhotoButton: View {
    
    //passed vars
    var parentGeoSize: CGSize
    
    //Animation
    @State var goHome: Bool = false
    @State var showingImagePicker: Bool = false
    @State var showAccessDeniedAlert: Bool = false
    @State private var selectedImages = false
    @State private var doneCropping = false
    
    //Image picker
    @State var imgIDs: [String]?
    @State var inputImages: [UIImage]?
    @State var scaleFactors: [CGFloat]?
    @State var transforms: [CGSize]?
    @State var croppedImages: [UIImage]?
    @State var numMissingPhotos: Int = 0
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    @State var customColor: Color = Color.gray
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        Button(action: {
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                switch status {
                    case .authorized, .limited:
                        showingImagePicker = true
                    case .denied, .restricted:
                        showAccessDeniedAlert = true
                    default:
                        showingImagePicker = false
                }
            }
        }) {
            ZStack {
                RoundedRectangle(cornerRadius: parentGeoSize.height / 25 < 32 ? parentGeoSize.height / 25 : 32, style: .continuous)
                    .foregroundColor(.primary)
                
                HStack(spacing: 12) {
                    Text("Add Your Photo")
                        .font(.system(size: parentGeoSize.width / 20 < 25 ? parentGeoSize.width / 20 : 25, weight: .bold, design: .rounded))
                        .foregroundColor(colorScheme == .light ? .white : .black)
                    Image(systemName: "plus")
                        .font(.system(size: parentGeoSize.width / 20 < 25 ? parentGeoSize.width / 20 : 25, weight: .bold, design: .rounded))
                        .foregroundColor(colorScheme == .light ? .white : .black)
                }
            }
            .frame(width: parentGeoSize.height / 2.75 < 375 ? parentGeoSize.height / 2.75 : 375, height: parentGeoSize.height / 9 < 100 ? parentGeoSize.height / 9 : 100)
        }
        .offset(y: (UIDevice.current.userInterfaceIdiom == .pad && showingImagePicker) ? 250 : 0)
        .animation(.spring())
        .alert(isPresented: $showAccessDeniedAlert) {
            Alert(title: Text("Photos Access Denied"), message: Text("Please allow photos access through the settings app."), dismissButton: .default(Text("Dismiss")))
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: { if selectedImages{ selectedImages = false; inputImages = nil; doneCropping = false; scaleFactors = nil; transforms = nil; croppedImages = nil } }) {
            ZStack {
                Color(.white)
                    .edgesIgnoringSafeArea(.all)
                
                Rectangle()
                    .fill(RadialGradient(gradient: Gradient(colors: colorScheme == .light ? [Color.black.opacity(0.025), Color.white, Color.black.opacity(0.025)] : [Color.black.opacity(0.95), Color.black, Color.black.opacity(0.95)]), center: .center, startRadius: 0, endRadius: 1))
                    .edgesIgnoringSafeArea(.all)
                    .padding(-10)
                
                if !selectedImages {
                    MultiImagePicker(selectionLimit: 4, images: $inputImages, photoIDs: $imgIDs, numMissingPhotos: $numMissingPhotos)
                        .edgesIgnoringSafeArea(.all)
                } else {
                    if !doneCropping {
                        if let imgs = inputImages {
                            if imgs.count > 0 {
                                GeometryReader { sheetGeo in
                                    ImageCroppingView(images: imgs, parentGeoSize: sheetGeo.size, croppedImages: $croppedImages, scaleFactors: $scaleFactors, transforms: $transforms)
                                        .transition(.move(edge: .trailing))
                                        .alert(isPresented: .constant(numMissingPhotos > 0)) {
                                            Alert(title: Text("Unable to Load \(numMissingPhotos) Photo\(numMissingPhotos > 1 ? "s" : "")"),
                                                  message: Text("If you gave limited photos access, you can add more photos or enable access to all your photos through the settings app."),
                                                  dismissButton: .default(Text("Dismiss"))
                                            )
                                        }
                                }
                            } else {
                                Color(#colorLiteral(red: 0.1608511458, green: 0.1741570506, blue: 0.1934872252, alpha: 1))
                                    .edgesIgnoringSafeArea(.all)
                                    .padding(-10)
                                    .alert(isPresented: .constant(imgs.count <= 0)) {
                                        Alert(title: Text("Unable to Load Any Photos"),
                                              message: Text("If you gave limited photos access, you can add more photos or enable access to all your photos through the settings app."),
                                              dismissButton: Alert.Button.default(
                                                Text("Go Back"), action: { goHome = true }
                                              )
                                        )
                                    }
                            }
                        }
                    } else {
                        ZStack {
                            Color(.white)
                                .edgesIgnoringSafeArea(.all)

                            Rectangle()
                                .fill(RadialGradient(gradient: Gradient(colors: colorScheme == .light ? [Color.black.opacity(0.05), Color.white, Color.black.opacity(0.05)] : [Color.black.opacity(0.90), Color.black, Color.black.opacity(0.90)]), center: .center, startRadius: 0, endRadius: 1))
                                .edgesIgnoringSafeArea(.all)
                                .padding(-10)
                            
                            if let img = croppedImages {
                                CategorySelectionView(images: $croppedImages, content: getFrameArray(img: img, transforms: [], scaleFactors: [], customColor: customColor, isPreview: true),  scaleFactors: $scaleFactors, transforms: $transforms, imgIds: $imgIDs, goHome: $goHome, parentGeoSize: parentGeoSize, customColor: $customColor, storeManager: storeManager)
                            }
                        }
                        .transition(.move(edge: .trailing))
                    }
                }
            }
        }
        .onChange(of: inputImages) { _ in
            guard inputImages != nil else { return }
            withAnimation(.easeInOut) {
                selectedImages = true
            }
        }
        .onChange(of: croppedImages) { _ in
            guard croppedImages != nil else { return }
            guard croppedImages?.count == inputImages?.count else { return }
            
            //guard croppedImage?.count > 0 else { return }
            withAnimation(.easeInOut) {
                doneCropping = true
            }
        }
        .onChange(of: goHome) { _ in
            if goHome {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
                    showingImagePicker = false
                    goHome = false
                }
            }
        }
    }
}
