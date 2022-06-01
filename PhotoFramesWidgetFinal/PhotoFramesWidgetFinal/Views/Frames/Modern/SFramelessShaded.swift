//
//  SFrameless.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

struct SFramelessShaded: View {
    
    var image: UIImage
    var transform: CGSize
    var scaleFactor: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor, geoSize: geo.size)
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .innerShadow(radius: 15, color: UIColor.black.withAlphaComponent(0.4))
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
            }
        }
    }
}

struct SFramelessShaded_Previews: PreviewProvider {
    static var previews: some View {
        SFramelessShaded(image: UIImage(color: UIColor.init(white: 1, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
            .background(Color.black.frame(width: 1000, height: 1000).edgesIgnoringSafeArea(.all))
    }
}
