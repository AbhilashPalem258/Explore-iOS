//
//  URLLoadingSystemApp.swift
//  URLLoadingSystem
//
//  Created by Abhilash Palem on 15/10/22.
//

import SwiftUI

@main
struct URLLoadingSystemApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            FileDownloadsView()
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    var backgroundSessionHandler: (() -> Void)?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { status, error in
            
        }
        return true
    }
    
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        self.backgroundSessionHandler = completionHandler
    }
}
