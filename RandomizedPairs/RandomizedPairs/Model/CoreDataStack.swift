//
//  Person.swift
//  RandomizedPairs
//
//  Created by Colby Harris on 4/10/20.
//  Copyright © 2020 Colby_Harris. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    // MARK: - Core Data Stack
    
    static var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "RandomizedPairs")
        container.loadPersistentStores { (storeDescription, error) in
            if let nserror = error as NSError? {
                fatalError("Unresolved error loading Core Data persistent store:\n\(nserror), \(nserror.userInfo)")
            }
        }
        return container
    }()
    
    static var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    // MARK: - Core Data Saving Support

    static func saveContext () {
        let context = CoreDataStack.context
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error saving Core Data context:\n\(nserror), \(nserror.userInfo)")
            }
        }
    }
}
