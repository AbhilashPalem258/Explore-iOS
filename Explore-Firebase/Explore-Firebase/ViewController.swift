//
//  ViewController.swift
//  Explore-Firebase
//
//  Created by Abhilash Palem on 19/09/22.
//

import UIKit
import FirebasePerformance

/*
 Source:
 
 Definition:
 Performance Monitoring collects traces to help you monitor the performance of your app. A trace is a report of performance data captured between two points in time in your app
 
 Notes:
 - Apple recommends the launch time to be around ~400ms
 - Empty project with firebase installed on test device is showing ~250ms
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .red
        
        let trace = Performance.startTrace(name: "CUSTOM_TRACE_NAME")

        trace?.setValue("A", forAttribute: "experiment")

        // Update scenario.
        trace?.setValue("B", forAttribute: "experiment")
        
        trace?.incrementMetric("EVENT_NAME", by: 1)

        // Reading scenario.
        let experimentValue:String? =  trace?.value(forAttribute: "experiment")
        print(experimentValue)
        
        trace?.stop()
    }


}

