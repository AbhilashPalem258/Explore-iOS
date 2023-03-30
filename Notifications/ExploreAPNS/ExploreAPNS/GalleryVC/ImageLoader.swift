//
//  ImageLoader.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 09/10/22.
//

import Foundation
import Combine

private let ImageUrlSession: URLSession = {
    let configuration = URLSessionConfiguration.default
    configuration.urlCache = URLCache.shared
    configuration.requestCachePolicy = .returnCacheDataElseLoad
    
    let session = URLSession(configuration: configuration)
    return session
}()

struct ImageLoader {
    
    private init(){}
    static let shared = ImageLoader()
    
    func fetchImage(url: URL) -> AnyPublisher<Data, Error> {
        ImageUrlSession.dataTaskPublisher(for: url)
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) in
                if let response = response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 {
                    return data
                }
                throw URLError(.badServerResponse)
            }
            .eraseToAnyPublisher()
    }
}
