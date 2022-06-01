//
//  PersistenceController.swift
//  PhotoFramesWidgetFinal
//
//  Created by Josh Kokatnur on 9/19/20.
//

import Foundation
import CoreData

struct PersistenceController {
    
    static let shared = PersistenceController()
    private init() {}
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotoFramesStorage")
        let storeURL = URL.storeURL(for: "group.joshk.PhotoFramesData", databaseName: "Data")
        let storeDescription = NSPersistentStoreDescription(url: storeURL)

        container.persistentStoreDescriptions = [storeDescription]
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

public extension URL {

    //Returns a URL for the given app group and database pointing to the sqlite database.
    static func storeURL(for appGroup: String, databaseName: String) -> URL {
        guard let fileContainer = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: appGroup) else {
            fatalError("Shared file container could not be created.")
        }

        return fileContainer.appendingPathComponent("\(databaseName).sqlite")
    }
}
