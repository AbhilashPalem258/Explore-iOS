//
//  Explore_GoogleMapsApp.swift
//  Explore-GoogleMaps
//
//  Created by Abhilash Palem on 03/01/23.
//

import SwiftUI
import GoogleMaps

@main
struct Explore_GoogleMapsApp: App {
    
    init() {
        GMSServices.provideAPIKey("AIzaSyAASpX7MsFa83FkVZ9V6M6QZ-4ubUdxOqc")
        GMSServices.setMetalRendererEnabled(true)
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
