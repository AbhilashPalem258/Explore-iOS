//
//  ViewController.swift
//  Explore-AppLifeCycle
//
//  Created by Abhilash Palem on 02/03/23.
//

import UIKit

class ViewController: UIViewController {
    
    let application = UIApplication.shared
    
    override func loadView() {
        super.loadView()
        print("ViewController | loadView | \(application.applicationState)")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("ViewController | viewDidLoad | \(application.applicationState)")
        view.backgroundColor = .magenta
        addObservers()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("ViewController | viewWillAppear | \(application.applicationState)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("ViewController | viewDidAppear | \(self.application.applicationState)")
    }

}
extension ViewController {
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(finishedLaunching), name: UIApplication.didFinishLaunchingNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(becameActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(resignedActive), name: UIApplication.willResignActiveNotification, object: nil)
        
        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { notification in
            print("ViewController | willEnterForegroundNotification | \(self.application.applicationState)")
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { notification in
            print("ViewController | didEnterBackgroundNotification | \(self.application.applicationState)")
        }
        
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { notification in
            print("ViewController | willTerminateNotification | \(self.application.applicationState)")
        }
    }
}
@objc
extension ViewController {
    func finishedLaunching() {
        print("ViewController | finishedLaunching | \(application.applicationState)")
    }
    
    func resignedActive() {
        print("ViewController | resignedActive | \(application.applicationState)")
    }
    
    func becameActive() {
        print("ViewController | becameActive | \(application.applicationState)")
    }
}
