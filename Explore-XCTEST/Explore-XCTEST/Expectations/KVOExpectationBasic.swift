//
//  KVOExpectationBasic.swift
//  Explore-XCTEST
//
//  Created by Abhilash Palem on 27/10/22.
//

import Foundation

class Person: NSObject {
    @objc dynamic var name: String = ""
    @objc dynamic var isindian: Bool = true
}

struct Electionmanager {
    
    let personObj = Person()
    
    func fetchPersondetails() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(6)) {
            self.personObj.name = "Abhilash Palem"
            self.personObj.isindian = false
        }
    }
}
