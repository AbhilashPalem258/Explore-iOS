//
//  NotificationService.swift
//  NotificationService
//
//  Created by Abhilash Palem on 08/10/22.
//

import UserNotifications
import CoreGraphics

//https://nshipster.com/temporary-files/

class NotificationService: UNNotificationServiceExtension {

    var contentHandler: ((UNNotificationContent) -> Void)?
    var bestAttemptContent: UNMutableNotificationContent?

    //Your didReceive(_:withContentHandler:) method has only about 30 seconds to modify the payload and call the provided completion handler.
    override func didReceive(_ request: UNNotificationRequest, withContentHandler contentHandler: @escaping (UNNotificationContent) -> Void) {
        self.contentHandler = contentHandler
        bestAttemptContent = (request.content.mutableCopy() as? UNMutableNotificationContent)
        
        guard let bestAttemptContent = bestAttemptContent else  { return }
        // Modify the notification content here...
        bestAttemptContent.title = "\(bestAttemptContent.title) [Modified]"
        
        guard let attachmentURL = bestAttemptContent.userInfo["attachment-url"] as? String else {
            contentHandler(bestAttemptContent)
            return
        }
        
        do {
            let imageData = try Data(contentsOf: URL(string: attachmentURL)!)
            guard let attachment = UNNotificationAttachment.tempDownload(imageFileIdentifier: "image.jpg", data: imageData, options: nil) else {
                contentHandler(bestAttemptContent)
                return
            }
            bestAttemptContent.attachments = [attachment]
            contentHandler(bestAttemptContent.copy() as! UNNotificationContent)
        } catch {
            contentHandler(bestAttemptContent)
            print("Unable to load data: \(error)")
        }
    }
    
    override func serviceExtensionTimeWillExpire() {
        // Called just before the extension will be terminated by the system.
        // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
        if let contentHandler = contentHandler, let bestAttemptContent =  bestAttemptContent {
            contentHandler(bestAttemptContent)
        }
    }

}
extension UNNotificationAttachment {
    static func download(imageFileIdentifier: String, data: Data, options: [NSObject : AnyObject]?)
        -> UNNotificationAttachment? {
            let fileManager = FileManager.default
            if let directory = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.chalo.app") {
                do {
                    let newDirectory = directory.appendingPathComponent("Images")
                    if !fileManager.fileExists(atPath: newDirectory.path) {
                        try? fileManager.createDirectory(at: newDirectory, withIntermediateDirectories: true, attributes: nil)
                    }
                    let fileURL = newDirectory.appendingPathComponent(imageFileIdentifier)
                    do {
                        try data.write(to: fileURL, options: [])
                    } catch {
                        print("Unable to load data: \(error)")
                    }
//                    let pref = UserDefaults(suiteName: "group.id.gits.notifserviceextension")
//                    pref?.set(data, forKey: "NOTIF_IMAGE")
//                    pref?.synchronize()
                    let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL, options: options)
                    return imageAttachment
                } catch let error {
                    print("Error: \(error)")
                }
            }
            return nil
    }
    
    //https://www.raywenderlich.com/8277640-push-notifications-tutorial-for-ios-rich-push-notifications
    //https://nshipster.com/temporary-files/
    //https://stackoverflow.com/questions/43908745/does-ios-deletes-nstemporarydirectory-files-when-app-is-running-in-the-backgroun#:~:text=No%2C%20NSTemporaryDirectory%20will%20not%20get,NSTemporaryDirectory%20get%20cleared%20or%20deleted.
    static func tempDownload(imageFileIdentifier: String, data: Data, options: [NSObject : AnyObject]?)
    -> UNNotificationAttachment? {
        let fileManager = FileManager.default
        let container = URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        let directoryPath = container.appendingPathComponent(ProcessInfo().globallyUniqueString, isDirectory: true)
        do {
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: true, attributes: nil)
            let fileURL = directoryPath.appendingPathComponent(imageFileIdentifier, isDirectory: false)
            try data.write(to: fileURL, options: .atomic)
            let imageAttachment = try UNNotificationAttachment.init(identifier: imageFileIdentifier, url: fileURL, options: options)
            return imageAttachment
        } catch {
            print("Unable to load data: \(error)")
        }
        return nil
    }
}
