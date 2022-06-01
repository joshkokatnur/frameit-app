//
//  SFrame2.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

struct SFrameThinBorderShaded: View {
    
    var frameColor: Color
    var image: UIImage
    var transform: CGSize
    var scaleFactor: CGFloat
    var preview: Bool
    
    var body: some View {
        GeometryReader { geo in
            if preview {
                ZStack {
                    frameColor
                    CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor, geoSize: CGSize(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15)))
                        .frame(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                }
            } else {
                ZStack {
                    frameColor
                    CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor, geoSize: CGSize(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15)))
                        .frame(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15))
                        .clipShape(ContainerRelativeShape())
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(ContainerRelativeShape())
                }
            }
        }
    }
}

struct SFrameThinBorderShaded_Previews: PreviewProvider {
    static var previews: some View {
        SFrameThinBorderShaded(frameColor: Color.black, image: UIImage(color: UIColor.init(white: 1, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0, preview: true)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}
