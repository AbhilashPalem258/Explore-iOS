//
//  ViewController.swift
//  ExploreCorelocation
//
//  Created by Abhilash Palem on 26/09/21.
//

import UIKit


class ViewController: UIViewController {

    var locationmanager: LocationManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            locationmanager = try LocationManager()
        } catch {
            print("Failed to create location manager")
        }
    }


}

