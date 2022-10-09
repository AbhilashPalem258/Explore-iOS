//
//  ViewController.swift
//  Explore-XCCONFIG
//
//  Created by Abhilash Palem on 18/09/22.
//

import UIKit
/*
 Source:
 https://www.appcoda.com/xcconfig-guide/
 https://www.raywenderlich.com/21441177-building-your-app-using-build-configurations-and-xcconfig
 https://medium.com/@sandshell811/power-of-xcconfigs-in-xcode-2bba939f2ab2
 
 Definition:
 “An Xcode scheme defines a collection of targets to build, a configuration to use when building, and a collection of tests to execute.
 
 A target specifies a single product with its build settings and files. A target can be an app, extension, framework, iMessage app, App Clip and so on.
 Notes:
 -  $(inherited) values are referred from the included files, if any, and follow the precedence mentioned earlier. Similarly , if you inherit a system build setting in a configuration file, the resolved value will be set based on the precedence.
 */

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let label = UILabel()
        label.text = "BACKEND URL:  " + getInfoVal(key: "Backend URL") + "\n\n" + "CONSUMER KEY:  " + getInfoVal(key: "Consumer Key") + "\n\n" + "CONSUMER SECRET:  " + getInfoVal(key: "Consumer Secret")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        self.view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        [label.topAnchor.constraint(equalTo: self.view.topAnchor),
        label.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
        label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)].forEach {
            $0.isActive = true
        }
    }
    
    private func getInfoVal(key: String) -> String {
        return (Bundle.main.object(forInfoDictionaryKey: key) as? String)?.replacingOccurrences(of: "\\", with: "") ?? ""
    }
}

