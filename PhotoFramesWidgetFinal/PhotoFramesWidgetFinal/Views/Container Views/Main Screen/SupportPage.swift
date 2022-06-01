//
//  SupportPage.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 12/30/20.
//

import SwiftUI
import StoreKit

struct SupportPage: View {
    
    //passed vars
    var geoSize: CGSize
    
    //animation
    @State var showingPage = false
    
    //iaps
    @StateObject var storeManager: StoreManager
    
    //misc
    @Environment(\.colorScheme) var colorScheme
    @State var showRestoreAlert = false
    @State var restoreCase: Int = -1
    
    var body: some View {
        Button(action: {
            showingPage = true
        }) {
            Image(systemName: "gear")
                .font(.system(size: geoSize.width / 12.5 < 40 ? geoSize.width / 12.5 : 40, weight: .semibold, design: .rounded))
                .foregroundColor(.primary)
        }
        .sheet(isPresented: $showingPage) {
            ZStack {
                Color(.white)
                    .edgesIgnoringSafeArea(.all)

                Rectangle()
                    .fill(RadialGradient(gradient: Gradient(colors: colorScheme == .light ? [Color.black.opacity(0.05), Color.white, Color.black.opacity(0.05)] : [Color.black.opacity(0.90), Color.black, Color.black.opacity(0.90)]), center: .center, startRadius: 0, endRadius: 1))
                    .edgesIgnoringSafeArea(.all)
                    .padding(-10)
                
                VStack {
                    RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                        .frame(width: 50, height: 7.5)
                        .foregroundColor(.secondary)
                        .opacity(0.50)
                    
                    HStack {
                        Text("Support")
                            .font(.system(size: geoSize.height / 18, weight: .heavy, design: .default))
                            .fixedSize()
                        Spacer()
                    }
                    .padding(.top)
                    
                    VStack(spacing: 30) {
                        // Leave a review
                        Button(action: {
                            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                                SKStoreReviewController.requestReview(in: scene)
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: geoSize.height / 25 < 32 ? geoSize.height / 25 : 32, style: .continuous)
                                    .foregroundColor(colorScheme == .light ? Color(#colorLiteral(red: 0.8763137403, green: 0.8720803406, blue: 0.88054714, alpha: 1)) : Color(#colorLiteral(red: 0.189984713, green: 0.2057006004, blue: 0.2285318811, alpha: 1)))
                                
                                HStack(spacing: 12) {
                                    Text("Leave a Review")
                                        .font(.system(size: geoSize.width / 20 < 22.5 ? geoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                    Image(systemName: "hand.thumbsup.fill")
                                        .font(.system(size: geoSize.width / 20 < 22.5 ? geoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                }
                            }
                            .frame(width: geoSize.height / 2.75 < 375 ? geoSize.height / 2.75 : 375, height: geoSize.height / 12 < 80 ? geoSize.height / 12 : 80)
                        }
                        
                        // Restore Purchases
                        Button(action: {
                            storeManager.restoreProducts()
                            if storeManager.transactionState == .restored {
                                showRestoreAlert = true
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: geoSize.height / 25 < 32 ? geoSize.height / 25 : 32, style: .continuous)
                                    .foregroundColor(colorScheme == .light ? Color(#colorLiteral(red: 0.8763137403, green: 0.8720803406, blue: 0.88054714, alpha: 1)) : Color(#colorLiteral(red: 0.189984713, green: 0.2057006004, blue: 0.2285318811, alpha: 1)))
                                
                                HStack(spacing: 12) {
                                    Text("Restore Purchases")
                                        .font(.system(size: geoSize.width / 20 < 22.5 ? geoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                    Image(systemName: "dollarsign.circle.fill")
                                        .font(.system(size: geoSize.width / 20 < 22.5 ? geoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                }
                            }
                            .frame(width: geoSize.height / 2.75 < 375 ? geoSize.height / 2.75 : 375, height: geoSize.height / 12 < 80 ? geoSize.height / 12 : 80)
                        }
                        .alert(isPresented: $showRestoreAlert) {
                            Alert(title: Text("Success"), message: Text("Thanks again for your purchase!"), dismissButton: .default(Text("Dismiss")))
                        }
                        .onChange(of: storeManager.transactionState) { _ in
                            if storeManager.transactionState == .restored {
                                showRestoreAlert = true
                            }
                        }
                        
                        // Go to webiste
                        Button(action: {
                            let url: NSURL = URL(string: "https://jkokatnur.wixsite.com/frameitapp")! as NSURL
                            UIApplication.shared.open(url as URL)
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: geoSize.height / 25 < 32 ? geoSize.height / 25 : 32, style: .continuous)
                                    .foregroundColor(colorScheme == .light ? Color(#colorLiteral(red: 0.8763137403, green: 0.8720803406, blue: 0.88054714, alpha: 1)) : Color(#colorLiteral(red: 0.189984713, green: 0.2057006004, blue: 0.2285318811, alpha: 1)))
                                
                                HStack(spacing: 12) {
                                    Text("Visit our website")
                                        .font(.system(size: geoSize.width / 20 < 22.5 ? geoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                    Image(systemName: "globe")
                                        .font(.system(size: geoSize.width / 20 < 22.5 ? geoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                }
                            }
                            .frame(width: geoSize.height / 2.75 < 375 ? geoSize.height / 2.75 : 375, height: geoSize.height / 12 < 80 ? geoSize.height / 12 : 80)
                        }
                        
                        // Privacy Policy
                        Button(action: {
                            let url: NSURL = URL(string: "https://jkokatnur.wixsite.com/frameitapp/privacy-policy")! as NSURL
                            UIApplication.shared.open(url as URL)
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: geoSize.height / 25 < 32 ? geoSize.height / 25 : 32, style: .continuous)
                                    .foregroundColor(colorScheme == .light ? Color(#colorLiteral(red: 0.8763137403, green: 0.8720803406, blue: 0.88054714, alpha: 1)) : Color(#colorLiteral(red: 0.189984713, green: 0.2057006004, blue: 0.2285318811, alpha: 1)))
                                
                                HStack(spacing: 12) {
                                    Text("Privacy Policy")
                                        .font(.system(size: geoSize.width / 20 < 22.5 ? geoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                    Image(systemName: "hand.raised.fill")
                                        .font(.system(size: geoSize.width / 20 < 22.5 ? geoSize.width / 20 : 22.5, weight: .bold, design: .rounded))
                                        .foregroundColor(colorScheme == .light ? .black : .white)
                                }
                            }
                            .frame(width: geoSize.height / 2.75 < 375 ? geoSize.height / 2.75 : 375, height: geoSize.height / 12 < 80 ? geoSize.height / 12 : 80)
                        }
                    }
                    
                    Spacer()
                }
                .padding(25)
            }
        }
    }
}

struct SupportPage_Previews: PreviewProvider {
    static var previews: some View {
        SupportPage(geoSize: CGSize(width: 5, height: 5), storeManager: StoreManager())
    }
}
