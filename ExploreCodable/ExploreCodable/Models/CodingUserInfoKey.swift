//
//  SwiftRocks.swift
//  ExploreCodable
//
//  Created by Abhilash Palem on 22/09/21.
//

import Foundation
import UIKit

fileprivate let HeaderInfoJson: String = """
{
    "title": "My App Header",
    "image_url": "https://picsum.photos/200/300",
}
"""

fileprivate struct HeaderInformation: Decodable {
    let title: String
    let imageUrl: String
    var textColor: String
    
    static var textColorCodingUserInfoKey: CodingUserInfoKey {
        return CodingUserInfoKey(rawValue: "textColor")!
    }
    
    enum CodingKeys: String, CodingKey {
        case title, imageUrl
    }
    
    init(from decoder: Decoder) throws {
        let baseContainer = try decoder.container(keyedBy: CodingKeys.self)
        title = try baseContainer.decode(String.self, forKey: .title)
        imageUrl = try baseContainer.decode(String.self, forKey: .imageUrl)
        
//        textColor = decoder.userInfo[CodingUserInfoKey(rawValue: "textColor")!] as? String ?? ""
//        textColor = decoder.userInfo[Self.textColorCodingUserInfoKey] as? String ?? ""
        textColor = decoder.getContext(forKey: "textColor") as? String ?? ""
    }
}

func decodeHeaderInformation() throws {
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
//    decoder.userInfo[CodingUserInfoKey(rawValue: "textColor")!] = "red"
//    decoder.userInfo[HeaderInformation.textColorCodingUserInfoKey] = "red"
    decoder.setContext(context: "blue", forKey: "textColor")
    let model = try decoder.decode(HeaderInformation.self, from: HeaderInfoJson.data(using: .utf8)!)
    print(model)
}

fileprivate extension Decoder {
    func getContext(forKey key: String) -> Any? {
        let infoKey = CodingUserInfoKey(rawValue: key)!
        return self.userInfo[infoKey]
    }
}

fileprivate extension JSONDecoder {
    func setContext(context: Any, forKey key: String) {
        let infokey = CodingUserInfoKey(rawValue: key)!
        self.userInfo[infokey] = context
    }
}
