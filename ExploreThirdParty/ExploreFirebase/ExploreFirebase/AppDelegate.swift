//
//  AppDelegate.swift
//  ExploreFirebase
//
//  Created by Abhilash Palem on 12/12/21.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = UIStoryboard.main.instantiateViewController(withIdentifier: String(describing: CrashlyticsViewController.self)) as! CrashlyticsViewController
        let navController = UINavigationController(rootViewController: vc)
        
        window = UIWindow()
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        return true
    }
}

