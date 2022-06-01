//
//  ImageCroppingView.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 11/13/20.
//

//replaced all 'currentImg' with 'images[imgIndex]'

import SwiftUI

struct ImageCroppingView: View {
    
    //passed vars
    @State var images: [UIImage]
    var parentGeoSize: CGSize
    @Binding var croppedImages: [UIImage]?
    @Binding var scaleFactors: [CGFloat]?
    @Binding var transforms: [CGSize]?
    
    //local vars
    @State private var currentScaleFactor = CGFloat(1.0)
    @State private var scaleFactor = CGFloat(1.0)
    @State private var currentTransform: CGSize = .zero
    @State private var transform: CGSize = .zero
    @State private var moving = false
    @State private var imgIndex = 0
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    
    var magnification: some Gesture {
        MagnificationGesture()
            .onChanged() { value in
                moving = true
                currentScaleFactor = value.magnitude * scaleFactor
            }
        
            .onEnded() { value in
                moving = false
                currentScaleFactor = value.magnitude * scaleFactor
                if currentScaleFactor < 1.0 {
                    currentScaleFactor = 1.0
                }
                if currentScaleFactor > 5.0 {
                    currentScaleFactor = 5.0
                }
                scaleFactor = currentScaleFactor

                // keep in the frame
                let limits = getLimits()
                if currentTransform.width < -1 * limits.width {
                    currentTransform.width = -1 * limits.width
                }
                if currentTransform.width > limits.width {
                    currentTransform.width = limits.width
                }
                if currentTransform.height < -1 * limits.height {
                    currentTransform.height = -1 * limits.height
                }
                if currentTransform.height > limits.height {
                    currentTransform.height = limits.height
                }
            }
    }
    
