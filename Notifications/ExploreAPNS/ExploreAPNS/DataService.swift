//
//  DataService.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 08/10/22.
//

import Foundation
import Combine

struct Post: Identifiable, Decodable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

struct DataService {
    private let url = "https://jsonplaceholder.typicode.com/posts"
    
    func fetchPosts() -> AnyPublisher<[Post], Error> {
        let url = URL(string: url)!
        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .userInitiated))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300, response.mimeType == "application/json" else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: [Post].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
}
