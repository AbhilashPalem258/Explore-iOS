//
//  CountryRepository.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 29/01/23.
//

import Foundation
import CoreData
import OSLog

protocol BaseCDRepository {
    associatedtype T
    
    func create(_ record: T)
    func getAll() -> [T]
    func get(id: UUID) -> T?
    func update(_ record: T) -> Bool
    func delete(id: UUID)
}

struct CountryRepository {
    private func getCountry(with id: UUID) -> CDCountry? {
        let fetchRequest = NSFetchRequest<CDCountry>.init(entityName: String(describing: CDCountry.self))
        fetchRequest.predicate = NSPredicate(format: "id==%@", id as CVarArg)
        
        do {
            guard let country = try PersistentStorage.shared.context.fetch(fetchRequest).first else {
                return nil
            }
            return country
        } catch {
            Logger.CoreData.error("Failed to fetch Country record with id: \(id)")
        }

        return nil
    }
}
extension CountryRepository {
    func create(_ record: Country) {
        let _ = CDCountry.create(record)
        
        PersistentStorage.shared.save()
    }
    
    func getAll() -> [Country] {
        guard let countries = PersistentStorage.shared.fetch(managedObjectType: CDCountry.self) else {
            return []
        }
        
        let result = countries.map { $0.convertToCountry() }
        return result
    }
    
    func get(id: UUID) -> Country? {
        guard let country = getCountry(with: id) else {
            return nil
        }
        return country.convertToCountry()
    }

    func update(_ record: Country) -> Bool {
        guard let _ = getCountry(with: record.id) else {
            return false
        }
        let _ = CDCountry.create(record)
        PersistentStorage.shared.save()
        return true
    }

    func delete(id: UUID) -> Bool {
        guard let cdCountry = getCountry(with: id) else {
            return false
        }
        PersistentStorage.shared.context.delete(cdCountry)
        PersistentStorage.shared.save()
        return true
    }
}
