//
//  KVOExpectationBasic.swift
//  Explore-XCTESTTests
//
//  Created by Abhilash Palem on 27/10/22.
//

import Foundation
import XCTest
@testable import Explore_XCTEST

class KVOExpectationBasic: XCTestCase {
    func testKVO1() {
        // System KVO of BlockOperation
        let obj = BlockOperation {
            print("Executing Block")
        }
        let expectation = keyValueObservingExpectation(for: obj, keyPath: "isFinished") { obj, info in
//            return info["new"] == true
            return (obj as? BlockOperation)!.isFinished
        }
//        let expectation = keyValueObservingExpectation(for: obj, keyPath: "isFinished", expectedValue: false)
        let queue = OperationQueue()
        queue.addOperation(obj)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testKVO2() {
        //Custom KVO
        let electionManager = Electionmanager()
        let person = electionManager.personObj
        let expectation = keyValueObservingExpectation(for: person, keyPath: "name") { obj, info in
            return (obj as? Person)!.name == "Abhilash Palem"
        }
        electionManager.fetchPersondetails()
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testCustomKVO1() {
        let obj = BlockOperation {
            print("Executing some operation")
        }
        let expectation = KVOExpectation(objectToObserve: obj, keypath: \.isFinished, expectedValue: true)
        let queue = OperationQueue()
        queue.addOperation(obj)
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testCustomKVO2() {
        let electionManager = Electionmanager()
        let personObj = electionManager.personObj
        let expectation = KVOExpectation(objectToObserve: personObj, keypath: \.name)
        electionManager.fetchPersondetails()
        wait(for: [expectation], timeout: 10.0)
    }
}
