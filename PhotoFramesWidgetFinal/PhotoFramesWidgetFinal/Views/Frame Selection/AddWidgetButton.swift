//
//  AddWidgetButton.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/5/20.
//

import Foundation
import SwiftUI
import WidgetKit
import UIKit

struct AddWidgetButton: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Binding var goHome: Bool
    @Binding var presentPromotion: Bool
    
    //Animation
    @Binding var showingWidgetPage: Bool
    @Binding var usersName: String?
    @Binding var successCase: Int // 0 = standby, 1 = success, 2 = error
    
    var pagerIndex: Int
    var content: [AnyView]
    //var images: [UIImage]?
    //var cropRects: [CGRect]?
    var scaleFactors: [CGFloat]?
    var transforms: [CGSize]?
    var imgIds: [String]?
    var randRotation: [Double]
    var catIndex: Int
    var parentGeoSize: CGSize
    var customColor: Color
    var needsPayment: Bool
    var paidForService: Bool
    
    //Core Data
    @Environment (\.managedObjectContext) var managedObjectContext
    
    var body: some View {
        Button(action: {
            if needsPayment {
                if paidForService {
                    if usersName == nil {
                        withAnimation(.easeInOut) {
                            showingWidgetPage = true
                        }
                    } else {
                        saveData()
                    }
                } else {
                    presentPromotion = true
                }
            } else {
                if usersName == nil {
                    withAnimation(.easeInOut) {
                        showingWidgetPage = true
                    }
                } else {
                    saveData()
                }
            }
        }) {
            ZStack {
                Rectangle()
                    .foregroundColor(.primary)
                
                HStack(spacing: 12) {
                    Text("Select")
                        .font(.system(size: parentGeoSize.width / 20 < 25 ? parentGeoSize.width / 20 : 25, weight: .bold, design: .rounded))
                        .foregroundColor(colorScheme == .light ? .white : .black)
                    Image(systemName: "plus")
                        .font(.system(size: parentGeoSize.width / 20 < 25 ? parentGeoSize.width / 20 : 25, weight: .bold, design: .rounded))
                        .foregroundColor(colorScheme == .light ? .white : .black)
                }
                .offset(x: usersName != nil ? -500 : 0)
                .animation(Animation.spring().delay(usersName != nil ? 0 : 0.25))
                HStack(spacing: 12) {
                    Text("Add to Widgets")
                        .font(.system(size: parentGeoSize.width / 20 < 25 ? parentGeoSize.width / 20 : 25, weight: .bold, design: .rounded))
                        .foregroundColor(colorScheme == .light ? .white : .black)
                    Image(systemName: "arrow.down.to.line")
                        .font(.system(size: parentGeoSize.width / 20 < 25 ? parentGeoSize.width / 20 : 25, weight: .bold, design: .rounded))
                        .foregroundColor(colorScheme == .light ? .white : .black)
                }
                .offset(x: usersName != nil ? 0 : 500)
                .animation(Animation.spring().delay(usersName != nil ? 0.25 : 0))
            }
            .frame(width: parentGeoSize.height / 2.75 < 375 ? parentGeoSize.height / 2.75 : 375, height: parentGeoSize.height / 9 < 100 ? parentGeoSize.height / 9 : 100)
        }
        .clipShape(RoundedRectangle(cornerRadius: parentGeoSize.height / 25 < 32 ? parentGeoSize.height / 25 : 32, style: .continuous))
    }
    
    func saveData() {
        //create entity
        let savedImageItem = Entity(context: self.managedObjectContext)
  
        //convert scale factors to data and store
        let sfsData = try? NSKeyedArchiver.archivedData(withRootObject: scaleFactors as Any, requiringSecureCoding: true)
        savedImageItem.scaleFactors = sfsData
        
        //convert transforms to data and store
        let transfData = try? NSKeyedArchiver.archivedData(withRootObject: transforms as Any, requiringSecureCoding: true)
        savedImageItem.transforms = transfData
        
        //convert image ids to string
        let imgIdsData = try? NSKeyedArchiver.archivedData(withRootObject: imgIds as Any, requiringSecureCoding: true)
        savedImageItem.imageIdentifiers = imgIdsData
        
        savedImageItem.categoryId = Int16(catIndex)
        savedImageItem.frameId = Int16(pagerIndex * -1)
        savedImageItem.customColor = UIColor(customColor).toHex
        savedImageItem.usersName = usersName
        savedImageItem.createdAt = Date()
        
        //prepare feeback
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        
        do {
            //try to save
            try managedObjectContext.save()
            
            //update widget center
            WidgetCenter.shared.reloadAllTimelines()
            
            //success feedback
            generator.notificationOccurred(.success)
            
            //present dialog
            withAnimation(.easeInOut) {
                successCase = 1
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut) {
                    successCase = 0
                    usersName = nil
                }
                goHome = true
            }
        } catch {
            //error feedback
            generator.notificationOccurred(.error)
            
            //present dialog
            withAnimation(.easeInOut) {
                successCase = 2
            }
            print(error)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeInOut) {
                    successCase = 0
                }
            }
        }
    }
}
