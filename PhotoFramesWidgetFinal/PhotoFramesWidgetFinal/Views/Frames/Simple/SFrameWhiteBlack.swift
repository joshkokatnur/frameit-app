//
//  SFrameWhiteBlack.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

struct SFrameWhiteBlack: View {
    
    var image: UIImage
    var transform: CGSize
    var scaleFactor: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white
                Color.black
                    .frame(width: geo.size.width - (geo.size.height / 7.5), height: geo.size.height - (geo.size.height / 7.5))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                    .innerShadow(radius: 5, color: UIColor.black.withAlphaComponent(0.25))
                CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor, geoSize: CGSize(width: geo.size.width - (geo.size.height / 3.75), height: geo.size.height - (geo.size.height / 3.75)))
                    .frame(width: geo.size.width - (geo.size.height / 3.75), height: geo.size.height - (geo.size.height / 3.75))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
        }
    }
}

struct SFrameWhiteBlack_Previews: PreviewProvider {
    static var previews: some View {
        SFrameWhiteBlack(image: UIImage(color: UIColor.init(white: 0.75, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .background(Color.black.frame(width: 1000, height: 1000).edgesIgnoringSafeArea(.all))
    }
}
