//
//  UserNotificationHandler.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 08/10/22.
//

import Foundation
import UserNotifications

class UserNotificationHandler: NSObject, UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let actionId = response.actionIdentifier
        let targetScene = response.targetScene
        let notification = response.notification
        let content = notification.request.content
        let userInfo = content.userInfo
        let catergoryIdentifier = content.categoryIdentifier
        
        print("""
        ============================================
        Did receive Remote Notification In Background
        
        Action ID: \(actionId)
        Target Scene: \(String(describing: targetScene))
        notification: \(notification)
        content: \(content)
        userInfo: \(userInfo)
        catergoryIdentifier: \(catergoryIdentifier)
        ============================================
        """)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let notificationRequest = notification.request
        let notificationTime = notification.date
        let content = notificationRequest.content
        let title = content.title
        let subTitle = content.subtitle
        let body = content.body
        let sound = content.sound
        let badge = content.badge
        let userInfo = content.userInfo
        
        print("""
        ============================================
        Did receive Remote Notification In Foreground
        
        Notification Request: \(notificationRequest)
        Notification Time: \(notificationTime)
        notification: \(notification)
        content: \(content)
        userInfo: \(userInfo)
        title: \(title)
        subTitle: \(subTitle)
        body: \(body)
        badge: \(String(describing: badge))
        sound: \(String(describing: sound))
        ============================================
        """)
        
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("Called Open In-App Settings")
    }
}
