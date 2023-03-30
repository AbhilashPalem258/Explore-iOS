//
//  NonConfirmabilityEncodingStrategy.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 23/09/21.
//

import Foundation
/*
 https://benscheirman.com/2017/06/swift-json/
 */
fileprivate let jsonStr = """
{
    "a": "NaN",
    "b": "+Infinity",
    "c": "-Infinity"
}
"""

fileprivate struct NonConfirmability: Decodable {
    let a: Float
    let b: Float
    let c: Float
}

func decodeNonConfirmability() throws {
    let decoder = JSONDecoder()
    decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
    let model = try decoder.decode(NonConfirmability.self, from: jsonStr.data(using: .utf8)!)
    print(model)
}
