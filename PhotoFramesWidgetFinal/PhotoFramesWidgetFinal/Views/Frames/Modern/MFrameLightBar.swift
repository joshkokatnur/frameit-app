//
//  MFrameLightBar.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

struct MFrameLightBar: View {
    
    var image: UIImage
    var transform: CGSize
    var scaleFactor: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color.white
                CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor, geoSize: CGSize(width: geo.size.width - (geo.size.width / 8), height: geo.size.height - (geo.size.width / 8)))
                    .frame(width: geo.size.width - (geo.size.width / 8), height: geo.size.height - (geo.size.width / 8))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                    .innerShadow(radius: 20, color: UIColor.white.withAlphaComponent(1))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            }
        }
    }
}

struct MFrameLightBar_Previews: PreviewProvider {
    static var previews: some View {
        MFrameLightBar(image: UIImage(color: UIColor.init(white: 0.25, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .background(Color.black.frame(width: 1000, height: 1000).edgesIgnoringSafeArea(.all))
    }
}
