//
//  FramesList.swift
//  FrameIt
//
//  Created by Josh Kokatnur on 10/6/20.
//

import SwiftUI
import UIKit
import PhotosUI

struct FramesList: View {
    
    @Environment(\.colorScheme) var colorScheme
    @Environment (\.managedObjectContext) var managedObjectContext
    @FetchRequest (fetchRequest: Entity.getAllItems()) var savedImageItems: FetchedResults<Entity>
    
    var parentGeoSize: CGSize
    var appearance = UITableView.appearance().backgroundColor
    
    //list editing
    @State private var editMode = EditMode.inactive
    
    init(parentGeoSize: CGSize) {
        UITableView.appearance().backgroundColor = .clear
        self.parentGeoSize = parentGeoSize
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(colorScheme == .light ? .white : #colorLiteral(red: 0.1176470588, green: 0.1254901961, blue: 0.1411764706, alpha: 1)))
            if savedImageItems.count > 0 {
                List {
                    ForEach(savedImageItems) { frame in
                        if let name = frame.usersName {
                            HStack(alignment: .bottom, spacing: parentGeoSize.width / 25 < 25 ? parentGeoSize.width / 25 : 25) {
                                ListWidgetPreview(imgObject: frame)
                                    .frame(width: parentGeoSize.width / 2 < 300 ? parentGeoSize.width / 2 : 300, height: parentGeoSize.width / 2 < 300 ? parentGeoSize.width / 2 : 300)
                                    .scaleEffect(0.5)
                                    .frame(width: parentGeoSize.width / 4 < 150 ? parentGeoSize.width / 4 : 150, height: parentGeoSize.width / 4 < 150 ? parentGeoSize.width / 4 : 150)
                                    .clipShape(RoundedRectangle(cornerRadius: parentGeoSize.width / 25 < 25 ? parentGeoSize.width / 25 : 25, style: .continuous))
                                
                                HStack(spacing: 0) {
                                    Text("\"\(name)")
                                        .font(.system(size: parentGeoSize.width / 12.5 < 50 ? parentGeoSize.width / 12.5 : 50, weight: .heavy, design: .default))
                                    Text("\"")
                                        .font(.system(size: parentGeoSize.width / 12.5 < 50 ? parentGeoSize.width / 12.5 : 50, weight: .heavy, design: .default))
                                    
                                    Spacer()
                                }
                                .frame(width: parentGeoSize.width / 2.25, height: parentGeoSize.width / 12.5 < 50 ? parentGeoSize.width / 12.5 : 50)
                            }
                            .listRowBackground(Color(colorScheme == .light ? .white : #colorLiteral(red: 0.1176470588, green: 0.1254901961, blue: 0.1411764706, alpha: 1)))
                            .padding(.vertical)
                        }
                    }.onDelete(perform: deleteFrame)
                }
                .padding(parentGeoSize.width / 35)
            } else {
                VStack(spacing: 10) {
                    Text("No Frames")
                        .font(.system(size: parentGeoSize.height / 25, weight: .heavy, design: .default)) //45
                        .foregroundColor(.primary)
                    
                    Text("Tap the button below to get started.")
                        .font(.system(size: parentGeoSize.height / 50, weight: .bold, design: .default)) //15
                        .foregroundColor(.secondary)
                        .padding(.leading, parentGeoSize.width / 125)
                }
            }
            
            VStack {
                HStack {
                    Spacer()
                    
                    Button(action: {
                        //start editing
                        withAnimation(.spring()) {
                            if editMode == EditMode.inactive {
                                editMode = EditMode.active
                            } else {
                                editMode = EditMode.inactive
                            }
                        }
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: .infinity, style: .continuous)
                                .foregroundColor(colorScheme == .light ? Color(#colorLiteral(red: 0.9072416425, green: 0.9044003487, blue: 0.9116410613, alpha: 1)) : Color(#colorLiteral(red: 0.189984713, green: 0.2057006004, blue: 0.2285318811, alpha: 1)))
                            Text(editMode == EditMode.inactive ? "Edit" : "Done")
                                .foregroundColor(colorScheme == .light ? .black : .white)
                                .bold()
                        }
                    }
                    .frame(width: parentGeoSize.width / 5 < 100 ? parentGeoSize.width / 5 : 100, height: parentGeoSize.width / 10 < 56 ? parentGeoSize.width / 10 : 56) //80x45
                }
                Spacer()
            }
            .padding(.top, 15)
            .padding(.trailing, 15)
        }
        .environment(\.editMode, $editMode)
    }
    
    func deleteFrame(at offsets: IndexSet) {
        for index in offsets {
            let frame = savedImageItems[index]
            managedObjectContext.delete(frame)
            try? managedObjectContext.save()
        }
    }
}
