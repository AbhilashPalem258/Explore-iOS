//
//  AppDelegate.swift
//  Explore-AppLifeCycle
//
//  Created by Abhilash Palem on 02/03/23.
//

/*
 Source:
 https://manasaprema04.medium.com/application-life-cycle-in-ios-f7365d8c1636
 https://medium.com/@venki0119/role-of-uiapplicationmain-in-ios-app-launch-process-77a00b44ac9d
 https://swiftlyanand.medium.com/ios-application-launch-sequence-a13a267d1669
 
 Definition:
 
 Notes:
 - SpringBoard is the standard application that manages the iPhone’s home screen. Other tasks include starting WindowServer, launching and bootstrapping applications and setting some of the device’s settings on startup
 
 - During App launch, Once the initial setup like locating and loading app binary and linking required frameworks is done, the system must call into the binary code to start it running. But, what is the starting point? UIApplicationMain
 
 - @UIApplicationMain: it creates an entry point that calls UIApplicationMain to get the app started.
 
 - You are free to remove default @UIApplicationMain and substitute the main file. It can be Objective-C or Swift file. If you want to use a swift file, it should be named as main.swift.
 
 - You can explicitly opt out background execution by adding UIApplicationExitsOnSuspend key to application’s Info.plist file and setting its value to YES. When you opt out background state, app life cycles will be between the not running, inactive, and active states and never enters the background or suspended states.
 
 UIApplication:
 -  UIApplicationMain(_:_:_:_:) function. Among its other tasks, this function creates a singleton UIApplication object that you access using shared.
 
 - Your app’s application object handles the initial routing of incoming user events. It dispatches action messages forwarded to it by control objects (instances of the UIControl class) to appropriate target objects.
 */

import UIKit

/*
// Error @UIApplicationMain may only be used on 'class' declarations
@UIApplicationMain
*/
@main
struct AppEntry {
    static func main() {
        UIApplicationMain(
            CommandLine.argc,
            CommandLine.unsafeArgv,
            NSStringFromClass(MyApplication.self),
            NSStringFromClass(AppDelegate.self)
        )
    }
}

class MyApplication: UIApplication {
    override func sendEvent(_ event: UIEvent) {
        print("MyApplication | ReceivedEvent | \(event)")
        super.sendEvent(event)
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        print("Application | willFinishLaunchingWithOptions | \(application.applicationState) | \(String(describing: launchOptions))")
        return true
    }
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        print("Application | didFinishLaunchingWithOptions Before | \(application.applicationState)")
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
        self.window?.makeKeyAndVisible()
        print("Application | didFinishLaunchingWithOptions After | \(application.applicationState)")
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print("Application | applicationWillEnterForeground | \(application.applicationState)")
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("Application | applicationDidBecomeActive | \(application.applicationState)")
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        print("Application | applicationWillResignActive | \(application.applicationState)")
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        print("Application | applicationDidEnterBackground | \(application.applicationState)")
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        print("Application | applicationWillTerminate | \(application.applicationState)")
    }
}
extension UIApplication.State: CustomStringConvertible {
    public var description: String {
        switch self {
        case .active:
            return "Active"
        case .background:
            return "Background"
        case .inactive:
            return "In Active"
        @unknown default:
            return "UnKnown"
        }
    }
}
