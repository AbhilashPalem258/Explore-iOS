//
//  AsyncTestBasic.swift
//  Explore-XCTESTTests
//
//  Created by Abhilash Palem on 26/10/22.
//

import Foundation
import XCTest
//https://gist.github.com/ole/efe13925abd8e8ea2c7926e9a3131abf

class AsyncTestBasic: XCTestCase {
    func testDownloadWebData() {
        let expectation = XCTestExpectation(description: "Download apple.com web page")
        print("Expectation description: \(expectation.expectationDescription)")
        
        // Fails if this expectaion is not fulfilled with specified number of times
        /*
         The number of times fulfill() must be called before the expectation is completely fulfilled.
         
         The value of expectedFulfillmentCount must be greater than 0. By default, expectations have an expectedFulfillmentCount of 1.
         
         Note: The value of expectedFulfillmentCount is ignored when isInverted is true.
         */
        expectation.expectedFulfillmentCount = 3
        
        /*
         Indicates that the expectation is not intended to happen.
         
         To check that a situation does not occur during testing, create an expectation that is fulfilled when the unexpected situation occurs, and set its isInverted property to true. Your test will fail immediately if the inverted expectation is fulfilled.
         */
//        expectation.isInverted = true
        
        let expectation2 = XCTestExpectation(description: "Expectation to test assert for over fulfilemnt failure")
        expectation2.expectedFulfillmentCount = 4
        expectation2.assertForOverFulfill = true
        
        let url = URL(string: "https://apple.com")!
        URLSession.shared.dataTask(with: url) { data, response, error in
            XCTAssertNotNil(data, "No data was Downloaded")
            
            //Faking Multiple fullfilment
            for i in 0..<3 {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i)) {
                    expectation.fulfill()
                }
            }
            
            for i in 0..<5 {
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(i)) {
                    expectation2.fulfill()
                }
            }
        }
        .resume()
        wait(for: [expectation, expectation2], timeout: 10.0)
    }
    
    func testKVOExpectation() throws {
        let ob = BlockOperation()
        ob.addExecutionBlock {
            print("Executed Block Operation")
        }
        let e = XCTKVOExpectation(keyPath: "isFinished", object: ob, expectedValue: true)
        let queue = OperationQueue()
        queue.addOperation(ob)
        wait(for: [e], timeout: 5)
        XCTAssertFalse(ob.isCancelled)
    }
}
