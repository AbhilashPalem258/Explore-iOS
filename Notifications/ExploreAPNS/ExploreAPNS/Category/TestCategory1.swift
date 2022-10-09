//
//  TestCategory1.swift
//  ExploreAPNS
//
//  Created by Abhilash Palem on 08/10/22.
//

import Foundation
import UserNotifications

enum CategoryID {
    static let testCategory1ID = "TestCategory1"
}

enum NotificationActionID {
    static let foregroundAction = "ForegroundActionID"
    static let destructiveAction = "DestructiveActionID"
}

enum CategoryFactory {

    static var testCategory1: UNNotificationCategory {
        
        let foregroundAction = UNNotificationAction(
            identifier: NotificationActionID.foregroundAction,
            title: "Foreground",
            options: [
                /*
                 The action causes the app to launch in the foreground.
                 - When the user selects an action containing this option, the system brings the app to the foreground, asking the user to unlock the device as needed. Use this option for actions that require the user to interact further with your app. Do not use this option simply to bring your app to the foreground.
                 */
                .foreground
            ],
            /*
             Creates an action icon by using a system symbol image.
             - systemImageName: The name of the system symbol image. Use the SF Symbols app to look up the names of system symbol images
             */
            icon: .init(systemImageName: "heart.fill")
        )
        
        let destructiveAction = UNNotificationAction(
            identifier: NotificationActionID.destructiveAction,
            title: "Destructive",
            options: [
                /*
                 The action performs a destructive task.
                 - Use this option for actions that delete user data or change the app irrevocably. The action button is displayed with special highlighting to indicate that it performs a destructive task.
                 - Only specifying .destructive option does not ask for authentication when device is locked
                 */
                .destructive,
                
                /*The action can be performed only on an unlocked device.
                - When the user selects an action with this option, the system prompts the user to unlock the device. After unlocking, the system notifies your app of the selected action. You might use option to perform actions that require accessing data that is encrypted while the device is locked. */
                .authenticationRequired
            ],
            /*
             Creates an action icon based on an image in your app’s bundle, preferably in an asset catalog
             */
            icon: .init(templateImageName: "paypal")
        )
        
        let category = UNNotificationCategory(
            identifier: CategoryID.testCategory1ID,
            actions: [
                foregroundAction,
                destructiveAction
            ],
            intentIdentifiers: [],
            
            //The placeholder text to display when the system disables notification previews for the app.
            hiddenPreviewsBodyPlaceholder: "Tap to see notification",
            
            categorySummaryFormat: "Test Category1 Summary",
            options: [
                //Send dismiss actions to the UNUserNotificationCenter object’s delegate for handling. When we swipe the notification in list and click on clear button it sends a callback to UNUserNotificationCenter object's delegate
                .customDismissAction,
                
                //Show the notification’s subtitle, even if the user has disabled notification previews for the app.
                .hiddenPreviewsShowSubtitle,
                
                //Show the notification’s title, even if the user has disabled notification previews for the app.
                .hiddenPreviewsShowTitle,
                
                //Allow CarPlay to display notifications of this type.
                .allowInCarPlay
            ]
        )
        return category
    }
    
}
