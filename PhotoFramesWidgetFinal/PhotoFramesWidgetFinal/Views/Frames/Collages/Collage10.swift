//
//  Collage10.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 11/2/20.
//

import SwiftUI

struct Collage10: View {
    
    var frameColor: Color
    var images: [UIImage]
    var transforms: [CGSize]
    var scaleFactors: [CGFloat]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                frameColor
                
                HStack {
                    CroppedImage(image: images[0], transform: transforms[0], scaleFactor: scaleFactors[0], geoSize: CGSize(width: geo.size.width / 2.9, height: geo.size.width / 2.9))
                        .frame(width: geo.size.width / 2.9, height: geo.size.width / 2.9)
                        .clipShape(Circle())
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(Circle())
                    
                    Spacer()
                    
                    CroppedImage(image: images[1], transform: transforms[1], scaleFactor: scaleFactors[1], geoSize: CGSize(width: geo.size.width / 2, height: geo.size.width / 2))
                        .frame(width: geo.size.width / 2, height: geo.size.width / 2)
                        .clipShape(Circle())
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(Circle())
                        .offset(y: geo.size.width / -12) //-20
                }
                .offset(y: geo.size.width / -8) //-30
                .padding()
                
                VStack {
                    Spacer()
                    
                    CroppedImage(image: images[2], transform: transforms[2], scaleFactor: scaleFactors[2], geoSize: CGSize(width: geo.size.width / 2.4, height: geo.size.width / 2.4))
                        .frame(width: geo.size.width / 2.4, height: geo.size.width / 2.4)
                        .clipShape(Circle())
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(Circle())
                        .offset(x: geo.size.width / -25) //-12
                }
                .padding()
            }
        }
    }
}
