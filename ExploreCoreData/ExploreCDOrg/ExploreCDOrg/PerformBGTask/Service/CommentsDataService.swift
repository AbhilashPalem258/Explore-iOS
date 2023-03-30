//
//  PostsDataService.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 31/01/23.
//

import Combine
import Foundation

enum CommentsDataService {
    static func fetchPosts() -> AnyPublisher<[Comment], Error> {
        let url = URL(string: "https://jsonplaceholder.typicode.com/comments")!
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300, let mimeType = response.mimeType, mimeType == "application/json" else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Comment].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}

struct Comment: Identifiable, Decodable {
    let postId: Int64
    let id: Int64
    let name: String
    let email: String
    let body: String
    var customVal: CustomClassForCDEntity?
}
