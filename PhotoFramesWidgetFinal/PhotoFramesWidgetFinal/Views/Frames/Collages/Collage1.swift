//
//  Collage1.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 11/1/20.
//

import SwiftUI

struct Collage1: View {
    
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
                    HStack(spacing: geo.size.width / 30) {
                        CroppedImage(image: images[0], transform: transforms[0], scaleFactor: scaleFactors[0], geoSize: CGSize(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height - (geo.size.width / 15)))
                            .frame(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height - (geo.size.width / 15))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        
                        CroppedImage(image: images[1], transform: transforms[1], scaleFactor: scaleFactors[1], geoSize: CGSize(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height - (geo.size.width / 15)))
                            .frame(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height - (geo.size.width / 15))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                            .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    }
                }
            } else {
                ZStack {
                    frameColor
                    HStack(spacing: geo.size.width / 30) {
                        CroppedImage(image: images[0], transform: transforms[0], scaleFactor: scaleFactors[0], geoSize: CGSize(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height - (geo.size.width / 15)))
                            .frame(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height - (geo.size.width / 15))
                            .clipShape(ContainerRelativeShape())
                            .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                            .clipShape(ContainerRelativeShape())
                        
                        CroppedImage(image: images[1], transform: transforms[1], scaleFactor: scaleFactors[1], geoSize: CGSize(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height - (geo.size.width / 15)))
                            .frame(width: geo.size.width / 2 - (geo.size.width / 20), height: geo.size.height - (geo.size.width / 15))
                            .clipShape(ContainerRelativeShape())
                            .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                            .clipShape(ContainerRelativeShape())
                    }
                }
            }
        }
    }
}
