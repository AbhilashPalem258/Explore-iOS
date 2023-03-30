//
//  SkipTests.swift
//  Explore-XCTESTTests
//
//  Created by Abhilash Palem on 29/10/22.
//

import XCTest

extension String: Error {}

class SkipTests: XCTestCase {
    
    func testXCTSkip() throws {
        try XCTSkip("Required API is not available")
//        XCTFail("Failure to mock test failure")
    }
    
    func testXCTSkipIf() throws {
        let skipTest = true
        try XCTSkipIf(skipTest, "Required API is not available")
        XCTFail("Failure to mock test failure")
    }
    
    // invesrion of XCTSkipIf
    func testXCTSkipUnless() throws {
        let skipTest = false
        try XCTSkipUnless(skipTest, "Skipping tests only until i is 5")
        XCTFail("Failure to mock test failure")
    }
}

