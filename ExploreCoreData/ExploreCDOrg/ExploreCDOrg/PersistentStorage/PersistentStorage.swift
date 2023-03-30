//
//  PersistentStorage.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 29/01/23.
//

import Foundation
import CoreData
import OSLog

class PersistentStorage {
    
    private init() {}
    static let shared = PersistentStorage()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let mergedModel = NSManagedObjectModel.mergedModel(from: nil)
        let persistentContainer = NSPersistentContainer(name: "Database", managedObjectModel: mergedModel!)
        persistentContainer.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Failed to create persistent container: Unresolved Error \(error), \(error.localizedDescription)")
            }
        }
        Logger.CoreData.info("Persistent URL: \(NSPersistentContainer.defaultDirectoryURL())")
        return persistentContainer
    }()
    
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    func save() {
        do {
            try context.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved Error \(nsError), \(nsError.localizedDescription)")
        }
    }
    
    func fetch<T: NSManagedObject>(managedObjectType: T.Type) -> [T]? {
        do {
            guard let result = try context.fetch(managedObjectType.fetchRequest()) as? [T] else {
                return nil
            }
            return result
        } catch {
            debugPrint("Failed to fetch result: \(error.localizedDescription)")
        }
        return nil
    }
    
}
