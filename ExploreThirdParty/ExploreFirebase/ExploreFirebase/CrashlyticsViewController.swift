//
//  ViewController.swift
//  ExploreFirebase
//
//  Created by Abhilash Palem on 12/12/21.
//

import UIKit
import FirebaseAnalytics
import FirebaseCrashlytics

enum CustomCrashlyticError: Error {
    case abhilashError
    case dupError
}


class CrashlyticsViewController: UIViewController {
    
    @IBAction func crashApp(sender: AnyObject) {
        let numbers = [1]
        print(numbers[2])
    }
    
    @IBAction func anotherCrashApp(sender: AnyObject) {
        let numbers = [1]
        print(numbers[2])
        Crashlytics.crashlytics().record(error: CustomCrashlyticError.dupError)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Crashlytics.crashlytics().setUserID("Abhilash UserID")
        Crashlytics.crashlytics().setCustomValue("Abhilash", forKey: "User")
//        Crashlytics.crashlytics().record(error: CustomCrashlyticError.abhilashError)
        Crashlytics.crashlytics().log("Abhilash log message")
        Analytics.setUserID("Abhilash UserId")
    }


}

