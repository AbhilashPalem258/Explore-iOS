//
//  CSSpotlightVC.swift
//  ExploreUserActivity
//
//  Created by Abhilash Palem on 03/03/23.
//

import Foundation
import UIKit
import CoreSpotlight

// Scene | continueuserActivity | <NSUserActivity: 0x2800b9f20> | Optional([AnyHashable("kCSSearchQueryString"): movie , AnyHashable("kCSSearchableItemActivityIdentifier"): com.abhilashpalem.ExploreUserActivity.movies.1])
struct Movie: Identifiable {
    let id: UUID = UUID()
    let name: String
    let description: String
    let thumbnail: URL
    
    static var all: [Movie] = [
        .init(name: "Movie #1", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,", thumbnail: Bundle.main.url(forResource: "movie1", withExtension: "jpeg") ?? URL(string: "")!),
        .init(name: "Movie #2", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,", thumbnail: Bundle.main.url(forResource: "movie2", withExtension: "png") ?? URL(string: "")!),
        .init(name: "Movie #3", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,", thumbnail: Bundle.main.url(forResource: "movie3", withExtension: "jpeg") ?? URL(string: "")!),
        .init(name: "Movie #4", description: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,", thumbnail: Bundle.main.url(forResource: "movie4", withExtension: "jpeg") ?? URL(string: "")!)
    ]
}

class CSSpotlightVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addMovieeDataToSpotlight()
        CSSearchableItemActionType
    }
    
    func addMovieeDataToSpotlight() {
        var searchableItems = [CSSearchableItem]()
        for i in 0..<Movie.all.count {
            let movie = Movie.all[i]
            
            let attributeSet = CSSearchableItemAttributeSet(contentType: .text)
            attributeSet.title = movie.name
            attributeSet.contentDescription = movie.description
            attributeSet.thumbnailURL = movie.thumbnail
            attributeSet.keywords = ["\(movie.name)", "movie", "abhilash", "xyz", "Dom", "shiny", "dakini"]
            
            let item = CSSearchableItem(uniqueIdentifier: "com.abhilashpalem.ExploreUserActivity.movies.\(i)", domainIdentifier: "Abhilash movies", attributeSet: attributeSet)
            
            searchableItems.append(item)
        }
        
        CSSearchableIndex.default().indexSearchableItems(searchableItems) { error in
            if error != nil {
                print("Failed to index searchable items: \(error)")
            }
        }
    }
}
