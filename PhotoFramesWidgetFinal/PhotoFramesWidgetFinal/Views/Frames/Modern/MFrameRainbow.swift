//
//  MFrameRainbow.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

struct MFrameRainbow: View {
    
    var image: UIImage
    var transform: CGSize
    var scaleFactor: CGFloat
    var lineWidth: CGFloat //smaller value is larger
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(#colorLiteral(red: 0.3845330477, green: 0.7319563031, blue: 0.277898699, alpha: 1))
                Color(#colorLiteral(red: 0.9638784528, green: 0.723330915, blue: 0.1595159173, alpha: 1))
                    .frame(width: geo.size.width - (geo.size.width / lineWidth), height: geo.size.height - (geo.size.width / lineWidth))
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                Color(#colorLiteral(red: 0.9461675286, green: 0.5090888143, blue: 0.1249013767, alpha: 1))
                    .frame(width: geo.size.width - 2 * (geo.size.width / lineWidth), height: geo.size.height - 2 * (geo.size.width / lineWidth))
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                Color(#colorLiteral(red: 0.8767367005, green: 0.2278866768, blue: 0.2413813174, alpha: 1))
                    .frame(width: geo.size.width - 3 * (geo.size.width / lineWidth), height: geo.size.height - 3 * (geo.size.width / lineWidth))
                    .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                Color(#colorLiteral(red: 0.5840501189, green: 0.2360412478, blue: 0.5910333991, alpha: 1))
                    .frame(width: geo.size.width - 4 * (geo.size.width / lineWidth), height: geo.size.height - 4 * (geo.size.width / lineWidth))
                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                Color(#colorLiteral(red: 0.2533113062, green: 0.6147560477, blue: 0.8574021459, alpha: 1))
                    .frame(width: geo.size.width - 5 * (geo.size.width / lineWidth), height: geo.size.height - 5 * (geo.size.width / lineWidth))
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor, geoSize: CGSize(width: geo.size.width - 6 * (geo.size.width / lineWidth), height: geo.size.height - 6 * (geo.size.width / lineWidth)))
                    .frame(width: geo.size.width - 6 * (geo.size.width / lineWidth), height: geo.size.height - 6 * (geo.size.width / lineWidth))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
        }
    }
}

struct MFrameRainbow_Previews: PreviewProvider {
    static var previews: some View {
        MFrameRainbow(image: UIImage(color: UIColor.init(white: 1, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0, lineWidth: 15)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}
