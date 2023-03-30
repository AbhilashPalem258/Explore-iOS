//
//  ViewController.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 19/09/21.
//

import UIKit
/*
 links:
 https://medium.com/hackernoon/swift-codability-d0d232065cad - Overview
 https://www.raywenderlich.com/3418439-encoding-and-decoding-in-swift - Overview
 https://stackoverflow.com/questions/59254573/swift-encode-class-without-nesting-super-class - Inheritance
 https://www.hackingwithswift.com/articles/119/codable-cheat-sheet - DateEncoding
 https://swiftrocks.com/swift-codable-decodingencoding-with-context - CodingUserInfoKey
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        serializeCar()
        do {
            try enumBasedParsing()
//            try encodeA()
//            try decodeHeaderInformation()
//            try decodeDates()
//            try serializeCar()
//            try decodeNonConfirmability()
//            print(try decodeLandmarks())
        } catch {
            print("Decoding failed with error: \(error)")
        }
    }

    func decodeLandmarks() throws -> [LandmarkUnNested] {
        let str = try String(contentsOf: Bundle.main.url(forResource: "landmarks", withExtension: "json")!)
        let data = str.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        let landmarks = try decoder.decode(LandmarkJsonModel.self, from: data)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [
            .prettyPrinted,
            .sortedKeys,
            .withoutEscapingSlashes
        ]
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let encodedData = try encoder.encode(landmarks)
        print(String(data: encodedData, encoding: .utf8)!)
        
        return landmarks.landmarks

    }
    
    func encodeA() throws {
        let a = A(value: 1, b: .init(value: 2, c: .init(value: 3)))
        print(a.b.c)
        
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        let encodeAndPrint = { print(String(data: try encoder.encode(a), encoding: .utf8) ?? "String encoding error.") }
        
        // Customize each `value` key to contain a dot-syntax path.
        encoder.keyEncodingStrategy = .custom { keys in
            if keys.last!.stringValue == "value" {
                return AnyKey(stringValue: "a." + keys.map { key in
                    key.stringValue
                }.joined(separator: "."))!
            } else {
                return keys.last!
            }
        }

        try encodeAndPrint()
    }
}
