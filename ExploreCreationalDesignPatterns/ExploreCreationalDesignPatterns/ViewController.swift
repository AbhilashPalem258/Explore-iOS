//
//  ViewController.swift
//  ExploreCreationalDesignPatterns
//
//  Created by Abhilash Palem on 20/09/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ShapeFactory(parent: self.view).createShape(shape: .circle).display()
    }


}

