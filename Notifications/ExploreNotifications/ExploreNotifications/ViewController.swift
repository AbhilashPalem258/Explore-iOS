//
//  ViewController.swift
//  ExploreNotifications
//
//  Created by Abhilash Palem on 13/09/21.
//

import UIKit
import CoreLocation
import CoreMotion

class ViewController: UIViewController {
    
    let locationManager = CLLocationManager()
    
    static var directory: URL {
        get {
           return FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locationManager.delegate = self
        print("Library directory: \(ViewController.directory)")
        print(FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.Abhilash.ExploreNotifications"))
        let defaults = UserDefaults.init(suiteName: "group.Abhilash.ExploreNotifications")
        defaults?.setValue("Abhi", forKey: "name")
        sharedPreferencesPlistExists()
        let center = UNUserNotificationCenter.current()
        center.delegate = self
        center.requestAuthorization(options: [.alert, .badge, .sound, .providesAppNotificationSettings]) { granted, error in
            if granted {
                print("Notification Allowed")
                center.setNotificationCategories(Set([self.createMeetingInviteCategory()]))
                self.locationManager.requestWhenInUseAuthorization()
            } else {
                print("Notification restricted")
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    func createNotificationRequest() -> UNMutableNotificationContent {
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.subtitle = "Sub Title"
        content.body = "Body"
        content.badge = 12
        content.launchImageName = "cat.png"
        content.threadIdentifier = "ENThreadId"
        content.summaryArgument = "Abhilash Summary"
        content.userInfo = [
            "MeetingId": "123456",
            "RoomId": "201"
        ]
        content.sound = .defaultCriticalSound(withAudioVolume: 1.0)
        content.sound = UNNotificationSound(named: .init("ringtone.mp3"))
        
        let attachement = try! UNNotificationAttachment(identifier: UUID().uuidString, url: Bundle.main.url(forResource: "bun33s", withExtension: "mp4")!, options: [
            UNNotificationAttachmentOptionsThumbnailHiddenKey: 0,
            UNNotificationAttachmentOptionsThumbnailClippingRectKey: CGRect(x: 0, y: 0, width: 1.0, height: 1.0).dictionaryRepresentation
            , UNNotificationAttachmentOptionsThumbnailTimeKey: NSNumber(integerLiteral: 250)
        ])
        let secondAttachement = try! UNNotificationAttachment(identifier: UUID().uuidString, url: Bundle.main.url(forResource: "cat.png", withExtension: "")!, options: [
            UNNotificationAttachmentOptionsThumbnailHiddenKey: 0
            ,UNNotificationAttachmentOptionsThumbnailClippingRectKey: CGRect(x: 0.25, y: 0.25, width: 0.25, height: 0.25).dictionaryRepresentation
            //https://developer.apple.com/library/archive/documentation/FileManagement/Conceptual/understanding_utis/understand_utis_conc/understand_utis_conc.html For type to use in hint key
            ,UNNotificationAttachmentOptionsTypeHintKey: "public.png"
        ])
        print(attachement)
        content.attachments = [
            attachement,
//            secondAttachement,
        ]
        content.categoryIdentifier = "SampleCategoryIdentifier"
        
        return content
    }
    
    func createTriggerCondition() -> UNTimeIntervalNotificationTrigger {
        return UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
    }
    
    func sharedPreferencesPlistExists() -> Bool {
     
        var containerExists = false
     
        let sharedFileManager = FileManager.default
     
        /* 4b) "In macOS, a URL of the expected form is always returned, even if the app group is invalid, so be sure to test that you can access the underlying directory before attempting to use it." */
        let sharedContainerFolderURL = sharedFileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.Abhilash.ExploreNotifications")
        // 4c) Now we build a standard path ("Library/Preferences/")
        // to the preferences data store file (plist). Note
        // the format of the plist's name.
        let sharedContainerPrefsPlistURL = (sharedContainerFolderURL?.appendingPathComponent("Library/Preferences/group.Abhilash.ExploreNotifications.plist"))!
        // 4d) Try to read data from the preferences
        // plist file.
        let sharedContainerPrefsPlistData = try? Data(contentsOf: sharedContainerPrefsPlistURL)
        let pageContent = String(data: sharedContainerPrefsPlistData!, encoding: String.Encoding.utf8)
        // 4e) If the file exists...
        if let fileData = sharedContainerPrefsPlistData {
     
            // 4f) if the plist file has contents (bytes)...
            if fileData.count > 0 {
     
                // 4g) We know that the plist is valid.
                print(".plist file size: \(fileData.count)")
                containerExists = true
     
            }
     
        }
     
        return containerExists
     
    } // func sharedContainerExist
    
    
    func createLocationTrigger() -> UNLocationNotificationTrigger {
        let location = CLLocationCoordinate2D(latitude: 37.33182, longitude: -122.03118)
        let region = CLCircularRegion(center: location, radius: 2, identifier: UUID().uuidString)
        region.notifyOnEntry = true
        let trigger = UNLocationNotificationTrigger(region: region, repeats: false)
        return trigger
    }
    
    @available(iOS 15.0, *)
    func createMeetingInviteCategory() -> UNNotificationCategory {
        let acceptAction = UNNotificationAction(identifier: "ACCEPT_ACTION", title: "Accept", options: .authenticationRequired, icon: .init(systemImageName: "heart.fill"))
        let declineAction = UNNotificationAction(identifier: "DECLINE_ACTION", title: "Decline", options: .destructive)
        let editAction = UNTextInputNotificationAction(identifier: "EDIT_ACTION", title: "EDit title", options: .authenticationRequired, textInputButtonTitle: "Text input", textInputPlaceholder: "text input place holder")
        var category = UNNotificationCategory(identifier:  "SampleCategoryIdentifier", actions: [acceptAction, declineAction, editAction], intentIdentifiers: [], hiddenPreviewsBodyPlaceholder: "dddd", options: [.hiddenPreviewsShowSubtitle, .customDismissAction])
//        category.categorySummaryFormat = "Category Summary Format"
        return category
    }
    
    func createScheduledGroupNotifications() {
        for i in 1...10 {
            let content = UNMutableNotificationContent()
            content.title = "Title \(i) 💙"
            content.subtitle = "SubTitle \(i) ❤️"
            content.body = "Body \(i) 💚"
            
            content.categoryIdentifier = "SampleCategoryIdentifier"
            
            if i % 2 == 0 {
                content.threadIdentifier = "Thread even"
                content.summaryArgument = "Even"
                content.summaryArgumentCount = 201
            } else {
                content.threadIdentifier = "Thread odd"
                content.summaryArgument = "Odd"
                content.summaryArgumentCount = 301
            }
            
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                print("User notification request addition done with error \(error)")
            }
        }
    }
    
    
}
extension ViewController: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let request = response.notification.request
        let actionId = response.actionIdentifier
        let userInfo = request.content.userInfo
        print(userInfo)
        switch actionId {
        case "EDIT_ACTION":
            print("User Typed \(String(describing: (response as? UNTextInputNotificationResponse)?.userText))")
        default:
            print("Received Notification with response \(response)")
            break
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        print("Received response in foreground")
        completionHandler([.sound, .banner, .list, .badge])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        print("Called open settings for")
    }
}
extension ViewController: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedWhenInUse:
            UIApplication.shared.registerForRemoteNotifications()
            createScheduledGroupNotifications()
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4)) {[weak self] in
                self?.locationManager.startUpdatingLocation()
                if let content = self?.createNotificationRequest(),
                   let trigger = self?.createTriggerCondition() {
                   let request = UNNotificationRequest(identifier: "RequestId", content: content, trigger: trigger)
                    UNUserNotificationCenter.current().add(request) { error in
                        print("added notification with error \(String(describing: error))")
                    }
                }
            }
        default:
            break
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("latest location:", locations)
    }
}
