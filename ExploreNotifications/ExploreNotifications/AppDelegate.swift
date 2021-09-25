//
//  AppDelegate.swift
//  ExploreNotifications
//
//  Created by Abhilash Palem on 13/09/21.
//

import UIKit

/*
 links:
 https://developer.apple.com/videos/play/wwdc2020/10095/
 */

/*
 Types of Notifications:
 - Remote Notififcations
 - Local Notifications
 
 Types of Remote Notifications:
 - Alert Notifications
 - Background Notifications
 */

/*
 Payload for Background Notification
 {
    "aps": {
        "content-available": 1
    },
    "myCustomKey": "myCustomData"
 }
 
 Payload for Alert Notification
 {
     "aps": {
         "alert": {
            "title": "Checkout our new special!",
            "subtitle" : "Five Card Draw",
            "body": "Avocado Bacon Burger on sale"
          },
          "sound": "default",
          "badge": 1,
          "category" : "GAME_INVITATION"
     },
     "special": "avocodo_bacon_burger",
     "price": "9.99"
 }
 */



@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to regisster remote notifications")
    }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Device token:", String(data: deviceToken, encoding: .utf8)!)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        completionHandler(.newData)
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

