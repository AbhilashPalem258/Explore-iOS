//
//  CodingKeyEncodable.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 20/09/21.
//

import UIKit

struct A: Codable {
    var value: Int
    var b: B
    
    struct B: Codable {
        var value: Int
        var c: C
        
        struct C: Codable {
            var value: Int
        }
    }
}

struct AnyKey: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
        self.stringValue = String(intValue)
        self.intValue = intValue
    }
}
