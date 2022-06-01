//
//  InstructionsTitles.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/6/20.
//

import SwiftUI

struct InstructionsTitles: View {
    
    var titles2: [[String]] = [
        ["Choose", "a photo from your photo gallery"],
        //["Crop", "your photo to size"],
        ["Select", "a photo frame"],
        ["Long Press", "your homescreen to access the widget panel"]
    ]
    var titles: [[LocalizedStringKey]] = [
        ["Choose", "a photo from your photo gallery"],
        //["Crop", "your photo to size"],
        ["Select", "a photo frame"],
        ["Long Press", "your homescreen to access the widget panel"]
    ]
    var pagerOffset: CGFloat
    var parentGeoSize: CGSize
    let hello = LocalizedStringKey("Hello")
    
    var body: some View {
        ZStack {
            ForEach(0..<titles.count, id: \.self) { i in
                HStack {
                    VStack(alignment: .leading) {
                        Text(titles[i][0])
                            .font(.system(size: parentGeoSize.height / 12, weight: .heavy, design: .default)) //45
                            .foregroundColor(.primary)
                            
                        Text(titles[i][1])
                            .font(.system(size: parentGeoSize.height / 40, weight: .bold, design: .default)) //15
                            .foregroundColor(.secondary)
                            .padding(.leading, parentGeoSize.width / 125)
                    }
                    .opacity((CGFloat(i) ==  CGFloat(pagerOffset * -1)) ? 1 : 0)
                    .offset(x: 100 * CGFloat(i))
                    
                    Spacer()
                }
                .frame(width: parentGeoSize.width, height: parentGeoSize.height / 100)
            }
        }
    }
}
