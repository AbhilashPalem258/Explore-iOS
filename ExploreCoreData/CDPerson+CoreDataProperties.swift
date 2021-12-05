//
//  CDPerson+CoreDataProperties.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 04/12/21.
//
//

import Foundation
import CoreData


extension CDPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPerson> {
        return NSFetchRequest<CDPerson>(entityName: "CDPerson")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var email: String?
    @NSManaged public var toVehicle: NSSet?

}

// MARK: Generated accessors for toVehicle
extension CDPerson {

    @objc(addToVehicleObject:)
    @NSManaged public func addToToVehicle(_ value: CDVehicle)

    @objc(removeToVehicleObject:)
    @NSManaged public func removeFromToVehicle(_ value: CDVehicle)

    @objc(addToVehicle:)
    @NSManaged public func addToToVehicle(_ values: NSSet)

    @objc(removeToVehicle:)
    @NSManaged public func removeFromToVehicle(_ values: NSSet)

}

extension CDPerson : Identifiable {

}
