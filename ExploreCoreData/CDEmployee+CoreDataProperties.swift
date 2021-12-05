//
//  CDEmployee+CoreDataProperties.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 04/12/21.
//
//

import Foundation
import CoreData


extension CDEmployee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEmployee> {
        return NSFetchRequest<CDEmployee>(entityName: "CDEmployee")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var profilePic: Data?
    @NSManaged public var passport: CDPassport?

}

extension CDEmployee : Identifiable {

}
