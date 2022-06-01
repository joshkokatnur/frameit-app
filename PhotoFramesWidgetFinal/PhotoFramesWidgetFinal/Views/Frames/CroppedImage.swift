//
//  CroppedImage.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/23/20.
//

import SwiftUI

struct CroppedImage: View {
    
    var image: UIImage
    var transform: CGSize
    var scaleFactor: CGFloat
    var geoSize: CGSize
    
    var body: some View {
        if geoSize.height > geoSize.width * 1.5 {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geoSize.height * scaleFactor, height: geoSize.height * scaleFactor)
                .offset(CGSize(width: transform.width * geoSize.height, height: transform.height * geoSize.height))
        } else if geoSize.width > geoSize.height * 1.5 {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geoSize.width * scaleFactor, height: geoSize.width * scaleFactor)
                .offset(CGSize(width: transform.width * geoSize.width, height: transform.height * geoSize.width))
        } else {
            Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geoSize.width * scaleFactor, height: geoSize.height * scaleFactor)
                .offset(CGSize(width: transform.width * geoSize.width, height: transform.height * geoSize.height))
        }
    }
}
