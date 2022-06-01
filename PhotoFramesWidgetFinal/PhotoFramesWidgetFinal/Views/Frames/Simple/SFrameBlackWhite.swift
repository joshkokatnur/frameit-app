//
//  Test2.swift
//  PhotoFramesWidget
//
//  Created by Josh Kokatnur on 8/22/20.
//

import SwiftUI

struct SFrameBlackWhite: View {
    
    var image: UIImage
    var transform: CGSize
    var scaleFactor: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.black
                Color.white
                    .frame(width: geo.size.width - (geo.size.height / 7.5), height: geo.size.height - (geo.size.height / 7.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .innerShadow(radius: 8, color: UIColor.black.withAlphaComponent(0.18))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor, geoSize: CGSize(width: geo.size.width - (geo.size.height / 3.75), height: geo.size.height - (geo.size.height / 3.75)))
                    .frame(width: geo.size.width - (geo.size.height / 3.75), height: geo.size.height - (geo.size.height / 3.75))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
        }
    }
}

struct SFrameBlackWhite_Previews: PreviewProvider {
    static var previews: some View {
        SFrameBlackWhite(image: UIImage(color: UIColor.init(white: 0.75, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}
