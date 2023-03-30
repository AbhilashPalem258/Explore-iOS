//
//  CDCommentsService.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 31/01/23.
//
import CoreData
import Combine
import Foundation
import OSLog

enum CDCommentsService {
    
    static func fetchAllItemsUsingAsynchronousRequest() -> Future<[CDComment], Error>{
        Future<[CDComment], Error> { promise in
            let fetchRequest = NSFetchRequest<CDComment>.init(entityName: String(describing: CDComment.self))
            fetchRequest.sortDescriptors = [
                NSSortDescriptor(keyPath: \CDComment.name, ascending: true)
            ]
            
            let asyncFetchRequest = NSAsynchronousFetchRequest(fetchRequest: fetchRequest) { result in
                if let items = result.finalResult {
                    promise(.success(items))
                }
            }
            
            do {
                let fetchResult = try PersistentStorage.shared.context.execute(asyncFetchRequest) as! NSAsynchronousFetchResult<CDComment>
                if let items = fetchResult.finalResult {
                    promise(.success(items))
                } else {
                    Logger.CoreData.error("Haven't fetched items yet")
                }
            } catch {
                promise(.failure(error))
            }
        }
        
    }
    
    static func insertItemsUsingTraditionalBatchInsert(_ items: [Comment]) -> Future<Bool, Never> {
        Future<Bool, Never> { promise in
            PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
                for item in items {
                    let cdComment = CDComment(context: privateManagedContext)
                    cdComment.id = item.id
                    cdComment.postId = item.postId
                    cdComment.name = item.name
                    cdComment.body = item.body
                    cdComment.email = item.email
                    cdComment.customValue = CustomClassForCDEntity(name: item.name)
                }
                
                if privateManagedContext.hasChanges {
                    try? privateManagedContext.save()
                    promise(.success(true))
                } else {
                    promise(.success(false))
                }
            }
        }
    }
    
    static func inserItemsUsingNSBatchInsertRequest(_ items: [Comment]) -> Future<Bool, Never> {
        Future<Bool,Never> { promise in
            PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedObjectContext in
                
                var index = 0, totalCount = items.count
                
                let batchrequest = NSBatchInsertRequest(entity: CDComment.entity(), managedObjectHandler: { managedObject in
                    guard index < totalCount else {
                        return true
                    }
                    
                    if let cdComment = managedObject as? CDComment {
                        let item = items[index]
                        cdComment.id = item.id
                        cdComment.postId = item.postId
                        cdComment.name = item.name
                        cdComment.body = item.body
                        cdComment.email = item.email
                        cdComment.customValue = CustomClassForCDEntity(name: item.name)
                    }
                    
                    index += 1
                    return false
                })
                
                do {
                    try privateManagedObjectContext.execute(batchrequest)
                    promise(.success(true))
                } catch {
                    print(error)
                    promise(.success(false))
                }
            }
        }
    }
    
    public func updateAllUsingBatchRequest() {
        let batchUpdateRequest = NSBatchUpdateRequest(entity: CDComment.entity())
        batchUpdateRequest.propertiesToUpdate = ["email": "[Update]@updatemail.com"]
        batchUpdateRequest.resultType = .updatedObjectsCountResultType
        
        do {
            let result = try PersistentStorage.shared.context.execute(batchUpdateRequest) as! NSBatchUpdateResult
            print(result.result!)
        } catch {
            Logger.CoreData.error("\(error.localizedDescription)")
        }
    }
    
    /*
     link: /https://www.avanderlee.com/swift/nsbatchdeleterequest-core-data/
     Notes:
     -  It runs faster than deleting Core Data entities yourself on a managed object context as they operate at the SQL level in the persistent store itself.
     - Setting up an NSBatchDeleteRequest is fairly simple. It requires either passing in an NSFetchRequest instance or a collection of managed object identifiers
     - After executing the NSBatchDeleteRequest you’ll find out that your entities still exist in memory. This is a result of the fact that the NSBatchDeleteRequest is an NSPersistentStoreRequest which operates at the SQL level in the persistent store itself. Therefore, you need to manually update your in-memory objects after execution.
     - This will update your in-memory object and as well send out notifications like NSManagedObjectContextObjectsDidChange
     - Validation rules like Core Data relationships are ignored.In this case, it might be easier to go for the regular delete method which does respect validation rules
     -  In other words, don’t use an NSBatchDeleteRequest if:
        - The entity you’re deleting contains validation rules like relationships
        - You’re deleting multiple different kinds of entities
        - You are not using an SQLite backing store
     */
    static func DeleteAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: CDComment.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
//        deleteRequest.resultType = .resultTypeObjectIDs
//
//        do {
//            let result = try PersistentStorage.shared.context.execute(deleteRequest) as! NSBatchDeleteResult
//            let changes: [AnyHashable: Any] = [
//                NSDeletedObjectsKey: result.result as! [NSManagedObjectID]
//            ]
//            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [PersistentStorage.shared.context])
//        } catch {
//            Logger.CoreData.error("\(error.localizedDescription)")
//        }
        do {
            try         PersistentStorage.shared.context.executeAndMergeChanges(using: deleteRequest)
        } catch {
            Logger.CoreData.error("\(error.localizedDescription)")
        }
    }
}
extension NSManagedObjectContext {
    
    /// Executes the given `NSBatchDeleteRequest` and directly merges the changes to bring the given managed object context up to date.
    ///
    /// - Parameter batchDeleteRequest: The `NSBatchDeleteRequest` to execute.
    /// - Throws: An error if anything went wrong executing the batch deletion.
    public func executeAndMergeChanges(using batchDeleteRequest: NSBatchDeleteRequest) throws {
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        let result = try execute(batchDeleteRequest) as? NSBatchDeleteResult
        let changes: [AnyHashable: Any] = [NSDeletedObjectsKey: result?.result as? [NSManagedObjectID] ?? []]
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [self])
    }
}
