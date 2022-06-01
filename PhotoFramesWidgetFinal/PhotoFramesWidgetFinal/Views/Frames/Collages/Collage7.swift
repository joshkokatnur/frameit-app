//
//  Collage7.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 11/1/20.
//

import SwiftUI

struct Collage7: View {
    
    var frameColor: Color
    var images: [UIImage]
    var transforms: [CGSize]
    var scaleFactors: [CGFloat]
    var preview: Bool
    
    var body: some View {
        GeometryReader { geo in
            if preview {
                ZStack {
                    frameColor
                    CroppedImage(image: images[0], transform: transforms[0], scaleFactor: scaleFactors[0], geoSize: CGSize(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15)))
                        .frame(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .scaleEffect(1.4)
                        .offset(x: geo.size.width / -5, y: geo.size.height / -5)
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .clipShape(TriangleTopLeft(borderWidth: 5, radius: 5))
                    
                    CroppedImage(image: images[1], transform: transforms[1], scaleFactor: scaleFactors[1], geoSize: CGSize(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15)))
                        .frame(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .scaleEffect(1.4)
                        .offset(x: geo.size.width / 5, y: geo.size.height / 5)
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                        .clipShape(TriangleBottomRight(borderWidth: 5, radius: 5))
                }
            } else {
                ZStack {
                    frameColor
                    CroppedImage(image: images[0], transform: transforms[0], scaleFactor: scaleFactors[0], geoSize: CGSize(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15)))
                        .frame(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15))
                        .clipShape(ContainerRelativeShape())
                        .scaleEffect(1.4)
                        .offset(x: geo.size.width / -5, y: geo.size.height / -5)
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(ContainerRelativeShape())
                        .clipShape(TriangleTopLeft(borderWidth: 5, radius: 5))
                    
                    CroppedImage(image: images[1], transform: transforms[1], scaleFactor: scaleFactors[1], geoSize: CGSize(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15)))
                        .frame(width: geo.size.width - (geo.size.width / 15), height: geo.size.height - (geo.size.width / 15))
                        .clipShape(ContainerRelativeShape())
                        .scaleEffect(1.4)
                        .offset(x: geo.size.width / 5, y: geo.size.height / 5)
                        .innerShadow(radius: 10, color: UIColor.black.withAlphaComponent(0.2))
                        .clipShape(ContainerRelativeShape())
                        .clipShape(TriangleBottomRight(borderWidth: 5, radius: 5))
                }
            }
        }
    }
}

struct TriangleTopLeft: Shape {
    
    var borderWidth: CGFloat
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let point1 = CGPoint(x: rect.minX, y: rect.minY)
        let point2 = CGPoint(x: rect.minX, y: rect.maxY - borderWidth)
        let point3 = CGPoint(x: rect.maxX - borderWidth, y: rect.minY)
        
        return Path { path in
            path.move(to: point1)
            path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
            path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
            path.closeSubpath()
        }
    }
}

struct TriangleBottomRight: Shape {
    
    var borderWidth: CGFloat
    var radius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        
        let point1 = CGPoint(x: rect.maxX, y: rect.maxY)
        let point2 = CGPoint(x: rect.maxX, y: rect.minY + borderWidth)
        let point3 = CGPoint(x: rect.minX + borderWidth, y: rect.maxY)
        
        return Path { path in
            path.move(to: point1)
            path.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
            path.addArc(tangent1End: point2, tangent2End: point3, radius: radius)
            path.addArc(tangent1End: point3, tangent2End: point1, radius: radius)
            path.closeSubpath()
        }
    }
}
