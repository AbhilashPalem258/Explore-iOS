//
//  NonConfirmabilityEncodingStrategy.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 23/09/21.
//

import Foundation

fileprivate let jsonStr = """
{
    "positiveInfinity": Infinity,
    "negInfinity": -Infinity,
    "nan": NULL
}
"""

fileprivate struct NonConfirmability: Decodable {
    let positiveInf: String
    let negativeInf: String
    let nan: String
}

func decodeNonConfirmability() throws {
    let decoder = JSONDecoder()
    decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "Not an object")
    let model = try decoder.decode(NonConfirmability.self, from: jsonStr.data(using: .utf8)!)
    print(model)
}
