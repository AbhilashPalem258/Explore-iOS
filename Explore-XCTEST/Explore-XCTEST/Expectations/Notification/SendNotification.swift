//
//  SendNotification.swift
//  Explore-XCTEST
//
//  Created by Abhilash Palem on 28/10/22.
//

import Foundation

class SendNotification {
    static let shared = SendNotification()
    private init(){}
    
    func sendNotification() {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            NotificationCenter.default.post(name: .sendRefresh, object: self)
        }
    }
}
