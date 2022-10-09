//
//  NotificationViewController.swift
//  ENotificationContent
//
//  Created by Abhilash Palem on 16/09/21.
//

import UIKit
import UserNotifications
import UserNotificationsUI

/*
 link: https://gist.github.com/Hokila/9b929d4c49926d65f0e41bf12ffcada8
 */

/*
 To programmatically start or stop playback of your media file, call the current NSExtensionContext object’s mediaPlayingStarted() and mediaPlayingPaused() methods. Use your view controller’s extensionContext property to access the extension context.
 */

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    // 1
    var mediaPlayPauseButtonType: UNNotificationContentExtensionMediaPlayPauseButtonType {
      return .overlay
    }

    // 2
    var mediaPlayPauseButtonFrame: CGRect {
        return CGRect(x: self.view.frame.size.width/2 - 50/2, y: self.view.frame.size.height/2 - 50/2, width: 50, height: 50)
    }

    // 3
    var mediaPlayPauseButtonTintColor: UIColor {
      return .purple
    }
    
    func mediaPlay() {
        print("Media play")
    }
    
    func mediaPause() {
        print("Media pause")
    }
    
    override var canBecomeFirstResponder: Bool {
        // Need to become first responder to have custom input view.
        return true
    }
    
    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any required interface initialization here.
    }
    
    func didReceive(_ notification: UNNotification) {
        print("Notification selected: \(notification)")
        let defaults = UserDefaults.init(suiteName: "group.Abhilash.ExploreNotifications")
        print(defaults?.value(forKey: "name"))
        var count = 1
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            self.timeLabel.text = "\(count)"
            count += 1
        }
    }

    
    func didReceive(_ response: UNNotificationResponse, completionHandler completion: @escaping (UNNotificationContentExtensionResponseOption) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5), execute: {
            completion(.dismissAndForwardAction)
        })
    }
}
