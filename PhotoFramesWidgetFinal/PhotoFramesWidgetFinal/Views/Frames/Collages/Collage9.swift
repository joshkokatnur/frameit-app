//
//  Collage9.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 11/2/20.
//

import SwiftUI

struct Collage9: View {
    
    var frameColor: Color
    var images: [UIImage]
    var transforms: [CGSize]
    var scaleFactors: [CGFloat]
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                frameColor
                
                ZStack(alignment: .topLeading) {
                    Color.clear
                    CroppedImage(image: images[0], transform: transforms[0], scaleFactor: scaleFactors[0], geoSize: CGSize(width: geo.size.width / 1.75, height: geo.size.width / 1.75))
                        .frame(width: geo.size.width / 1.75, height: geo.size.width / 1.75)
                        .clipShape(Circle())
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(Circle())
                }
                .padding()
                
                ZStack(alignment: .bottomTrailing) {
                    Color.clear
                    CroppedImage(image: images[1], transform: transforms[1], scaleFactor: scaleFactors[1], geoSize: CGSize(width: geo.size.width / 2.4, height: geo.size.width / 2.4))
                        .frame(width: geo.size.width / 2.4, height: geo.size.width / 2.4)
                        .clipShape(Circle())
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(Circle())
                }
                .padding()
            }
        }
    }
}
