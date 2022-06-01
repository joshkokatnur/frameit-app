//
//  Collage4.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 11/1/20.
//

import SwiftUI

struct Collage4: View {
    
    var frameColor: Color
    var images: [UIImage]
    var transforms: [CGSize]
    var scaleFactors: [CGFloat]
    var preview: Bool
    
    var body: some View {
        GeometryReader { geo in
            if preview {
                ZStack {
                    frameColor
                    VStack(spacing: geo.size.width / 30) {
                        HStack(spacing: geo.size.width / 30) {
                            CroppedImage(image: images[0], transform: transforms[0], scaleFactor: scaleFactors[0], geoSize: CGSize(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height / 2 - (geo.size.width / 20)))
                                .frame(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height / 2 - (geo.size.width / 20))
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                                .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            
                            CroppedImage(image: images[1], transform: transforms[1], scaleFactor: scaleFactors[1], geoSize: CGSize(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height / 2 - (geo.size.width / 20)))
                                .frame(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height / 2 - (geo.size.width / 20))
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                                .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        }
                        
                        CroppedImage(image: images[2], transform: transforms[2], scaleFactor: scaleFactors[2], geoSize: CGSize(width: geo.size.width - (geo.size.width / 15), height: geo.size.height / 2 - (geo.size.width / 20)))
                            .frame(width: geo.size.width - (geo.size.width / 15), height: geo.size.height / 2 - (geo.size.width / 20))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }
                }
            } else {
                ZStack {
                    frameColor
                    VStack(spacing: geo.size.width / 30) {
                        HStack(spacing: geo.size.width / 30) {
                            CroppedImage(image: images[0], transform: transforms[0], scaleFactor: scaleFactors[0], geoSize: CGSize(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height / 2 - (geo.size.width / 20)))
                                .frame(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height / 2 - (geo.size.width / 20))
                                .clipShape(ContainerRelativeShape())
                                .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                                .clipShape(ContainerRelativeShape())
                            
                            CroppedImage(image: images[1], transform: transforms[1], scaleFactor: scaleFactors[1], geoSize: CGSize(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height / 2 - (geo.size.width / 20)))
                                .frame(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height / 2 - (geo.size.width / 20))
                                .clipShape(ContainerRelativeShape())
                                .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                                .clipShape(ContainerRelativeShape())
                        }
                        
                        CroppedImage(image: images[2], transform: transforms[2], scaleFactor: scaleFactors[2], geoSize: CGSize(width: geo.size.width - (geo.size.width / 15), height: geo.size.height / 2 - (geo.size.width / 20)))
                            .frame(width: geo.size.width - (geo.size.width / 15), height: geo.size.height / 2 - (geo.size.width / 20))
                            .clipShape(ContainerRelativeShape())
                            .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                            .clipShape(ContainerRelativeShape())
                    }
                }
            }
        }
    }
}
