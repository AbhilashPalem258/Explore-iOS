//
//  Employee.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 04/12/21.
//

import Foundation

struct Employee {
    let email: String
    let id: UUID
    let name: String
    let profilePic: Data
    let passport: Passport?
}

struct Passport {
    let id: UUID
    let name: String
    let issuePlace: String
}
