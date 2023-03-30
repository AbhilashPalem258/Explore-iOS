//
//  PerformanceTestUtility.swift
//  Explore-XCTEST
//
//  Created by Abhilash Palem on 27/10/22.
//

import Foundation

struct PerformanceTestUtility {
    func fakeLongrunningTask(seconds: TimeInterval) -> Bool {
        Thread.sleep(forTimeInterval: seconds)
        return true
    }
}
