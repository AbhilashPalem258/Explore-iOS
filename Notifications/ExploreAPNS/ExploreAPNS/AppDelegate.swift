//
//  AppDelegate.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 06/10/22.
//

import Foundation
import UIKit
import UserNotifications
import Combine

//https://www.objc.io/issues/5-ios7/multitasking/

class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    let handler = UserNotificationHandler()
    private var cancellables = Set<AnyCancellable>()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let options: UNAuthorizationOptions = [
            .badge,
            .alert,
            .sound,

            //An option indicating the system should display a button for in-app notification settings.
            //When we swipe a notfication in list, we can see options button and clicking on it will open a list where we can select a button called `Configure in ExploreAPNS`, clicking on it calls userNotificationCenter: OpenSettingsFor method in UNuserNotificationCenter Delegate.
            //Also if we are using this in combination with UNAuthorizationOption.provisional, and when user want to turm off from Notification center, there we can see the option `Configure in ExploreAPNS`.
            .providesAppNotificationSettings,
            
            
            //The application is provisionally authorized to post noninterruptive user notifications.
            /*
             - Using this option, doesnt ask user permisiion alert for sending notification
             - It also does not disturn user by sound, alert or in notification center, it just delivers silently.
             - When viewing this alert in notification center, it has two options
                - Keep [Alert][Deliver Immediately, Deliver in Scheduled Summary]
                - Turn Off [Alert][Turn Off All Notifications, Configure in ExploreAPNS...]
             */
//            .provisional
        ]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { status, error in
            DispatchQueue.main.async {[weak self] in
                if status {
                    UNUserNotificationCenter.current().delegate = self?.handler
                    UNUserNotificationCenter.current().setNotificationCategories([CategoryFactory.testCategory1])
                    application.registerForRemoteNotifications()
                }
                if let error = error {
                    print("Authorization failed with error: \(error)")
                }
            }
        }
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let deviceTokenString = deviceToken.hexString
        print("Device Token  " + deviceTokenString)
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to Register Remote Notifications:\(error.localizedDescription)")
    }
}
extension AppDelegate {
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        DataService().fetchPosts()
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Failed to fetch posts with error: \(error)")
                    completionHandler(.failed)
                default:
                    break
                }
            } receiveValue: { posts in
                completionHandler(.newData)
            }
            .store(in: &cancellables)
    }
}
extension Data {
    var hexString: String {
        let hexString = map { String(format: "%02.2hhx", $0) }.joined()
        return hexString
    }
}
