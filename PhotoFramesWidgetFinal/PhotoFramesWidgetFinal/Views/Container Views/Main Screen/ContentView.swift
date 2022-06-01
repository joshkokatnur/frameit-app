//
//  ContentView.swift
//  Shared
//
//  Created by Josh Kokatnur on 7/30/20.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject var storeManager: StoreManager
    
    var body: some View {
        ZStack {
            Color(.white)
                .edgesIgnoringSafeArea(.all)

            Rectangle()
                .fill(RadialGradient(gradient: Gradient(colors: colorScheme == .light ? [Color.black.opacity(0.025), Color.white, Color.black.opacity(0.025)] : [Color.black.opacity(0.95), Color.black, Color.black.opacity(0.95)]), center: .center, startRadius: 0, endRadius: 1))
                .edgesIgnoringSafeArea(.all)
                .padding(-10)
            
            Main(storeManager: storeManager)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(storeManager: StoreManager())
    }
}
