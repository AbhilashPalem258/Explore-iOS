//
//  CDPerson+CoreDataProperties.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 30/01/23.
//
//

import Foundation
import CoreData


extension CDPerson {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPerson> {
        return NSFetchRequest<CDPerson>(entityName: "CDPerson")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int64
    @NSManaged public var email: String?
    @NSManaged public var gender: Bool

}

extension CDPerson : Identifiable {

}
