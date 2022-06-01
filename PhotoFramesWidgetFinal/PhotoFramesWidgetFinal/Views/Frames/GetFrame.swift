//
//  GetFrame.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/20/20.
//

import SwiftUI

func getFrameArray(img: [UIImage], transforms: [CGSize], scaleFactors: [CGFloat], customColor: Color, isPreview: Bool) -> [[AnyView]] {
    var imgs = img
    if img.count < 4 {
        for _ in 1...(4 - img.count) {
            imgs.append(UIImage(color: UIColor.gray)!)
        }
    }
    var transf = transforms
    if transforms.count < 4 {
        for _ in 1...(4 - transforms.count) {
            transf.append(CGSize(width: 0, height: 0))
        }
    }
    var sfs = scaleFactors
    if scaleFactors.count < 4 {
        for _ in 1...(4 - scaleFactors.count) {
            sfs.append(1.0)
        }
    }
    return [
        [ // Modern
            AnyView(SFrameBlackWhite(image: imgs[0], transform: transf[0], scaleFactor: sfs[0])),
            AnyView(MFrameLightBar(image: imgs[0], transform: transf[0], scaleFactor: sfs[0])),
            AnyView(SFrameThinBorderShaded(frameColor: .black, image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(CFrameBlackWhite(image: imgs[0], transform: transf[0], scaleFactor: sfs[0])),
            AnyView(SFrameThinBorderShaded(frameColor: .white, image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameless(image: imgs[0], transform: transf[0], scaleFactor: sfs[0]))
        ],
        
        [ // Colorful
            AnyView(SFrameThinBorderShaded(frameColor: Color(#colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThinBorderShaded(frameColor: Color(#colorLiteral(red: 0, green: 0.4862745098, blue: 0.7450980392, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThinBorderShaded(frameColor: Color(#colorLiteral(red: 0.5411764706, green: 0.168627451, blue: 0.8862745098, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThinBorderShaded(frameColor: Color(#colorLiteral(red: 0, green: 0.6862745098, blue: 0.3294117647, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThinBorderShaded(frameColor: Color(#colorLiteral(red: 0.9843137255, green: 0.6862745098, blue: 0.1294117647, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThinBorderShaded(frameColor: customColor, image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThickBorderShaded(frameColor: customColor, image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThickBorderShaded(frameColor: Color(#colorLiteral(red: 1, green: 0.2705882353, blue: 0, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThickBorderShaded(frameColor: Color(#colorLiteral(red: 0, green: 0.4862745098, blue: 0.7450980392, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThickBorderShaded(frameColor: Color(#colorLiteral(red: 0.5411764706, green: 0.168627451, blue: 0.8862745098, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThickBorderShaded(frameColor: Color(#colorLiteral(red: 0, green: 0.6862745098, blue: 0.3294117647, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview)),
            AnyView(SFrameThickBorderShaded(frameColor: Color(#colorLiteral(red: 0.9843137255, green: 0.6862745098, blue: 0.1294117647, alpha: 1)), image: imgs[0], transform: transf[0], scaleFactor: sfs[0], preview: isPreview))
            //AnyView(MFrameRainbow(image: imgs[0], lineWidth: 15)),
            //AnyView(MFrameRainbowInverted(image: imgs[0], lineWidth: 15))
        ],
        
        [ // Classic
            AnyView(CFrameWoodenInset(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.8607996956, green: 0.8016034422, blue: 0.7156059902, alpha: 1)), Color(#colorLiteral(red: 0.7964732104, green: 0.7347453584, blue: 0.6557023771, alpha: 1)), Color(#colorLiteral(red: 0.8817690457, green: 0.8317802999, blue: 0.7520971272, alpha: 1)), Color(#colorLiteral(red: 0.8302592399, green: 0.7659129207, blue: 0.6835169722, alpha: 1))], insetColor: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), insetLength: 25)),
            AnyView(CFrameWoodenInset(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.7058823529, green: 0.5838325646, blue: 0.4658823529, alpha: 1)), Color(#colorLiteral(red: 0.6335329413, green: 0.4971391117, blue: 0.3801197648, alpha: 1)), Color(#colorLiteral(red: 0.7559280343, green: 0.6267364122, blue: 0.506471783, alpha: 1)), Color(#colorLiteral(red: 0.6853602423, green: 0.539481255, blue: 0.4112161454, alpha: 1))], insetColor: Color.white, insetLength: 25)),
            AnyView(CFrameWoodenInset(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.3407418279, green: 0.2440783425, blue: 0.2044450967, alpha: 1)), Color(#colorLiteral(red: 0.2677954494, green: 0.1656715731, blue: 0.1249557668, alpha: 1)), Color(#colorLiteral(red: 0.3634063418, green: 0.2707037514, blue: 0.2326945223, alpha: 1)), Color(#colorLiteral(red: 0.311434266, green: 0.2111495771, blue: 0.1775175316, alpha: 1))], insetColor: Color.white, insetLength: 25)),
            AnyView(CFrameWooden(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.7058823529, green: 0.5838325646, blue: 0.4658823529, alpha: 1)), Color(#colorLiteral(red: 0.6335329413, green: 0.4971391117, blue: 0.3801197648, alpha: 1)), Color(#colorLiteral(red: 0.7559280343, green: 0.6267364122, blue: 0.506471783, alpha: 1)), Color(#colorLiteral(red: 0.6853602423, green: 0.539481255, blue: 0.4112161454, alpha: 1))])),
            AnyView(CFrameWoodenInset(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.3407418279, green: 0.2440783425, blue: 0.2044450967, alpha: 1)), Color(#colorLiteral(red: 0.2677954494, green: 0.1656715731, blue: 0.1249557668, alpha: 1)), Color(#colorLiteral(red: 0.3634063418, green: 0.2707037514, blue: 0.2326945223, alpha: 1)), Color(#colorLiteral(red: 0.311434266, green: 0.2111495771, blue: 0.1775175316, alpha: 1))], insetColor: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), insetLength: 25)),
            AnyView(CFrameWooden(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.8607996956, green: 0.8016034422, blue: 0.7156059902, alpha: 1)), Color(#colorLiteral(red: 0.7964732104, green: 0.7347453584, blue: 0.6557023771, alpha: 1)), Color(#colorLiteral(red: 0.8817690457, green: 0.8317802999, blue: 0.7520971272, alpha: 1)), Color(#colorLiteral(red: 0.8302592399, green: 0.7659129207, blue: 0.6835169722, alpha: 1))])),
            AnyView(CFrameWoodenInset(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.8607996956, green: 0.8016034422, blue: 0.7156059902, alpha: 1)), Color(#colorLiteral(red: 0.7964732104, green: 0.7347453584, blue: 0.6557023771, alpha: 1)), Color(#colorLiteral(red: 0.8817690457, green: 0.8317802999, blue: 0.7520971272, alpha: 1)), Color(#colorLiteral(red: 0.8302592399, green: 0.7659129207, blue: 0.6835169722, alpha: 1))], insetColor: Color.white, insetLength: 25)),
            AnyView(CFrameWooden(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.3407418279, green: 0.2440783425, blue: 0.2044450967, alpha: 1)), Color(#colorLiteral(red: 0.2677954494, green: 0.1656715731, blue: 0.1249557668, alpha: 1)), Color(#colorLiteral(red: 0.3634063418, green: 0.2707037514, blue: 0.2326945223, alpha: 1)), Color(#colorLiteral(red: 0.311434266, green: 0.2111495771, blue: 0.1775175316, alpha: 1))])),
            AnyView(CFrameWoodenInset(image: imgs[0], transform: transf[0], scaleFactor: sfs[0], sideLength: 10, colors: [Color(#colorLiteral(red: 0.7058823529, green: 0.5838325646, blue: 0.4658823529, alpha: 1)), Color(#colorLiteral(red: 0.6335329413, green: 0.4971391117, blue: 0.3801197648, alpha: 1)), Color(#colorLiteral(red: 0.7559280343, green: 0.6267364122, blue: 0.506471783, alpha: 1)), Color(#colorLiteral(red: 0.6853602423, green: 0.539481255, blue: 0.4112161454, alpha: 1))], insetColor: Color(#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)), insetLength: 25))
        ],
        
        [ //Collages
            AnyView(Collage1(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs, preview: isPreview)),
            AnyView(Collage2(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs, preview: isPreview)),
            AnyView(Collage3(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs, preview: isPreview)),
            AnyView(Collage4(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs, preview: isPreview)),
            AnyView(Collage5(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs, preview: isPreview)),
            AnyView(Collage6(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs, preview: isPreview)),
            AnyView(Collage7(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs, preview: isPreview)),
            AnyView(Collage8(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs, preview: isPreview)),
            AnyView(Collage9(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs)),
            AnyView(Collage10(frameColor: customColor, images: imgs, transforms: transf, scaleFactors: sfs))
        ]
    ]
}
