//
//  CFrameWoodenInset.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/10/20.
//

import SwiftUI

struct CFrameWoodenInset: View {
    
    var image: UIImage
    var transform: CGSize
    var scaleFactor: CGFloat
    var sideLength: CGFloat
    var colors: [Color]
    var insetColor: Color
    var insetLength: CGFloat
    
    var body: some View {
        GeometryReader { geo in
            if let frameScaleFactor = geo.size.width > geo.size.height ? geo.size.height / sideLength : geo.size.width / sideLength {
                ZStack {
                    VStack {
                        TrapezoidHorizontal(sideLength: frameScaleFactor)
                            .fill(colors[0])
                            .frame(height: frameScaleFactor)
                            .rotationEffect(.degrees(180))

                        Spacer()

                        TrapezoidHorizontal(sideLength: frameScaleFactor)
                            .fill(colors[1])
                            .frame(height: frameScaleFactor)
                    }
                    
                    HStack {
                        TrapezoidVertical(sideLength: frameScaleFactor)
                            .fill(colors[2])
                            .frame(width: frameScaleFactor)

                        Spacer()

                        TrapezoidVertical(sideLength: frameScaleFactor)
                            .fill(colors[3])
                            .frame(width: frameScaleFactor)
                            .rotationEffect(.degrees(180))
                    }

                    Rectangle()
                        .fill(insetColor)
                        .frame(width: geo.size.width - (frameScaleFactor * 2), height: geo.size.height - (frameScaleFactor * 2))
                        .innerShadow(radius: 8, color: UIColor.black.withAlphaComponent(0.35))
                        .clipShape(Rectangle())
                    
                    CroppedImage(image: image, transform: transform, scaleFactor: scaleFactor, geoSize: CGSize(width: geo.size.width - ((frameScaleFactor + insetLength) * 2), height: geo.size.height - ((frameScaleFactor + insetLength) * 2)))
                        .frame(width: geo.size.width - ((frameScaleFactor + insetLength) * 2), height: geo.size.height - ((frameScaleFactor + insetLength) * 2))
                        .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                        .innerShadow(radius: 8, color: UIColor.black.withAlphaComponent(0.15))
                        .clipShape(RoundedRectangle(cornerRadius: 0, style: .continuous))
                }
            }
        }
    }
}

struct CFrameWoodenInset_Previews: PreviewProvider {
    static var previews: some View {
        CFrameWoodenInset(image: UIImage(color: UIColor.init(white: 0.75, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0, sideLength: 10, colors: [Color(#colorLiteral(red: 0.3407418279, green: 0.2440783425, blue: 0.2044450967, alpha: 1)), Color(#colorLiteral(red: 0.2677954494, green: 0.1656715731, blue: 0.1249557668, alpha: 1)), Color(#colorLiteral(red: 0.3634063418, green: 0.2707037514, blue: 0.2326945223, alpha: 1)), Color(#colorLiteral(red: 0.311434266, green: 0.2111495771, blue: 0.1775175316, alpha: 1))], insetColor: Color.white, insetLength: 25)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        CFrameWoodenInset(image: UIImage(color: UIColor.init(white: 0.75, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0, sideLength: 10, colors: [Color(#colorLiteral(red: 0.8607996956, green: 0.8016034422, blue: 0.7156059902, alpha: 1)), Color(#colorLiteral(red: 0.7964732104, green: 0.7347453584, blue: 0.6557023771, alpha: 1)), Color(#colorLiteral(red: 0.8817690457, green: 0.8317802999, blue: 0.7520971272, alpha: 1)), Color(#colorLiteral(red: 0.8302592399, green: 0.7659129207, blue: 0.6835169722, alpha: 1))], insetColor: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), insetLength: 25)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        CFrameWoodenInset(image: UIImage(color: UIColor.init(white: 0.75, alpha: 1))!, transform: CGSize(width: 0, height: 0), scaleFactor: 1.0, sideLength: 10, colors: [Color(#colorLiteral(red: 0.7058823529, green: 0.5838325646, blue: 0.4658823529, alpha: 1)), Color(#colorLiteral(red: 0.6335329413, green: 0.4971391117, blue: 0.3801197648, alpha: 1)), Color(#colorLiteral(red: 0.7559280343, green: 0.6267364122, blue: 0.506471783, alpha: 1)), Color(#colorLiteral(red: 0.6853602423, green: 0.539481255, blue: 0.4112161454, alpha: 1))], insetColor: Color.white, insetLength: 25)
            .frame(width: 250, height: 250)
            .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
    }
}
