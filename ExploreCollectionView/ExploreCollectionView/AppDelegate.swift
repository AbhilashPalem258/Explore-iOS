//
//  AppDelegate.swift
//  ExploreCollectionView
//
//  Created by Abhilash Palem on 27/12/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: String(describing: ViewController.self)) as! ViewController
        let navc = UINavigationController(rootViewController: iCodeCompositionalCollectionVC())
        window?.rootViewController = navc
        window?.makeKeyAndVisible()
        return true
    }
}

