//
//  Landmark.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 19/09/21.
//

import UIKit

struct LandmarkJsonModel: Codable {
    let landmarks: [LandmarkUnNested]
}

struct Landmark: Codable {
    let name: String
    let foundingYear: String
    let location: Coordinates
    let url: URL
}

struct Coordinates: Codable {
    let latitude: Double
    let longitude: Double
}

struct LandmarkUnNested {
    let name: String
    let foundingYear: String
    let latitude: Double
    let longitude: Double
    
    enum CodingKeys: String, CodingKey {
        case name
        case foundingYear
        case location
    }

    enum LocationCodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
extension LandmarkUnNested: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        foundingYear = try container.decode(String.self, forKey: .foundingYear)
        
        let locationContainer = try container.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .location)
        latitude = try locationContainer.decode(Double.self, forKey: .latitude)
        longitude = try locationContainer.decode(Double.self, forKey: .longitude)
    }
}
extension LandmarkUnNested: Encodable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(foundingYear, forKey: .foundingYear)
        
        var locationContainer = container.nestedContainer(keyedBy: LocationCodingKeys.self, forKey: .location)
        try locationContainer.encode(latitude, forKey: .latitude)
        try locationContainer.encode(longitude, forKey: .longitude)
    }
}
