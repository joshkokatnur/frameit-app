//
//  CustomColorPromotion.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/27/20.
//

import SwiftUI

struct PhoneMockup: View {
    
    //passed vars
    var imageName: String
    var phoneWidth: CGFloat //= 200 // originally 200
    var bezelThickness: CGFloat
    var bezelColor: Color
    var axisX: CGFloat
    var axisY: CGFloat
    var axisZ: CGFloat
    var rotationAngle: Double //= 0
    
    //local vars
    var rotRadius: Double = 5
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: phoneWidth / 6.5, style: .continuous)
                .foregroundColor(.black)
                .frame(width: phoneWidth, height: phoneWidth * 2.078)
                .opacity(0.4)
                .blur(radius: 25)
                .offset(x: 25, y: 40)
                .rotation3DEffect(Angle(degrees: rotRadius * cos(rotationAngle)), axis: (axisX, 0, 0))
                .rotation3DEffect(Angle(degrees: rotRadius * sin(rotationAngle)), axis: (0, axisY, 0))
                .rotation3DEffect(Angle(degrees: rotRadius/2 * sin(rotationAngle)), axis: (0, 0, axisZ))
            
            ZStack {
                //Body
                RoundedRectangle(cornerRadius: phoneWidth / 6.5, style: .continuous)
                    .foregroundColor(bezelColor)
                    .frame(width: phoneWidth, height: phoneWidth * 2.078)
                    .offset(x: axisY * CGFloat((rotRadius * sin(rotationAngle)) / -2))
                    .offset(y: axisX * CGFloat((rotRadius * cos(rotationAngle)) / 2))

                //Display
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: phoneWidth - bezelThickness, height: (phoneWidth * 2.078) - bezelThickness)
                    .cornerRadius(phoneWidth / 8.5)
                
                //Notch
                VStack {
                    PhoneNotch(tl: 4, tr: 4, bl: 10, br: 10)
                        .foregroundColor(bezelColor)
                        .frame(width: phoneWidth / 1.75, height: phoneWidth / 13)
                    Spacer()
                }
                .offset(y: (bezelThickness / 2) - 1)
                .frame(width: phoneWidth, height: phoneWidth * 2.078)
            }
            .rotation3DEffect(Angle(degrees: rotRadius * cos(rotationAngle)), axis: (axisX, 0, 0))
            .rotation3DEffect(Angle(degrees: rotRadius * sin(rotationAngle)), axis: (0, axisY, 0))
            .rotation3DEffect(Angle(degrees: rotRadius/2 * sin(rotationAngle)), axis: (0, 0, axisZ))
        }
    }
    
    func trigXY(sine: Bool, num: Double) -> CGFloat {
        if sine {
            return CGFloat(sin(num))
        } else {
            return CGFloat(cos(num))
        }
    }
}

struct Interactive_Preview: View {
    
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
            
            
            PhoneMockup(imageName: "promo1_light", phoneWidth: 200, bezelThickness: 15, bezelColor: Color(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), axisX: xOn ? 1.0 : 0.0, axisY: yOn ? 1.0 : 0.0, axisZ: zOn ? 1.0 : 0.0, rotationAngle: rotationAngle)
            
            Slider(value: $rotationAngle, in: -10...10)
                .padding(.horizontal, 50)
        }
    }
}

struct PhoneMockup_Previews: PreviewProvider {
    
    @State var rotationAngle: Double = 0
    
    static var previews: some View {
        Interactive_Preview()
    }
}

struct PhoneNotch: Shape {
    var tl: CGFloat
    var tr: CGFloat
    var bl: CGFloat
    var br: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let w = rect.size.width
        let h = rect.size.height

        let tr = min(min(self.tr, h/2), w/2)
        let tl = min(min(self.tl, h/2), w/2)
        let bl = min(min(self.bl, h/2), w/2)
        let br = min(min(self.br, h/2), w/2)

        path.move(to: CGPoint(x: w / 2.0, y: 0))
        path.addLine(to: CGPoint(x: w - tr, y: 0))
        path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: 270),         endAngle: Angle(degrees: 180), clockwise: true)
    
        path.addArc(center: CGPoint(x: w - br - tl - tr, y: h - br), radius: br,
                    startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)

        path.addArc(center: CGPoint(x: bl + tl + tr, y: h - bl), radius: bl,
                    startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)

        path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 270), clockwise: true)
        
        return path
    }
}
