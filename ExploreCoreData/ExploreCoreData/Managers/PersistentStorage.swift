//
//  PersistentStorage.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 03/12/21.
//

import Foundation
import CoreData

/*
 Source:
 https://cocoacasts.com/exploring-the-nspersistentstoredescription-class
 
 Definition:
 
 Notes:
 - The NSPersistentStoreDescription class defines a property, shouldAddStoreAsynchronously, that determines how the persistent store is added to the persistent store coordinator, synchronously or asynchronously. By default, a persistent store is added synchronously on the calling thread.
 */

final class PersistentStorage {
    
    private init() {}
    static let shared = PersistentStorage()
    
    // MARK: - Core Data stack

    /*
     NSPersistentContainer simplifies the creation and management of the Core Data stack by handling the creation of the managed object model (NSManagedObjectModel), persistent store coordinator (NSPersistentStoreCoordinator), and the managed object context (NSManagedObjectContext).
     */
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "ExploreCoreData")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObjectType: T.Type) -> [T]? {
        do {
            guard let result = try context.fetch(managedObjectType.fetchRequest()) as? [T] else { return nil }
            return result
        } catch let error {
            debugPrint("Error : \(error.localizedDescription)")
        }
        return nil
    }
}
