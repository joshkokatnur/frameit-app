//
//  CollagesPromotion.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/29/20.
//

import SwiftUI
import StoreKit

struct CollagesPromotion: View {
    
    //passed vars
    var parentGeoSize: CGSize
    var product: SKProduct
    var rotationAngle: Double
    
    //animation
    @State var appeared = false
    @State var buttonAppeared = false
    @State var transactionPending = false
    @Binding var presentSheet: Bool
    
    //iaps
    @StateObject var storeManager: StoreManager
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    
    //check for ipad
    private var device : UIUserInterfaceIdiom { UIDevice.current.userInterfaceIdiom }
    private var isPortrait : Bool { parentGeoSize.height > parentGeoSize.width }
    
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                .frame(width: 50, height: 7.5)
                .foregroundColor(.secondary)
                .opacity(0.50)
                .padding(.top, 20)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text("Create")
                        .font(.system(size: parentGeoSize.height / 16, weight: .heavy, design: .default))
                        .foregroundColor(.primary)
                    
                    Text("stunning collages")
                        .font(.system(size: parentGeoSize.height / 36, weight: .bold, design: .default)) //15
                        .foregroundColor(.secondary)
                        //.padding(.leading, parentGeoSize.width / 125)
                }
                .offset(y: appeared ? 0 : parentGeoSize.height * -1)
                .animation(Animation.spring().delay(0.25))
                
                Spacer()
                
                ZStack {
                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                        .stroke(lineWidth: 2.5)
                        .foregroundColor(.blue)
                    
                    Text(product.getFormattedPrice() ?? "$-.--")
                        .foregroundColor(.blue)
                        .bold()
                }
                .frame(width: parentGeoSize.height / 8 < 100 ? parentGeoSize.height / 8 : 100, height: parentGeoSize.height / 15 < 50 ? parentGeoSize.height / 15 : 50)
                .offset(y: 10)
                .offset(y: appeared ? 0 : parentGeoSize.height * -1)
                .animation(Animation.spring().delay(0.5))
            }
            .frame(width: (parentGeoSize.width * 0.7) + 50)
            
            Spacer()
            
            //Display different view on ipad
            if device == .pad {
                iPadMockup(imageName: colorScheme == .light ? (isPortrait ? "promo2_Vipad_light" : "promo2_Hipad_light") : (isPortrait ? "promo2_Vipad_dark" : "promo2_Hipad_dark"),
                           deviceWidth: 250 * (parentGeoSize.width / 600),
                           bezelThickness: 20 * (parentGeoSize.width / 600),
                           bezelColor: Color(#colorLiteral(red: 0.1274290759, green: 0.1274290759, blue: 0.1274290759, alpha: 1)),
                           sideColor: colorScheme == .light ? Color.gray : Color(#colorLiteral(red: 0.2127268584, green: 0.2327529746, blue: 0.258396568, alpha: 1)),
                           axisX: 1.0, axisY: 1.0, axisZ: 1.0,
                           rotationAngle: rotationAngle,
                           isPortrait: isPortrait)
                    .shadow(color: colorScheme == .dark ? Color(#colorLiteral(red: 0.4649572935, green: 0.5034194222, blue: 0.5592953415, alpha: 1)).opacity(0.5) : Color.clear, radius: 65, x: 0, y: 0)
                    .onAppear() {
                        print(parentGeoSize.width, parentGeoSize.height)
                    }
            } else {
                PhoneMockup(imageName: "promo2",
                            phoneWidth: 200 * (parentGeoSize.height / 700 > 1.25 ? 1.25 : parentGeoSize.height / 700),
                            bezelThickness: 16 * (parentGeoSize.height / 700 > 1.25 ? 1.25 : parentGeoSize.height / 700),
                            bezelColor: Color(#colorLiteral(red: 0.1274290759, green: 0.1274290759, blue: 0.1274290759, alpha: 1)),
                            axisX: 1.0, axisY: 1.0, axisZ: 1.0,
                            rotationAngle: rotationAngle)
                    .shadow(color: colorScheme == .dark ? Color(#colorLiteral(red: 0.4649572935, green: 0.5034194222, blue: 0.5592953415, alpha: 1)).opacity(0.5) : Color.clear, radius: 65, x: 0, y: 0)
            }
            
            Spacer()
            
            Button(action: {
                if !transactionPending {
                    withAnimation(.spring()) {
                        transactionPending = true
                    }
                    storeManager.purchaseProduct(product: product)
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: parentGeoSize.height / 25 < 32 ? parentGeoSize.height / 25 : 32, style: .continuous)
                        .frame(width: transactionPending ? (parentGeoSize.height / 2.75 < 375 ? parentGeoSize.height / 2.75 : 375) / 2 : (parentGeoSize.height / 2.75 < 375 ? parentGeoSize.height / 2.75 : 375), height: parentGeoSize.height / 9 < 100 ? parentGeoSize.height / 9 : 100)
                        .foregroundColor(.primary)
                        .opacity(transactionPending ? 0.1 : 1)
                    
                    HStack {
                        Text("Buy now")
                            .font(.system(size: parentGeoSize.width / 20 < 22.5 ? parentGeoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                            .foregroundColor(colorScheme == .light ? .white : .black)
                        Image(systemName: "plus")
                            .font(.system(size: parentGeoSize.width / 20 < 22.5 ? parentGeoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                            .foregroundColor(colorScheme == .light ? .white : .black)
                    }
                    .opacity(transactionPending ? 0 : 1)
                    
                    ProgressView()
                        .scaleEffect(1.5)
                        .opacity(transactionPending ? 1 : 0)
                }
            }
            .offset(y: buttonAppeared ? 0 : parentGeoSize.height * 1)
            .padding(.bottom, (parentGeoSize.width / 20) - 7.5)
        }
        .onChange(of: storeManager.transactionState) { state in
            withAnimation(.spring()) {
                transactionPending = !(state == .failed || state == .deferred)
            }
            presentSheet = !(state == .purchased)
        }
        .onAppear() {
            appeared = true
            
            withAnimation(Animation.spring().delay(0.75)) {
                buttonAppeared = true
            }
        }
    }
}

struct CollagesPromotion_Previews: PreviewProvider {
    static var previews: some View {
        Text("")
            .sheet(isPresented: .constant(true)) {
                CollagesPromotion(parentGeoSize: CGSize(width: 375, height: 734), product: MockSKProduct(), rotationAngle: 2, presentSheet: .constant(true), storeManager: StoreManager())
                    .environmentObject(StoreManager())
            }
    }
}
