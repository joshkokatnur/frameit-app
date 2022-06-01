//
//  IntentHandler.swift
//  WidgetIntentExtension
//
//  Created by Josh Kokatnur on 9/24/20.
//

import Intents

class IntentHandler: INExtension, SelectWidgetIntentHandling {
    func provideFrameOptionsCollection(for intent: SelectWidgetIntent, with completion: @escaping (INObjectCollection<FrameID>?, Error?) -> Void) {
            //Obtain coredata info
            let context = PersistenceController.shared.persistentContainer.viewContext
            var results: [Entity] = []
            do {
                results = try context.fetch(Entity.getAllItems())
            } catch let error as NSError {
                print("ERROR: \(error.localizedDescription)")
            }

            // Iterate the available frames, creating a FrameID for each one.
            var frames: [FrameID] = []
            print(results.count)
            for i in 0..<results.count {
                let frameInstance = FrameID (
                    identifier: results[i].usersName,
                    display: results[i].usersName ?? "No Name"
                )
                frameInstance.usersName = results[i].usersName ?? "No Name"
                frameInstance.coreDataIndex = NSNumber(value: i)
                frames.append(frameInstance)
            }

            // Create a collection with the array of frames.
            let collection = INObjectCollection(items: frames)

            // Call the completion handler, passing the collection.
            completion(collection, nil)
    }

    override func handler(for intent: INIntent) -> Any {
        // This is the default implementation.  If you want different objects to handle different intents,
        // you can override this and return the handler you want for that particular intent.

        return self
    }

}
