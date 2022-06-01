//
//  SavedImageItem.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/19/20.
//

import Foundation
import CoreData

extension Entity {
    static func getAllItems() -> NSFetchRequest<Entity> {
        let request: NSFetchRequest<Entity> = NSFetchRequest<Entity>(entityName: "Entity")
        let sortDescriptor = NSSortDescriptor(key: "createdAt", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        return request
    }
    
    static func getItemFromName(arguments: [String]) -> NSFetchRequest<Entity> {
        let request: NSFetchRequest<Entity> = NSFetchRequest<Entity>(entityName: "Entity")
        let predicate = NSPredicate(format: "usersName = %@", argumentArray: arguments)
        request.predicate = predicate
        return request
    }
}
