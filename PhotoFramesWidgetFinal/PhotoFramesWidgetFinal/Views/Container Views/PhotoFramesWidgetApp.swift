//
//  PhotoFramesWidgetApp.swift
//  Shared
//
//  Created by Josh Kokatnur on 7/30/20.
//

import SwiftUI
import CoreData
import StoreKit

@main
struct PhotoFramesWidgetApp: App {
    
    @StateObject var storeManager = StoreManager()
    @Environment(\.scenePhase) private var scenePhase
    let persistenceController = PersistenceController.shared
    
    let productIDs = [
        "com.JoshK.customFrameColor",
        "com.JoshK.collageFrames"
    ]
    
    var body: some Scene {
        WindowGroup {
            ContentView(storeManager: storeManager)
                .environment(\.locale, Locale(identifier: Locale.autoupdatingCurrent.identifier))
                .environment(\.managedObjectContext, persistenceController.persistentContainer.viewContext)
                .ignoresSafeArea(.keyboard)
                .onAppear(perform: {
                    SKPaymentQueue.default().add(storeManager)
                    storeManager.getProducts(productIDs: productIDs)
                })
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                persistenceController.saveContext()
            @unknown default:
                fatalError("\(#function) REPORTS - fatal error in switch statement for .onChange modifier")
            }
        }
    }
}
