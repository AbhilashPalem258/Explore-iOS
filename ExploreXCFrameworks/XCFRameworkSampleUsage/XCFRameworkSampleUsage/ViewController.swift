//
//  ViewController.swift
//  XCFRameworkSampleUsage
//
//  Created by Abhilash Palem on 08/09/22.
//

import UIKit
import iOSFramework

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let view: XIBLoadable = UIView() as! XIBLoadable
        view.load(from: "abhilash")
    }


}

