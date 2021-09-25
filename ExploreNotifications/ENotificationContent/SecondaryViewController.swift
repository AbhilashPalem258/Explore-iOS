//
//  SecondaryViewController.swift
//  ENotificationContent
//
//  Created by Abhilash Palem on 16/09/21.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class SecondaryViewController: UIViewController, UNNotificationContentExtension {
    func didReceive(_ notification: UNNotification) {
        print("Received Notification \(notification)")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
