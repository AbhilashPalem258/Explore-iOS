//
//  CDPassport+CoreDataProperties.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 04/12/21.
//
//

import Foundation
import CoreData


extension CDPassport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDPassport> {
        return NSFetchRequest<CDPassport>(entityName: "CDPassport")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var issuePlace: String?
    @NSManaged public var name: String?
    @NSManaged public var employee: CDEmployee?

}

extension CDPassport : Identifiable {

}
