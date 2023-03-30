//
//  EnumBasedParsing.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 17/10/22.
//

import Foundation

fileprivate struct Actor: Codable {
    let name: String
    let age: Int
    let bornAt: String
    let birthdate: Date
    let photo: URL
}

fileprivate struct Vehicle: Codable {
    let name: String
    let milesPerGallon: Int
    let cylinders: Int
    let displacement: Int
    let horsepower: Int
    let weightInLbs: Int
    let acceleration: Int
    let year: Date
    let origin: String
}

fileprivate enum ItemType: Codable {
    case vehicle(Vehicle)
    case actor(Actor)
    
    enum Keys: String, CodingKey {
        case type
    }
    
    enum ItemName: String {
        case vehicle = "Vehicle"
        case actor = "Actor"
    }
        
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Keys.self)
        let type = try container.decode(String.self, forKey: .type)
        switch type {
        case ItemName.vehicle.rawValue:
            self = .vehicle(try Vehicle(from: decoder))
        case ItemName.actor.rawValue:
            self = .actor(try Actor(from: decoder))
        default:
           throw DecodingError.dataCorrupted(.init(codingPath: container.codingPath, debugDescription: "No valid type", underlyingError: nil))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .vehicle(let vehicle):
            try container.encode(vehicle)
        case .actor(let actor):
            try container.encode(actor)
        }
    }
}

fileprivate struct JsonModel: Decodable {
    let items: [ItemType]
    
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var items = [ItemType]()
        while !container.isAtEnd {
            
            items.append(try container.decode(ItemType.self))
        }
        self.items = items
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        self.items = try container.decode([ItemType].self)
//    }
}

fileprivate struct JsonModelDecodeIfPresent: Codable {
    let items: [Any]
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        var items = [Any]()
        while !container.isAtEnd {
            if let vehicle = try? container.decodeIfPresent(Vehicle.self) {
                items.append(vehicle)
                
            /*Throwing error if try is not optional
             Decoding failed with error: keyNotFound(CodingKeys(stringValue: "milesPerGallon", intValue: nil), Swift.DecodingError.Context(codingPath: [_JSONKey(stringValue: "Index 1", intValue: 1)], debugDescription: "No value associated with key CodingKeys(stringValue: \"milesPerGallon\", intValue: nil) (\"milesPerGallon\"), converted to miles_per_gallon.", underlyingError: nil))
             */
            } else if let actor = try? container.decodeIfPresent(Actor.self) {
                items.append(actor)
            }
        }
        self.items = items
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        for item in items {
            if let vehicle = item as? Vehicle {
                try container.encode(vehicle)
            } else if let actor = item as? Actor {
                try container.encode(actor)
            }
        }
    }
}

fileprivate extension DateFormatter {
    static let normal: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD"
        return formatter
    }()
}

func enumBasedParsing() throws {
    let data = try String(contentsOf: Bundle.main.url(forResource: "ArrayDiff", withExtension: "json")!).data(using: .utf8)!
    let jsondecoder = JSONDecoder()
    jsondecoder.dateDecodingStrategy = .formatted(.normal)
    jsondecoder.keyDecodingStrategy = .convertFromSnakeCase
    let model = try jsondecoder.decode(JsonModelDecodeIfPresent.self, from: data)
    print(model)
}
