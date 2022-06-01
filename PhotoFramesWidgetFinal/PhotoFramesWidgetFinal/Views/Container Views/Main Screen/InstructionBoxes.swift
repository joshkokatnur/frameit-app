//
//  test.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 9/21/20.
//

import SwiftUI

struct Ins_Container: View {
    
    var index: Int
    
    var body: some View {
        switch index {
            case 0: Ins_1()
            //case 1: Ins_2()
            case 1: Ins_3()
            case 2: Ins_4()
            default: Ins_1()
        }
    }
}

struct Ins_1: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(colorScheme == .light ? .white : #colorLiteral(red: 0.1740885377, green: 0.1891232431, blue: 0.2092809081, alpha: 1)))
                .shadow(color: (colorScheme == .light ? Color.black.opacity(0.10) : Color.black.opacity(0.50)), radius: 25)
            
            VStack {
                HStack {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9490196078, green: 0.7568627451, blue: 0.3058823529, alpha: 1)), Color(#colorLiteral(red: 0.968627451, green: 0.5058823529, blue: 0.3294117647, alpha: 1)), Color(#colorLiteral(red: 0.7058823529, green: 0.262745098, blue: 0.4235294118, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                            .mask(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(lineWidth: 10).padding(5))
                        ZStack(alignment: .bottomTrailing) {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .opacity(colorScheme == .light ? 0.15 : 0.25)
                                .padding(6)
                            GradientIcon(name: "checkmark.circle.fill", size: 35)
                                .padding(20)
                        }
                    }
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .opacity(0.075)
                }
                HStack {
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .opacity(0.075)
                    RoundedRectangle(cornerRadius: 25, style: .continuous)
                        .opacity(0.075)
                }
            }
            .padding()
        }
    }
}

struct Ins_2: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(colorScheme == .light ? .white : #colorLiteral(red: 0.1740885377, green: 0.1891232431, blue: 0.2092809081, alpha: 1)))
                .shadow(color: (colorScheme == .light ? Color.black.opacity(0.10) : Color.black.opacity(0.50)), radius: 25)
            
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .opacity(0.075)
            .padding()
            
            GradientIcon(name: "crop", size: 250)
                .padding(20)
            
            Rectangle()
                .opacity(0.075)
                .padding(100)
        }
    }
}

struct Ins_3: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(colorScheme == .light ? .white : #colorLiteral(red: 0.1740885377, green: 0.1891232431, blue: 0.2092809081, alpha: 1)))
                .shadow(color: (colorScheme == .light ? Color.black.opacity(0.10) : Color.black.opacity(0.50)), radius: 25)
            
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9490196078, green: 0.7568627451, blue: 0.3058823529, alpha: 1)), Color(#colorLiteral(red: 0.968627451, green: 0.5058823529, blue: 0.3294117647, alpha: 1)), Color(#colorLiteral(red: 0.7058823529, green: 0.262745098, blue: 0.4235294118, alpha: 1))]), startPoint: .bottomLeading, endPoint: .topTrailing)
                    .mask(RoundedRectangle(cornerRadius: 25, style: .continuous).stroke(lineWidth: 10).padding(5))
                ZStack(alignment: .bottomTrailing) {
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(colorScheme == .light ? #colorLiteral(red: 0.8085864983, green: 0.8085864983, blue: 0.8085864983, alpha: 1) : #colorLiteral(red: 0.7213359871, green: 0.7213359871, blue: 0.7213359871, alpha: 1)))
                        .padding(8)
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .fill(Color(colorScheme == .light ? #colorLiteral(red: 0.9232176223, green: 0.9232176223, blue: 0.9232176223, alpha: 1) : #colorLiteral(red: 0.8854442634, green: 0.8854442634, blue: 0.8854442634, alpha: 1)))
                        .padding(35)
                    GradientIcon(name: "checkmark.circle.fill", size: 50)
                        .padding(45)
                }
            }
            .padding(35)
            .rotation3DEffect(.degrees(3),axis: (x: 1.0, y: 0.0, z: 1.0))
            .offset(y: -2)
        }
    }
}

struct Ins_4: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Color(colorScheme == .light ? .white : #colorLiteral(red: 0.1740885377, green: 0.1891232431, blue: 0.2092809081, alpha: 1)))
                .shadow(color: (colorScheme == .light ? Color.black.opacity(0.10) : Color.black.opacity(0.50)), radius: 25)
            
            VStack(spacing: 20) {
                HStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .frame(width: 75, height: 75)
                        .opacity(0.075)
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .opacity(0.05)
                        .frame(height: 20)
                }
                HStack(spacing: 20) {
                    AppIconFromBundle()
                        .frame(width: 75, height: 75)
                        .clipShape(RoundedRectangle(cornerRadius: 15, style: .continuous))
                    
                    HStack {
                        Text("FrameIt")
                            .font(.system(size: 25, weight: .bold, design: .default))
                        Spacer()
                    }
                    .padding(.leading, 5)
                }
                HStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 12, style: .continuous)
                        .frame(width: 75, height: 75)
                        .opacity(0.075)
                    RoundedRectangle(cornerRadius: 5, style: .continuous)
                        .opacity(0.05)
                        .frame(height: 20)
                }
            }
            .padding(25)
        }
    }
}

struct test_Previews: PreviewProvider {
    
    static var previews: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)

            Rectangle()
                .fill(RadialGradient(gradient: Gradient(colors: [Color.black.opacity(0.05), Color.white, Color.black.opacity(0.05)]), center: .center, startRadius: 0, endRadius: 1))
                .edgesIgnoringSafeArea(.all)
            
            Ins_4()
                .frame(width: 300, height: 300)
        }
    }
}
