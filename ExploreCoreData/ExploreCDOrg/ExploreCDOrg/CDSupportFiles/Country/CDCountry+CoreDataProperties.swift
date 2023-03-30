//
//  CDCountry+CoreDataProperties.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 30/01/23.
//
//

import Foundation
import CoreData


extension CDCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCountry> {
        return NSFetchRequest<CDCountry>(entityName: "CDCountry")
    }

    @NSManaged public var flag: URL
    @NSManaged public var id: UUID
    @NSManaged public var lifeExpectancy: Float
    @NSManaged public var name: String
    @NSManaged public var population: Int64
    @NSManaged public var populationDensity: Float
    @NSManaged public var people: NSSet?

}

// MARK: Generated accessors for people
extension CDCountry {

    @objc(addPeopleObject:)
    @NSManaged public func addToPeople(_ value: CDEmployee)

    @objc(removePeopleObject:)
    @NSManaged public func removeFromPeople(_ value: CDEmployee)

    @objc(addPeople:)
    @NSManaged public func addToPeople(_ values: Set<CDEmployee>)

    @objc(removePeople:)
    @NSManaged public func removeFromPeople(_ values: Set<CDEmployee>)

}

extension CDCountry : Identifiable {

}
