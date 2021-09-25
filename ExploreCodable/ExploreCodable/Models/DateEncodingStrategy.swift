//
//  DateEncodingStrategy.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 23/09/21.
//

import Foundation

/*
 DateFormats:
 
 iso8601 -> "1999-04-03T17:30:31Z"
 millisecondsSince1970  -> 1432233446145.0 -> secondsSince1970 * 1000.0
 secondsSince1970 -> millisecondsSince1970/1000.0 -> 1431025588
 
 DefferedToDate date encoding strategy:
 json:
 {
    "date": 123.0
 }
 
 output: It calcuates input values as seconds from 2001 start
 date: 2001-01-01 00:02:03 +0000
 */

fileprivate let jsonStr = """
{
    "name": "Any name",
    "dated": "2017-11-16T02:02:55.000-08:00",
    "releaseDate":"2017-11-03",
    "nested": {
        "date": 123.0
    }
}
"""

fileprivate struct Nested: Decodable {
    let date: Date
}

fileprivate struct Model: Decodable {
    let name: String
    let dated: Date
    let releaseDate: Date
    let nested: Nested
    
    enum Keys: String, CodingKey {
        case name, dated, releaseDate, nested
    }
    
    init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: Keys.self)
        name = try baseContainer.decode(String.self, forKey: .name)
        
        let datedStr = try baseContainer.decode(String.self, forKey: .dated)
        let isoformatter = DateFormatter.isoFull
        if let date = isoformatter.date(from: datedStr) {
            dated = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: Keys.dated, in: baseContainer, debugDescription: "Date string does not match format expected by formatter")
        }
        
        let releaseDateStr = try baseContainer.decode(String.self, forKey: .releaseDate)
        let formatter = DateFormatter.yyyyMMdd
        if let date = formatter.date(from: releaseDateStr) {
            releaseDate = date
        } else {
            throw DecodingError.dataCorruptedError(forKey: Keys.releaseDate, in: baseContainer, debugDescription: "Date string does not match format expected by formatter")
        }
        
        nested = try baseContainer.decode(Nested.self, forKey: .nested)
    }
}

func decodeDates() throws {
    let decoder = JSONDecoder()
//    decoder.dateDecodingStrategy = .formatted(DateFormatter.isoFull)
    decoder.dateDecodingStrategy = .custom { decoder -> Date in
        let dateStr = try decoder.singleValueContainer().decode(String.self)
        let formatter = DateFormatter.isoFull
        return formatter.date(from: dateStr) ?? Date()
    }
    
// date comes as number of days since 1970
//    decoder.dateDecodingStrategy = .custom { decoder throws -> Date  in
//        let days = try decoder.singleValueContainer().decode(Int.self)
//
//        let startDate = Date(timeIntervalSince1970: 0)
//
//        var components = DateComponents()
//        components.day = days
//
//        let calendar = Calendar(identifier: .gregorian)
//        return calendar.date(byAdding: components, to: startDate) ?? Date()
//    }
    
    //DefferedToDate
    decoder.dateDecodingStrategy = .deferredToDate
    let model = try decoder.decode(Model.self, from: jsonStr.data(using: .utf8)!)
    print(model)
}

fileprivate extension DateFormatter {
    static var isoFull: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }
    
    static var yyyyMMdd: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }
}

