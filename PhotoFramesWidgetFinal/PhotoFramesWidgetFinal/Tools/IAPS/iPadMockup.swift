//
//  iPadMockup.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 1/3/21.
//

import SwiftUI

struct iPadMockup: View {
    
    //passed vars
    var imageName: String
    var deviceWidth: CGFloat
    var bezelThickness: CGFloat
    var bezelColor: Color
    var sideColor: Color
    var axisX: CGFloat
    var axisY: CGFloat
    var axisZ: CGFloat
    var rotationAngle: Double
    var isPortrait: Bool
    
    //local vars
    var rotRadius: Double = 5
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: deviceWidth / 11.5, style: .continuous)
                .foregroundColor(.black)
                .frame(width: deviceWidth, height: deviceWidth * 1.4)
                .opacity(0.4)
                .blur(radius: 25)
                .offset(x: 25, y: 40)
                .rotation3DEffect(Angle(degrees: rotRadius * cos(rotationAngle)), axis: (axisX, 0, 0))
                .rotation3DEffect(Angle(degrees: rotRadius * sin(rotationAngle)), axis: (0, axisY, 0))
                .rotation3DEffect(Angle(degrees: rotRadius/2 * sin(rotationAngle)), axis: (0, 0, axisZ))
                .rotationEffect(.degrees(isPortrait ? 0 : 90))
            
            
            ZStack {
                //3d body effect
                ZStack {
                    RoundedRectangle(cornerRadius: deviceWidth / 11, style: .continuous)
                        .foregroundColor(sideColor)
                }
                .frame(width: deviceWidth * 1, height: deviceWidth * 1.4 * 1)
                .offset(x: axisY * CGFloat((rotRadius * sin(rotationAngle - (isPortrait ? 0 : 90))) / -1.75))
                .offset(y: axisX * CGFloat((rotRadius * cos(rotationAngle - (isPortrait ? 0 : 90))) / 1.75))
                .rotationEffect(.degrees(isPortrait ? 0 : 90))
                
                //Body
                RoundedRectangle(cornerRadius: deviceWidth / 11.5, style: .continuous)
                    .foregroundColor(bezelColor)
                    .frame(width: deviceWidth, height: deviceWidth * 1.4)
                    .rotationEffect(.degrees(isPortrait ? 0 : 90))

                //Display
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: isPortrait ? (deviceWidth - bezelThickness) : ((deviceWidth * 1.4) - bezelThickness), height: isPortrait ? ((deviceWidth * 1.4) - bezelThickness) : (deviceWidth - bezelThickness))
                    .cornerRadius(deviceWidth / 25)
            }
            .rotation3DEffect(Angle(degrees: rotRadius * cos(rotationAngle)), axis: (axisX, 0, 0))
            .rotation3DEffect(Angle(degrees: rotRadius * sin(rotationAngle)), axis: (0, axisY, 0))
            .rotation3DEffect(Angle(degrees: rotRadius/2 * sin(rotationAngle)), axis: (0, 0, axisZ))
        }
    }
}

struct Interactive_PreviewiPad: View {
    
    @State var rotationAngle: Double = 0
    @State var xOn = false
    @State var yOn = false
    @State var zOn = false
    
    var body: some View {
        VStack(spacing: 50) {
            HStack {
                Toggle(isOn: $xOn, label: {
                    Text("")
                })
                Toggle(isOn: $yOn, label: {
                    Text("")
                })
                Toggle(isOn: $zOn, label: {
                    Text("")
                })
            }
            .padding(.trailing, 50)
            
            iPadMockup(imageName: "promo2_Vipad_light", deviceWidth: 200, bezelThickness: 15, bezelColor: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), sideColor: Color.gray, axisX: xOn ? 1.0 : 0.0, axisY: yOn ? 1.0 : 0.0, axisZ: zOn ? 1.0 : 0.0, rotationAngle: rotationAngle, isPortrait: true)
            
            Slider(value: $rotationAngle, in: -10...10)
                .padding(.horizontal, 50)
        }
    }
}

struct iPadMockup_Previews: PreviewProvider {
    
    @State var rotationAngle: Double = 0
    
    static var previews: some View {
        Interactive_PreviewiPad()
    }
}
