//
//  Explore_OSLOGApp.swift
//  Explore-OSLOG
//
//  Created by Abhilash Palem on 29/10/22.
//

import SwiftUI

@main
struct Explore_OSLOGApp: App {
    var body: some Scene {
        WindowGroup {
            LoggerBootcampView(vm: ViewModel())
        }
    }
}
