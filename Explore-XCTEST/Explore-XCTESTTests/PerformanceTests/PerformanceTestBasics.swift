//
//  PerformanceTestBasics.swift
//  Explore-XCTESTTests
//
//  Created by Abhilash Palem on 27/10/22.
//

import Foundation
import XCTest
@testable import Explore_XCTEST

/*
 Source:
 
 https://medium.com/xcblog/continuous-performance-testing-of-an-ios-apps-using-xctest-811df87fe227
 https://medium.com/square-corner-blog/measureblock-how-does-performance-testing-work-in-ios-c1424eceb208
 
 //Covers all XCTMetrics
 https://augmentedcode.io/2019/12/22/performance-testing-using-xctmetric/
 
 Definition:
 
 Where Is The Baseline Stored?
 Xcode stores your baselines within the project file package, under project.xcodeproj/xcshareddata/xcbaselines/.... This folder will contain one .plist listing all performance test settings for a given host machine+run target combination, and a Info.plist with a list of all host machines.
 
 measureBlock:
 - measureBlock runs your code block 10 times.
 - Compares standard deviation to a baseline.
 - Baseline is computed by Xcode but can be set by hand.
 - Baselines for your tests are stored in the .xcodeproj file but are both host machine and target device specific.
 
 Notes:
 - The measure block executes the code multiple time depending on the number of invocations set. The default value is ten, it means the block will run ten times
 - At the end of the execution, it calculates the average value that can be used as a baseline for the future test execution. We can also set the baseline value manually.
 */

class PerformanceTestBasic: XCTestCase {
    var performanceUtility = PerformanceTestUtility()
    lazy var testData: [Int] = {
        return (0..<100000).map{Int($0)}
    }()
    
    func testPerformnceInSeconds() {
//        self.measure {
//           XCTAssertTrue(performanceUtility.fakeLongrunningTask(seconds: 4))
//        }
        
        self.measure(metrics: [XCTClockMetric(), XCTCPUMetric(), XCTMemoryMetric()]) {
            XCTAssertTrue(performanceUtility.fakeLongrunningTask(seconds: 4))
        }
    }
    
    //https://www.avanderlee.com/optimization/measure-performance-code/
    func testForEachLoop() {
        var evenNumbers = [Int]()
        self.measure {
            testData.filter{$0 % 2 == 0}.forEach{evenNumbers.append($0)}
        }
    }
    
    func testForLoop() {
        var evenNumbers = [Int]()
        self.measure(metrics: [XCTMemoryMetric(), XCTClockMetric()]) {
            for num in testData {
                if num % 2 == 0 {
                    evenNumbers.append(num)
                }
            }
        }
//        self.measure {
//            for num in testData {
//                if num % 2 == 0 {
//                    evenNumbers.append(num)
//                }
//            }
//        }
    }
}