    var draggable: some Gesture {
        DragGesture()
            .onChanged { value in
                moving = true
                currentTransform = CGSize(width: value.translation.width + transform.width, height: value.translation.height + transform.height)
            }
            
            .onEnded { value in
                moving = false
                currentTransform = CGSize(width: value.translation.width + transform.width, height: value.translation.height + transform.height)

                // keep in the frame
                let limits = getLimits()
                if currentTransform.width < -1 * limits.width {
                    currentTransform.width = -1 * limits.width
                }
                if currentTransform.width > limits.width {
                    currentTransform.width = limits.width
                }
                if currentTransform.height < -1 * limits.height {
                    currentTransform.height = -1 * limits.height
                }
                if currentTransform.height > limits.height {
                    currentTransform.height = limits.height
                }
                
                transform = currentTransform
            }
    }
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack {
                    
                    if imgIndex < images.count {
                        Image(uiImage: images[imgIndex])
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 250 * currentScaleFactor, height: 250 * currentScaleFactor)
                            .offset(x: currentTransform.width, y: currentTransform.height)
                            .animation(.interactiveSpring(response: 0.35, dampingFraction: 0.60, blendDuration: 0.5))
                    }
                }
                .frame(width: 250, height: 250)
                .offset(y: 35)
                
                Blur(style: .systemUltraThinMaterial)
                    .edgesIgnoringSafeArea(.all)
                    .mask (
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .edgesIgnoringSafeArea(.all)
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .foregroundColor(.black)
                                .frame(width: 250, height: 250)
                                .offset(y: 35)
                        }
                        .compositingGroup()
                        .luminanceToAlpha()
                    )
                    .opacity(moving ? 1 : 0)
                    .animation(Animation.easeInOut.delay(moving ? 0 : 0.15))
                
                Blur()
                    .edgesIgnoringSafeArea(.all)
                    .mask (
                        ZStack {
                            Rectangle()
                                .foregroundColor(.white)
                                .edgesIgnoringSafeArea(.all)
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .foregroundColor(.black)
                                .frame(width: 250, height: 250)
                                .offset(y: 35)
                        }
                        .compositingGroup()
                        .luminanceToAlpha()
                    )
                    .opacity(moving ? 0 : 1)
                    .animation(Animation.easeInOut.delay(moving ? 0.15 : 0))
                
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .stroke(lineWidth: 10)
                    .frame(width: 250, height: 250)
                    .opacity(0.75)
                    .offset(y: 35)
                
                Color.black.opacity(0.00000000001)
                    .padding(.top, parentGeoSize.height / 4)
                    .gesture(draggable)
                    .gesture(magnification)
            }
            .scaleEffect(((parentGeoSize.width / 250) / 1.25) < 1.5 ? ((parentGeoSize.width / 250) / 1.25) : 1.5)
            
            VStack {
                RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                    .frame(width: 50, height: 7.5)
                    .foregroundColor(.secondary)
                    .opacity(0.50)
                    .padding(.top, 20)
                
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text("Position")
                            .font(.system(size: parentGeoSize.height / 12 < 125 ? parentGeoSize.height / 15 : 125, weight: .heavy, design: .default))
                            .foregroundColor(.primary)
                            .frame(height: parentGeoSize.height / 20)
                        Text("the photo in the frame")
                            .font(.system(size: parentGeoSize.height / 30 < 50 ? parentGeoSize.height / 30 : 50, weight: .heavy, design: .default))
                            .foregroundColor(.primary)
                            .frame(height: parentGeoSize.height / 18)
                        HStack {
                            Image(systemName: "hand.draw.fill")
                                .font(.system(size: parentGeoSize.height / 22 < 80 ? parentGeoSize.height / 22 : 80, weight: .regular, design: .rounded))
                                .foregroundColor(.secondary)
                            Text("Drag image")
                                .font(.system(size: parentGeoSize.height / 40 < 40 ? parentGeoSize.height / 40 : 40, weight: .bold, design: .default))
                                .foregroundColor(.secondary)
                        }
                        .frame(height: parentGeoSize.height / 16)
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .font(.system(size: parentGeoSize.height / 22 < 80 ? parentGeoSize.height / 22 : 80, weight: .regular, design: .rounded))
                                .foregroundColor(.secondary)
                            Text("Pinch to zoom")
                                .font(.system(size: parentGeoSize.height / 40 < 40 ? parentGeoSize.height / 40 : 40, weight: .bold, design: .default))
                                .foregroundColor(.secondary)
                        }
                        .frame(height: parentGeoSize.height / 20)
                    }
                    
                    Spacer()
                }
                .padding(.horizontal, 25)
                .padding(.top, parentGeoSize.height / 40 - 10)
                
                Spacer()
                
                HStack {
                    if images.count > 1 {
                        ProgressBar(width: 250 * (((parentGeoSize.width / 250) / 1.25) < 1.75 ? ((parentGeoSize.width / 250) / 1.25) : 1.75) - (parentGeoSize.height / 8.5), numIndices: images.count, currentIndex: imgIndex)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        if let croppedCGImage = cropImage() {
                            //Crop image and append array
                            if croppedImages != nil {
                                croppedImages?.append(croppedCGImage)
                            } else {
                                croppedImages = [croppedCGImage]
                            }
                            
                            //Append scale and transform
                            if scaleFactors != nil {
                                scaleFactors?.append(currentScaleFactor)
                            } else {
                                scaleFactors = [currentScaleFactor]
                            }
                            if transforms != nil {
                                let normalizedTransform = CGSize(width: currentTransform.width / 250, height: currentTransform.height / 250)
                                transforms?.append(normalizedTransform)
                            } else {
                                let normalizedTransform = CGSize(width: currentTransform.width / 250, height: currentTransform.height / 250)
                                transforms = [normalizedTransform]
                            }
                            
                            //Reset transform and scale
                            currentScaleFactor = CGFloat(1.0)
                            scaleFactor = CGFloat(1.0)
                            currentTransform = CGSize.zero
                            transform = CGSize.zero
                            
                            //Switch to next image
                            if imgIndex < images.count - 1 {
                                imgIndex += 1
                            }
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                                .opacity(0.75)
                            Image(systemName: "chevron.right")
                                .font(.system(size: parentGeoSize.height / 15 < 40 ? parentGeoSize.height / 15 : 40, weight: .heavy, design: .rounded))
                                .foregroundColor(colorScheme == .light ? Color.white : Color.black)
                        }
                    }
                    .frame(width: parentGeoSize.height / 8.5 < 75 ? parentGeoSize.height / 8.5 : 75, height: parentGeoSize.height / 8.5 < 75 ? parentGeoSize.height / 8.5 : 75)
                }
                .padding(.trailing, parentGeoSize.width / 10)
                .padding(.bottom, 70)
                .offset(y: 50)
            }
        }
    }
    
    func getCropRect() -> CGRect {
        let factor = (images[imgIndex].size.height > images[imgIndex].size.width ? images[imgIndex].size.width : images[imgIndex].size.height)/250
        let origin = getOrigin(factor: factor)
        let scaleFactor = (images[imgIndex].size.height > images[imgIndex].size.width ? images[imgIndex].size.width : images[imgIndex].size.height)/250
        let size = CGSize(width: scaleFactor * (250 / currentScaleFactor), height: scaleFactor * (250 / currentScaleFactor))
        let rect = CGRect(origin: origin, size: size)
        
        return rect
    }
    
    func cropImage() -> UIImage? {
        //get rect
        let rect = getCropRect()
        
        //get image
        let image = images[imgIndex]
        
        //fix for rotating:
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        image.draw(at: CGPoint(x: -rect.origin.x, y: -rect.origin.y))
        let croppedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return croppedImage
    }
    
    func cropImage2() -> UIImage? {
        //get rect
        let rect = getCropRect()
        
        //get image
        guard let cgImage = images[imgIndex].cgImage else { return nil }
        
        //crop image
        guard let croppedImg = cgImage.cropping(to: rect) else { return nil }
        
        return UIImage(cgImage: croppedImg, scale: 1.0, orientation: .up)
    }
    
    func getOrigin(factor: CGFloat) -> CGPoint {
        let xCorrection = images[imgIndex].size.width > images[imgIndex].size.height ? (((250 * images[imgIndex].size.width / images[imgIndex].size.height) / 2 * currentScaleFactor) - (125 * currentScaleFactor)) : 0
        let yCorrection = images[imgIndex].size.height > images[imgIndex].size.width ? (((250 * images[imgIndex].size.height / images[imgIndex].size.width) / 2 * currentScaleFactor) - (125 * currentScaleFactor)) : 0
        let x = factor * ((-1 * (currentTransform.width - xCorrection) / currentScaleFactor) + ((250 - (250 / currentScaleFactor)) / 2))
        let y = factor * ((-1 * (currentTransform.height - yCorrection) / currentScaleFactor) + ((250 - (250 / currentScaleFactor)) / 2))
        return CGPoint(x: x, y: y)
    }
    
    func getLimits() -> (width: CGFloat, height: CGFloat) {
        var widthLimit: CGFloat
        var heightLimit : CGFloat
        
        if images[imgIndex].size.height > images[imgIndex].size.width {
            widthLimit = abs(((currentScaleFactor * 250) - 250) / 2)
            heightLimit = abs(((currentScaleFactor * 250 * images[imgIndex].size.height / images[imgIndex].size.width) - 250) / 2)
        } else {
            widthLimit = abs(((currentScaleFactor * 250 * images[imgIndex].size.width / images[imgIndex].size.height) - 250) / 2)
            heightLimit = abs(((currentScaleFactor * 250) - 250) / 2)
        }
        
        return (widthLimit, heightLimit)
    }
}

struct Blur: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial
    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: style))
    }
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
