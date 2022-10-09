//
//  NotificationViewController.swift
//  TestCategory1Content
//
//  Created by Abhilash Palem on 09/10/22.
//

import UIKit
import UserNotifications
import UserNotificationsUI

/*
 Removed MainInterface from Info.plist and added GalleryVC as NSExtensionPrincipalClass
 */

extension GalleryVC: UNNotificationContentExtension {
    func didReceive(_ notification: UNNotification) {
        
    }
}
