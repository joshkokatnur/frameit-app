//
//  ResponseAlert.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/5/20.
//

import SwiftUI

struct ResponseAlert: View {
    @Binding var successCase: Int
    
    var body: some View {
        if successCase != 0 {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.secondary.opacity(0.75))
                VStack(spacing: 15) {
                    Image(systemName: successCase == 1 ? "checkmark" : "xmark")
                        .font(.system(size: 50, weight: .heavy, design: .rounded))
                        .foregroundColor(.white)
                        .opacity(0.75)
                    
                    Text(successCase == 1 ? "Success" : "Error")
                        .font(.system(size: 40, weight: .heavy, design: .default))
                        .foregroundColor(.white)
                        .opacity(0.75)
                    
                    Text(successCase == 1 ? "Add the frame from the widget panel." : "Please try again.")
                        .font(.system(size: 15, weight: .bold, design: .default))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.white)
                        .padding(.horizontal)
                        .opacity(0.5)
                }
            }
        }
    }
}
