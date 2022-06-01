//
//  CategoryStyles.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/5/20.
//

import SwiftUI

struct CategoryStyles: View {
    
    var styleIndex: Int
    var content: [AnyView]
    
    var body: some View {
        ZStack {
            switch styleIndex {
                case 1: CategoryStyle1(content: content)
                case 2: CategoryStyle2(content: content)
                case 3: CategoryStyle3(content: content)
                case 4: CategoryStyle4(content: content)
                case 5: CategoryStyle5(content: content)
                default: CategoryStyle1(content: content)
            }
        }
    }
}
