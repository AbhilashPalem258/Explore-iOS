//
//  NotificationTestBasic.swift
//  Explore-XCTESTTests
//
//  Created by Abhilash Palem on 28/10/22.
//

import Foundation
import XCTest
@testable import Explore_XCTEST

class NotificationTestBasic: XCTestCase {
    func testNotification1() {
//        let expectation = XCTNSNotificationExpectation(name: .sendRefresh)
        let expectation = XCTNSNotificationExpectation(name: .sendRefresh, object: SendNotification.shared)
        expectation.handler = { notification in
            print(notification)
            return true
        }
        SendNotification.shared.sendNotification()
        wait(for: [expectation], timeout: 6.0)
    }
}
