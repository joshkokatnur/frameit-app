//
//  FramePlaceholderView.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/29/20.
//

import SwiftUI

struct FramePlaceholderView: View {
    
    @Environment(\.colorScheme) var colorScheme
    var preview: Bool
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                Color(colorScheme == .light ? #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                
                if preview {
                    Color(colorScheme == .light ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                        .frame(width: geo.size.width - (geo.size.height / 15), height: geo.size.height - (geo.size.height / 15))
                        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                } else {
                    Color(colorScheme == .light ? #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
                        .frame(width: geo.size.width - (geo.size.height / 15), height: geo.size.height - (geo.size.height / 15))
                        .clipShape(ContainerRelativeShape())
                }
                
                VStack {
                    HStack {
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9490196078, green: 0.7568627451, blue: 0.3058823529, alpha: 1)), Color(#colorLiteral(red: 0.968627451, green: 0.5058823529, blue: 0.3294117647, alpha: 1)), Color(#colorLiteral(red: 0.7058823529, green: 0.262745098, blue: 0.4235294118, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                .frame(width: 75, height: 75)
                                .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                            
                            ZStack {
                                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.1047792961)), Color(#colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.3485436937)), Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.6031888435))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                                    .frame(width: 45, height: 45)
                                    .clipShape(RoundedRectangle(cornerRadius: 0.333, style: .continuous))
                                
                                RoundedRectangle(cornerRadius: 10.5, style: .continuous)
                                    .stroke(lineWidth: 7.5)
                                    .fill(Color.white)
                                    .frame(width: 46.5, height: 46.5)
                            }
                            .rotation3DEffect(.degrees(5), axis: (x: 2, y: -5, z: 3))
                            .offset(x: -1.8, y: -0.3)
                        }
                        .scaleEffect(geo.size.height / 333)
                        .frame(width: geo.size.height / 5, height: geo.size.height / 5)
                        .padding(.trailing, geo.size.height / 42)
                        
                        VStack(alignment: .leading) {
                            Text("FrameIt")
                                .font(.system(size: geo.size.height / 10, weight: .heavy, design: .rounded))
                                .foregroundColor(.primary)
                            
                            Text("empty frame")
                                .font(.system(size: geo.size.height / 15, weight: .heavy, design: .rounded))
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                    }
                    
                    VStack {
                        HStack {
                            Image(systemName: "hand.point.right.fill")
                                .rotationEffect(Angle(degrees: -90))
                                .font(.system(size: geo.size.height / 10, weight: .heavy, design: .rounded))
                                .foregroundColor(.secondary)
                            
                            Text("Long press this widget")
                                .font(.system(size: geo.size.height / 20, weight: .regular, design: .default))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        .padding(.top, (geo.size.height / 50) - 2)
                        
                        HStack {
                            Image(systemName: "info.circle.fill")
                                .font(.system(size: geo.size.height / 10, weight: .heavy, design: .rounded))
                                .foregroundColor(.secondary)
                            
                            Text("Tap \"Edit Widget\"")
                                .font(.system(size: geo.size.height / 20, weight: .regular, design: .default))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        .padding(.top, (geo.size.height / 50) - 2)
                        
                        RoundedRectangle(cornerRadius: geo.size.height / 100, style: .continuous)
                            .frame(height: geo.size.height / 84)
                            .foregroundColor(.secondary)
                        
                        HStack {
                            Image(systemName: "minus.circle")
                                .font(.system(size: geo.size.height / 10, weight: .heavy, design: .rounded))
                                .foregroundColor(.red)
                                .opacity(0.75)
                            
                            Text("If your frame won't load, try removing the widget and adding it again.")
                                .font(.system(size: geo.size.height / 20, weight: .regular, design: .default))
                                .foregroundColor(.secondary)
                            
                            Spacer()
                        }
                        .padding(.top, (geo.size.height / 50) - 2)
                    }
                    
                    Spacer()
                }
                .padding(.top, geo.size.height / 10)
                .padding(.horizontal, geo.size.height / 10)
            }
        }
    }
}

struct FramePlaceholderView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            FramePlaceholderView(preview: true)
                .frame(width: 250, height: 250)
                .clipShape(RoundedRectangle(cornerRadius: 25, style: .continuous))
        }
    }
}
