//
//  Spotlight.swift
//  ExploreUserActivity
//
//  Created by Abhilash Palem on 03/03/23.
//
import CoreSpotlight
import UIKit

class Spotlight: UIViewController {
    let activity = NSUserActivity(activityType: "com.abhilashpalem.ExploreUserActivity.spotlight")
    
    lazy var attributes: CSSearchableItemAttributeSet = {
        let attr = CSSearchableItemAttributeSet(contentType: .text)
        attr.keywords = ["Abhilash", "Sandeep", "palem", "prabhu", "vijaya"]
        attr.title = "Spotlight UserActivity"
        attr.contentDescription = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat."
        attr.thumbnailURL = Bundle.main.url(forResource: "holi", withExtension: "jpg")
        return attr
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addDataToSpotlight()
    }
}
extension Spotlight {
    func addDataToSpotlight() {
        activity.title = "UserActivity #Title"
        activity.userInfo = Bundle.main.infoDictionary!
        activity.keywords = ["Abhilash", "Sandeep", "palem", "prabhu", "vijaya"]
        activity.contentAttributeSet = attributes
        activity.isEligibleForSearch = true
        activity.isEligibleForHandoff = false
        activity.becomeCurrent()
    }
}
