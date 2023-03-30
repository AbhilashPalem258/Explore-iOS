//
//  CDEmployee+CoreDataProperties.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 30/01/23.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var company: String?
    @NSManaged public var country: CDCountry?

}
