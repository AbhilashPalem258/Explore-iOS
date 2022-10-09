//
//  ExploreAPNSApp.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 06/10/22.
//

import SwiftUI

@main
struct ExploreAPNSApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            GallerySwiftUIView()
        }
    }
}
