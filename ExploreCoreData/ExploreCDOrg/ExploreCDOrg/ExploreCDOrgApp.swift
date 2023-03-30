//
//  ExploreCDOrgApp.swift
//  ExploreCDOrg
//
//  Created by Abhilash Palem on 29/01/23.
//

import SwiftUI

/*
 - Continent
 - Country
 - State
 - City
 
 - Person(Abstract) [name, email, age, gender]
 - Employee
 */
/*
 NSBatchUpdateRequest
 NSBatchDeleteRequest: https://www.avanderlee.com/swift/nsbatchdeleterequest-core-data/
 Transformable types
 Linking Data Between Two Core Data Stores
 NSAsynchronousFetchRequest
 Advanced: https://www.advancedswift.com/tag/databases/
 */
/*
 Multiple Modeld files into single DB: https://nemecek.be/blog/42/how-to-create-core-data-database-from-multiple-model-files
 country flags urls: https://www.kaggle.com/datasets/zhongtr0n/country-flag-urls
 */
@main
struct ExploreCDOrgApp: App {
    var body: some Scene {
        WindowGroup {
            FetchedPropertyView()
        }
    }
}
