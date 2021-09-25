//
//  Inheritance.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 21/09/21.
//

import Foundation
import UIKit

/* Example for flat json structure
 [
         {
         color = red;
         company = "Maruti Suzuki";
         maxSpeedLimit = 120;
         model = 2016;
         name = Swift;
     },
         {
         color = White;
         company = Hyundai;
         maxSpeedLimit = 100;
         model = 2020;
         name = Verna;
     }
 ]
 */
fileprivate class Vehicle: Codable {
    let name: String
    let color: String
    let model: Int
}

fileprivate class Car: Vehicle {
    private(set) var company: String = ""
    private(set) var maxSpeedLimit: Int = 0
    
    enum CodingKeys: String, CodingKey {
        case company
        case maxSpeedLimit
    }

    required init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: CodingKeys.self)
        company = try baseContainer.decode(String.self, forKey: .company)
        maxSpeedLimit = try baseContainer.decode(Int.self, forKey: .maxSpeedLimit)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(company, forKey: .company)
        try baseContainer.encode(maxSpeedLimit, forKey: .maxSpeedLimit)
        try super.encode(to: encoder)
    }
}

// Main function or starting point
func serializeCar() {
    do {
        let data = try String(contentsOf: Bundle.main.url(forResource: "cars", withExtension: "json")!).data(using: .utf8)!
        let cars = try JSONDecoder().decode([Car].self, from: data)
        debugPrint(cars)
        let encoder = try JSONEncoder()
        encoder.outputFormatting = .sortedKeys
        let dataEncoded = try encoder.encode(cars)
        print("Encoded data", try JSONSerialization.jsonObject(with: dataEncoded, options: []))
    } catch {
        print("Failed with error: \(error)")
    }
}

/* Example for nested json structure
 {
    "toy":{
       "name":"Teddy Bear"
    },
    "employee":{
       "name":"John Appleseed",
       "id":7
    },
    "birthday":597607945.92342305
 }
 */
fileprivate struct Toy: Codable {
    let name: String
}

fileprivate class BasicEmployee: Codable {
    let name: String
    let id: Int
}

fileprivate class GiftedEmployee: BasicEmployee {
    let toy: Toy
    let birthday: Double
    
    enum CodingKeys: String, CodingKey {
        case toy, birthday, employee
    }
    
    required init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: CodingKeys.self)
        toy = try baseContainer.decode(Toy.self, forKey: .toy)
        birthday = try baseContainer.decode(Double.self, forKey: .birthday)
        
        let employeeDecoder = try baseContainer.superDecoder(forKey: .employee)
        try super.init(from: employeeDecoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var baseContainer = encoder.container(keyedBy: CodingKeys.self)
        try baseContainer.encode(toy, forKey: .toy)
        try baseContainer.encode(birthday, forKey: .birthday)
        
        let employeeEncoder = baseContainer.superEncoder(forKey: .employee)
        try super.encode(to: employeeEncoder)
    }
}

func serializeGiftedEmployee() throws {
    let data = try String(contentsOf: Bundle.main.url(forResource: "GiftedEmployee", withExtension: "json")!).data(using: .utf8)!
    let employees = try JSONDecoder().decode([GiftedEmployee].self, from: data)
    debugPrint(employees)
    let dataEncoded = try JSONEncoder().encode(employees)
    print("Encoded data", try JSONSerialization.jsonObject(with: dataEncoded, options: []))
}
