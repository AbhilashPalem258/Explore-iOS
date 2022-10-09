//
//  CDEmployee+extension.swift
//  ExploreCoreData
//
//  Created by Abhilash Palem on 04/12/21.
//

import Foundation

extension CDEmployee {
    func convertToEmployee() -> Employee {
        return Employee(email: self.email!, id: self.id!, name: self.name!, profilePic: self.profilePic!, passport: self.passport?.convertToPassport())
        
    }
}
extension CDPassport {
    func convertToPassport() -> Passport {
        return Passport(id: self.id!, name: self.name!, issuePlace: self.issuePlace!)
    }
}
