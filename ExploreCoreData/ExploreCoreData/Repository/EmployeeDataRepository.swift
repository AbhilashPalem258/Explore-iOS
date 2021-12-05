//
//  EmployeeDataRepository.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 04/12/21.
//

import Foundation
import CoreData
import OSLog

protocol BaseRepository {
    associatedtype T
    
    func create(record: T)
    func getAll() -> [T]
    func get(id: UUID) -> T?
    func update(record: T) -> Bool
    func delete(id: UUID) -> Bool
}

struct EmployeeDataRepository: BaseRepository {
    func create(record: Employee) {
        let employee = CDEmployee(context: PersistentStorage.shared.context)
        employee.id = UUID()
        employee.email = record.email
        employee.name = record.name
        employee.profilePic = record.profilePic
        
        if let passport = record.passport {
            let cdPassport = CDPassport(context: PersistentStorage.shared.context)
            cdPassport.id = passport.id
            cdPassport.name = passport.name
            cdPassport.issuePlace = passport.issuePlace
            
            employee.passport = cdPassport
        }
        
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [Employee] {
        let result = PersistentStorage.shared.fetchManagedObject(managedObjectType: CDEmployee.self)
        
        var employees = [Employee]()
        result?.forEach {
            employees.append($0.convertToEmployee())
        }
        return employees
    }
    
    func get(id: UUID) -> Employee? {
        let cdEmployee = getEmployee(id: id)
        return cdEmployee?.convertToEmployee()
    }
    
    func update(record: Employee) -> Bool {
        let existingRecord = getEmployee(id: record.id)
        guard let existingRecord = existingRecord else {
            return false
        }
        
        existingRecord.profilePic = record.profilePic
        existingRecord.email = record.email
        existingRecord.name = record.name
        
        existingRecord.passport?.issuePlace = record.passport?.issuePlace
        existingRecord.passport?.name = record.passport?.name
        
        PersistentStorage.shared.saveContext()
        return true
    }
    
    func delete(id: UUID) -> Bool {
        let existingRecord = getEmployee(id: id)
        guard let existingRecord = existingRecord else {
            return false
        }
        
        PersistentStorage.shared.context.delete(existingRecord)
        PersistentStorage.shared.saveContext()
        
        return true
    }
    
    private func getEmployee(id: UUID) -> CDEmployee? {
        let fetchRequest = NSFetchRequest<CDEmployee>(entityName: String(describing: CDEmployee.self))
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            return result
        } catch let error {
            Logger.CoreData.error("\(error.localizedDescription)")
        }
        return nil
    }
    
}
