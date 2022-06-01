//
//  WidgetTitles.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/5/20.
//

import SwiftUI

struct WidgetTitles: View {
    
    var contentNames: [[String]]
    var pagerOffset: CGFloat
    var parentGeoSize: CGSize
    
    var body: some View {
        ZStack {
            ForEach(0..<contentNames.count, id: \.self) { i in
                HStack {
                    VStack(alignment: .leading) {
                        Text(contentNames[i][0])
                            .font(.system(size: parentGeoSize.height / 16, weight: .heavy, design: .default))
                            .foregroundColor(.primary)
                            
                        Text(contentNames[i][1])
                            .font(.system(size: parentGeoSize.height / 36, weight: .bold, design: .default))
                            .foregroundColor(.secondary)
                            .padding(.leading, parentGeoSize.width / 125 < 6.67 ? parentGeoSize.width / 125 : 6.67)
                    }
                    .opacity((CGFloat(i) ==  CGFloat(pagerOffset * -1)) ? 1 : 0)
                    .offset(x: 100 * CGFloat(i))
                    
                    Spacer()
                }
                .frame(width: parentGeoSize.width)
            }
        }
    }
}
