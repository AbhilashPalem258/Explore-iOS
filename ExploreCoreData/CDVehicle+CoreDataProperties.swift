//
//  CDVehicle+CoreDataProperties.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 04/12/21.
//
//

import Foundation
import CoreData


extension CDVehicle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDVehicle> {
        return NSFetchRequest<CDVehicle>(entityName: "CDVehicle")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var type: String?
    @NSManaged public var company: String?
    @NSManaged public var toPerson: CDPerson?

}

extension CDVehicle : Identifiable {

}
